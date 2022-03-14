from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.core import serializers
from django.core.exceptions import  PermissionDenied
import pyexcel as p
import pyexcel_xls, pyexcel_xlsx
import re
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from .models import *

from djangoresourcemanagement import HelperFunctions as helper
# Create your views here.

def login_page(request):
    if request.user.is_authenticated:
        return redirect('profile')

    if request.method == 'POST':
        username = request.POST['login_username']
        password = request.POST['login_password']
        user = authenticate(request, username=username, password=password)
        print("auth")
        if user is not None:
            login(request, user)
            print("log")
            return redirect('profile')
        else:
            messages.add_message(request, 50, 'Incorrect password or username')
            return render(request, 'login.html')

    return render(request, 'login.html')


def profile_page(request):
    user = request.user

    if user.is_authenticated:
        profile_info = {"first_name": user.first_name,
                        "last_name": user.last_name,
                        "position": user.position,
                        "permission": user.permission}
        return render(request, 'profile.html', profile_info)

    else:
        return redirect('login')


def logout_user(request):
    if request.user.is_authenticated:
        logout(request)
        return redirect('login')


def team(request):
    return render(request, 'team.html')

def team_maker(request):
    if request.user.is_authenticated:
        if Users.objects.get(id=request.user.id).permission != 'MNGR':
            return redirect('profile')
        else:
            if request.method == 'POST':
                print(request.POST)
                team_name = request.POST['team_name']
                team_leader = request.POST['team_lead']
                shrt_desc = request.POST["short_description"]
                long_desc = request.POST["long_description"]
                team_type = request.POST["type"]
                projects_list = request.POST.getlist("proj")
                squadmember_list = request.POST.getlist("personID")
                roles_to_squadmembers = request.POST.getlist("roles")

                if team_name == "" or team_leader == "" or shrt_desc == "" or long_desc == "" or team_type == "" or len(projects_list) == 0 or len(squadmember_list) == 0:
                    return render(request, 'team_maker.html', {'Fail': "Invalid input, Make sure all fields are input"})

                createdTeam = Teams(
                    name=team_name,
                    leader=Users.objects.get(id=team_leader),
                    short_description=shrt_desc,
                    description=long_desc,
                    type=team_type
                )
                createdTeam.save()

                for project in projects_list:
                    createdTeam.team_projects.add(Projects.objects.get(id=project))

                SquadMembers(user=Users.objects.get(id=team_leader),
                             team=createdTeam,
                             role=Roles.objects.get(id=1),
                             description="Blank For Now").save()

                for member in squadmember_list:
                    print(member)
                    squadEntity = SquadMembers(
                        user=Users.objects.get(id=member),
                        team=createdTeam,
                        role=Roles.objects.get(id=1),
                        description="Blank For Now"
                    )
                    squadEntity.save()
                    print(squadEntity)

                return render(request, 'team_maker.html', {'success': "Team" + createdTeam.name + "Created"})

            return render(request, 'team_maker.html')

    return redirect("login")


def get_skill_request(request):
    if request.user.is_authenticated and request.user.permission == "MNGR":
        user = request.user;

        employees = []
        for u in Users:
            if u.supervisor_id == user.id:
                employees.append(u)

        jsonResponseData = {"suggestions": []}
        for employee in employees:
            temp = 0
            for skill in UserToSkill:
                if skill.skill_status == "Pending" and skill.user_id == employee.id:
                    temp = temp + 1

            dictionary = {
                "id": employee.name,
                "numOfRequests": temp
            }

            if temp > 0:
                jsonResponseData["suggestions"] += [dictionary]

        return JsonResponse(jsonResponseData, safe=False)

    return redirect("login")


def get_projects(request):
    projectToSearch = request.GET['query']
    projectsOfInterest = []

    projectsOfInterest = list(Projects.objects.filter(name__icontains=projectToSearch))

    print(projectsOfInterest)

    jsonResponseData = {"suggestions": []}
    for project in projectsOfInterest:
        dictionary = {
            "value": project.name,
            "data": project.id
        }
        jsonResponseData["suggestions"] += [dictionary]

    return JsonResponse(jsonResponseData, safe=False)

def get_users(request):
    personToSearch = request.GET['query']
    personsOfInterest = []

    if ' ' in personToSearch:
        personsNames = personToSearch.split()
        personsOfInterest = list(Users.objects.filter(first_name__istartswith=personsNames[0],last_name__istartswith=personsNames[1]))
    else:
        personsOfInterest = list(Users.objects.filter(first_name__istartswith=personToSearch))

    print(personsOfInterest)

    jsonResponseData = {"suggestions" : []}
    for person in personsOfInterest:
        print(person.id)
        print(person.first_name)
        dictionary = {
                "value" : person.first_name + " " + person.last_name,
                "data" : person.id
            }
        jsonResponseData["suggestions"] += [dictionary]

    return JsonResponse(jsonResponseData, safe=False)

def project(request):
    return render(request, 'project.html')

def import_users(request):
    #print(request.method)
    #print(request.FILES.keys())
    # Next three lines are for testing demo purposes, remove at deploy
    user = authenticate(request, username = 'jack123', password = 'cosc481w')
    # user = authenticate(request, username='jimboTheBro', password='cosc481w')
    login(request, user)
    RegexStrings = {
        'Password' : '^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$',
        'Email' : '\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b',
        'NumbersAndSpecialCharacters' : "^.*[0-9<>%$].*$",
        'ValidDate' : "^(0[1-9]|1[0-2])[-/](0[1-9]|[12][0-9]|3[01])[-/](18|19|20)\\d\\d$",
        'SpecialCharacters' : '^.*[<>%$].*$',
        'LettersAndSpecialCharacters' : '^.*[a-zA-Z<>%$].*$',

    }
    if not request.user.is_authenticated or request.user.permission == 'EMP' or request.user.permission == 'LEAD':
        raise PermissionDenied
    if request.method == 'POST' and 'userfile' in request.FILES:
        print("got here")
        filename = request.FILES['userfile'].name
        extension = filename.split(".")[-1]
        content = request.FILES['userfile'].read()
        excel = p.get_array(file_type=extension, file_content=content)
        invalidindicies = []
        userdata =[]
        for count, row in enumerate(excel):
            userdata.append([])
            if len(row) < 1 or row[0] == "":                                            # Username
                invalidindicies.append((count + 1 , 1, 'Username cannot be empty'))
            elif Users.objects.all().filter(username=row[0]).exists():
                invalidindicies.append((count + 1, 1, "Username already exists"))
            else:
                userdata[count].append(row[0])

            if (len(row) < 2 or row[1] == ""):                                          # Password
                invalidindicies.append((count + 1, 2, 'Password cannot be empty'))
            elif not re.match(RegexStrings['Password'], str(row[1])):
                invalidindicies.append((count + 1,  2, 'Password must contain at least 8 characters, at least 1  uppercase letter 1 lower case letter and 1 number'))
            else:
                userdata[count].append(row[1])

            if (len(row) < 3 or row[2] == ""):                                          # Email
                invalidindicies.append((count + 1, 3, 'Email cannot be empty'))
            elif not re.match(RegexStrings['Email'], row[2]):
                invalidindicies.append((count + 1,  3, "Email must be valid"))
            elif Users.objects.all().filter(email=row[2]).exists():
                invalidindicies.append((count + 1, 3, "Email already exists"))
            else:
                userdata[count].append(row[2])

            if (len(row) < 4 or row[3] == ""):
                invalidindicies.append((count + 1, 4, 'First Name cannot be empty'))
            elif re.match(RegexStrings['NumbersAndSpecialCharacters'], row[3]):
                invalidindicies.append((count + 1, 4, "First Name cannot have numbers or <>%$"))
            else:
                userdata[count].append(row[3])

            if (len(row) < 5 or row[4] == ""):
                invalidindicies.append((count + 1, 4, 'Last Name cannot be empty'))
            elif re.match(RegexStrings['NumbersAndSpecialCharacters'], row[4]):
                invalidindicies.append((count + 1, 5, "Last name cannot have numbers or <>%$"))
            else:
                userdata[count].append(row[4])

            if (len(row) < 6 or row[5] == ""):
                invalidindicies.append((count + 1, 6, 'HireDate cannot be empty'))
            elif not re.match(RegexStrings['ValidDate'], row[5]):
                invalidindicies.append((count + 1, 6, 'Improperly formatted date, must be in mm-dd-yyyy or mm/dd/yyyy'))
            elif not helper.valid_date(row[5]):
                invalidindicies.append(count + 1, 6, "Date submitted is in correct format but invalid, (Eg. >32 days, 31 days in a month with 30, Before year 1800)")
            else:
                userdata[count].append(row[5])

            if (len(row) < 7 or row[6] == ""):
                userdata[count].append(None)
            elif re.match(RegexStrings['SpecialCharacters'], row[6]):
                invalidindicies.append((count + 1, 7, "Address cannot have <>%$"))
            else:
                userdata[count].append(row[6])

            if (len(row) < 8 or row[7] == ""):
                userdata[count].append(None)
            elif re.match(RegexStrings['NumbersAndSpecialCharacters'], row[7]):
                invalidindicies.append((count + 1, 8, "Position cannot have <>%$ or numbers"))
            else:
                userdata[count].append(row[7])

            if (len(row) < 9 or row[8] == ""):
                userdata[count].append(None)
            elif re.match(RegexStrings['NumbersAndSpecialCharacters'], row[8]):
                invalidindicies.append((count + 1, 9, "Marital Status cannot have numbers or <>%$"))
            else:
                userdata[count].append(row[8])

            if (len(row) < 10 or row[9] == ""):
                userdata[count].append(None)
            elif re.match(RegexStrings['LettersAndSpecialCharacters'], str(row[9])):
                invalidindicies.append((count + 1, 10, "Rate cannot have letters or <>%$"))
            else:
                userdata[count].append(row[9])

            if (len(row) < 11 or row[10] == ""):
                userdata[count].append(None)
            elif not Users.objects.all().filter(username=row[10]).exists():
                invalidindicies.append((count + 1, 11, "User by that username does not exist"))
            elif not Users.objects.all().filter(username=row[10])[0].permission == 'MNGR':
                invalidindicies.append((count + 1, 11, "Given user is not a Manager"))
            else:
                userdata[count].append(row[10])

            if (len(row) < 12 or row[11] == ""):
                userdata[count].append(None)
            elif not Users.objects.all().filter(username=row[11]).exists():
                invalidindicies.append((count + 1, 12, "User by that username does not exist"))
            else:
                userdata[count].append(row[11])

        success_users = []
        if invalidindicies == []:                                                   # Checks for Errors
            for row in userdata:               # (username, email, work_email,  password, first_name, last_name, address, position, marital_status, rate, supervisor, mentor, hire_date, permission):
                if row[10] is not None:
                    row[10] = Users.objects.all().filter(username=row[10])[0]
                if row[11] is not None:
                    row[11] = Users.objects.all().filter(username=row[11])[0]
                django_date = row[5].split("-")
                django_date_format = django_date[2] + '-' + django_date[0] + '-' + django_date[1] + ' 00:00'
                row[5] = django_date_format
                user = Users.objects.create_user(row[0], row[2], helper.create__valid_work_email(row[3] + row[4]), row[1], row[3], row[4], row[6], row[7], row[8], row[9], row[10], row[5], 'EMP')

                user.mentor.add(row[11])
                if user is not None:
                    success_users.append((user.username, user.work_email))

            return render(request,  'importusers.html', {'values': excel, 'Output': success_users, 'Success': True})

        return render(request,  'importusers.html', {'values': excel, 'Output': invalidindicies})
    else:
        return render(request, 'importusers.html', {'values': []})


# Username 0
# Password 1
# Email 2
# Work_email (Not putting in, creating from first name and last)
# first_name 3
# last_name 4
# hire_date 5
# address (null) 6
# position (null) 7
# marital_status (null) 8
# rate (null) 9
# supervisor (null) (Foreign) 10
# mentor (Foreign) 11
# date_joined Not read in from Excel
# last_login Not read in from Excel
#