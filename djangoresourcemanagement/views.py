import json

from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.core import serializers
from django.core.exceptions import PermissionDenied
from datetime import datetime
import pyexcel as p
import pyexcel_xls
import pyexcel_xlsx
import re
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from .models import *

from djangoresourcemanagement import HelperFunctions as helper


# Create your views here.
def search_page(request):
    return render(request, 'search.html')

def search_utility(request, query="", filters=""):
    query = query.replace('+', ' ')
    filters = filters.replace('+',' ')

    finalResponse = {
        'teams' : [],
        'projects' : [],
        'users' : []
    }
    teams = {"data" : "empty"}
    projects = {"data" : "empty"}
    users = {"data" : "empty"}

    if query == "":
        return {"null" : "empty"}
    if filters == "":
        teams = Teams.objects.filter(name__istartswith=query)
        projects = Projects.objects.filter(name__istartswith=query)
        if ' ' in query and len(query.split()) == 2:
            personsNames = query.split()
            users = list(
                Users.objects.filter(first_name__istartswith=personsNames[0], last_name__istartswith=personsNames[1]))
        else:
            users = list(Users.objects.filter(first_name__istartswith=query))

        for team in teams:
            finalResponse['teams'] += [{
                "id": team.id,
                "name": team.name,
                "short_desc": team.short_description,
                "member_count": team.squadmembers_set.count()
            }]
        for project in projects:
            finalResponse['projects'] += [{
                "id": project.id,
                "name": project.name,
                "short_desc": project.short_description,
                "team_count": Teams.objects.filter(team_projects=project).count()
            }]
        for user in users:
            teamsForUser = {'teams': []}
            scopeTeam = Teams.objects.filter(team_members=user)

            for teamInter in scopeTeam:
                teamsForUser['teams'] += [{
                    "id" : teamInter.id,
                    "name": teamInter.name,
                    "members": teamInter.squadmembers_set.count()
                }]
            finalResponse['users'] += [{
                "id": user.id,
                "name": user.first_name + " " + user.last_name,
                "position": user.position,
                "teams": teamsForUser['teams']
            }]

    if 'Teams' in filters:
        teams = Teams.objects.filter(name__istartswith=query)
        for team in teams:
            finalResponse['teams'] += [{
                "id": team.id,
                "name": team.name,
                "short_desc": team.short_description,
                "member_count": team.squadmembers_set.count()
            }]
    if 'Projects' in filters:
        projects = Projects.objects.filter(name__istartswith=query)
        for project in projects:
            finalResponse['projects'] += [{
                "id": project.id,
                "name": project.name,
                "short_desc": project.short_description,
                "team_count": Teams.objects.filter(team_projects=project).count()
            }]
    if 'Employees' in filters:
        users = ""
        if ' ' in query and len(query.split()) == 2:
            personsNames = query.split()
            users = Users.objects.filter(first_name__istartswith=personsNames[0], last_name__istartswith=personsNames[1])
        else:
            users = Users.objects.filter(first_name__istartswith=query)
        for user in users:
            teamsForUser = {'teams': []}
            scopeTeam = Teams.objects.filter(team_members=user)

            for teamInter in scopeTeam:
                teamsForUser['teams'] += [{
                    "id": teamInter.id,
                    "name": teamInter.name,
                    "members": teamInter.squadmembers_set.count()
                }]
            finalResponse['users'] += [{
                "id": user.id,
                "name": user.first_name + " " + user.last_name,
                "position": user.position,
                "teams": teamsForUser['teams']
            }]

    return JsonResponse(finalResponse, safe=False)

def nav(request):
    return render(request, 'nav.html')


def login_page(request):
    if request.user.is_authenticated:
        return redirect('profile')

    if request.method == 'POST':
        username = request.POST['login_username']
        password = request.POST['login_password']
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
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

        teamLeadTeams = Teams.objects.filter(leader=user)
        usersTeams = Teams.objects.filter(squadmembers__user=user)
        userProjects = Projects.objects.filter(teams__squadmembers__user=user)
        userProjectsOwner = Projects.objects.filter(project_owner=user)

        teamsAndTheirProjects = []
        for team_search in teamLeadTeams:
            projectsWithTeam = Projects.objects.filter(teams=team_search)
            if not projectsWithTeam.exists():
                continue
            interimTeam = { "team_name" : team_search.name, "projects" : []}
            for projects in projectsWithTeam:
                interimDict = {
                    "project_id" : projects.id,
                    "project_name" : projects.name
                }
                interimTeam["projects"] += [interimDict]
            teamsAndTheirProjects += [interimTeam]

        for team_search in usersTeams:
            projectsWithTeam = Projects.objects.filter(teams=team_search)
            print(projectsWithTeam)
            if not projectsWithTeam.exists():
                continue
            interimTeam = {"team_name": team_search.name, "projects": []}
            for projects in projectsWithTeam:
                interimDict = {
                    "project_id": projects.id,
                    "project_name": projects.name
                }
                interimTeam["projects"] += [interimDict]
            teamsAndTheirProjects += [interimTeam]

        # print(teamsAndTheirProjects)
        # print(usersTeams)

        return render(request, 'profile.html', {"profile_info": profile_info,"teamsandprojects" : teamsAndTheirProjects,"teamsForLead" : teamLeadTeams, "usersTeams": usersTeams, "userProjects": userProjects, "userProjectsOwned" : userProjectsOwner})

    else:
        return redirect('login')


def get_project_team(request,project_id):
    if request.user.is_authenticated:

        try:
            project = Projects.objects.get(id=project_id)
        except:
            return redirect("profile")

        teamsInTheProject = Teams.objects.filter(team_projects=project)
        if Users.objects.get(id=request.user.id).permission != 'MNGR':
            return redirect('profile')
        else:
            project = Projects.objects.get(id=project_id)
            teamsInTheProject = Teams.objects.filter(team_projects=project)
            if request.method == 'POST':
                project_name = request.POST['project_name']
                project_owner = request.POST['project_lead']
                shrt_desc = request.POST["short_description"]
                long_desc = request.POST["long_description"]
                project_type = request.POST["type"]
                projected_end = request.POST["projected_end_date"]
                project_start = request.POST["start_date"]
                teams_attached_list = request.POST.getlist("team_to_attach_id")
                teams_delete_attached_list = request.POST.getlist("team_to_delete_id")

                # if project_name == "" or project_owner == "" or shrt_desc == "" or long_desc == "" or project_type == "" or projected_end == "" or project_start == "":
                #     return render(request, 'edit_project.html', {'Fail': "Invalid input, Make sure all fields are input",'project': project, 'teams': teamsInTheProject})

                editedProject = Projects.objects.get(id=project_id)

                editedProject.name = project_name
                editedProject.project_owner = Users.objects.get(id=project_owner)
                editedProject.short_description = shrt_desc
                editedProject.description = long_desc
                editedProject.type = project_type
                editedProject.start_date = project_start
                editedProject.projected_end_date = projected_end
                editedProject.save()

                for team in teams_delete_attached_list:
                    project.teams_set.remove(team)

                for team in teams_attached_list:
                    currentTeam = Teams.objects.get(id=team)
                    currentTeam.team_projects.add(editedProject)

                project = Projects.objects.get(id=project_id)
                teamsInTheProject = Teams.objects.filter(team_projects=project)

                return render(request, 'edit_project.html', {'success': "Project " + editedProject.name + " Saved",'project': project, 'teams' : teamsInTheProject})

            return render(request, 'edit_project.html', {'project': project, 'teams' : teamsInTheProject})

    return redirect("login")

def logout_user(request):
    if request.user.is_authenticated:
        logout(request)
        return redirect('login')


def team(request):
    return render(request, 'team.html')


def get_teams(request):
    userInTeam = request.user
    squadMember = SquadMembers.objects.filter(user=userInTeam.id)

    usersTeams = []

    listOfTeams = Teams.objects.all()
    for team in listOfTeams:
        for squad in squadMember:
            if team.id == squad.team_id:
                if (not usersTeams.__contains__(team)):
                    usersTeams.append(team)

    jsonResponseData = {'response': []}
    for team in usersTeams:
        dictionary = {
            "value": team.name,
            "data": team.id
        }
        jsonResponseData['response'] += dictionary

    return usersTeams
    ##JsonResponse(jsonResponseData, safe=False)


def team_maker(request):
    if request.user.is_authenticated:
        if Users.objects.get(id=request.user.id).permission != 'MNGR':
            return redirect('profile')
        else:
            if request.method == 'POST':
                team_name = request.POST['team_name']
                team_leader = request.POST['team_lead']
                shrt_desc = request.POST["short_description"]
                long_desc = request.POST["long_description"]
                team_type = request.POST["type"]
                projects_list = request.POST.getlist("proj")
                squadmember_list = request.POST.getlist("personID")
                roles_to_squadmembers = request.POST.getlist("roles")

                if team_name == "" or team_leader == "" or shrt_desc == "" or long_desc == "" or team_type == "":
                    return render(request, 'team_maker.html', {'Fail': "Invalid input, Make sure all fields are input"})

                createdTeam = Teams(
                    name=team_name,
                    leader=Users.objects.get(id=team_leader),
                    short_description=shrt_desc,
                    description=long_desc,
                    type=team_type
                )
                createdTeam.save()

                if len(projects_list) != 0:
                    for project in projects_list:
                        createdTeam.team_projects.add(Projects.objects.get(id=project))

                if len(squadmember_list) != 0:
                    for member in squadmember_list:
                        squadEntity = SquadMembers(
                            user=Users.objects.get(id=member),
                            team=createdTeam,
                            role=Roles.objects.get(id=1),
                            description="Blank For Now"
                        )
                        squadEntity.save()

                return render(request, 'team_maker.html', {'success': "Team" + createdTeam.name + "Created"})

            return render(request, 'team_maker.html')

    return redirect("login")

def get_edit_team(request,team_id):
    if request.user.is_authenticated:

        members_and_roles = {
            'members': [],
        }
        try:
            team = Teams.objects.get(id=team_id)
        except:
            return redirect("profile")
        for member in team.team_members.all():
            members_and_roles['members'] += [{
                'member_id': member.id,
                'name': member.first_name + " " + member.last_name,
                'role_id': SquadMembers.objects.get(team=team, user=member).role.id,
                'role_name': SquadMembers.objects.get(team=team, user=member).role.name
            }]

        if Users.objects.get(id=request.user.id).permission != 'MNGR':
            return redirect('profile')
        else:
            if request.method == 'POST':
                team_name = request.POST['team_name']
                team_leader = request.POST['team_lead']
                shrt_desc = request.POST["short_description"]
                long_desc = request.POST["long_description"]
                team_type = request.POST["type"]
                projects_list = request.POST.getlist("proj")
                squadmember_list = request.POST.getlist("personID")
                roles_to_squadmembers = request.POST.getlist("roles")
                members_to_delete = request.POST.getlist("member_to_delete_id")
                projects_to_delete = request.POST.getlist("project_to_delete_id")

                # if team_name == "" or team_leader == "" or shrt_desc == "" or long_desc == "" or team_type == "" or len(
                #         projects_list) == 0 or len(squadmember_list) == 0:
                #     return render(request, 'edit_team.html', {'Fail': "Invalid input, Make sure all fields are input",
                #     'team': team, 'members_and_roles': members_and_roles})

                editedTeam = Teams.objects.get(id=team_id)

                editedTeam.name = team_name
                editedTeam.leader = Users.objects.get(id=team_leader)
                editedTeam.short_description = shrt_desc
                editedTeam.description = long_desc
                editedTeam.type = team_type
                editedTeam.save()


                for project in projects_list:
                    editedTeam.team_projects.add(Projects.objects.get(id=project))

                for member in squadmember_list:
                    squadMemberToAdd = SquadMembers(
                        user=Users.objects.get(id=member),
                        team=editedTeam,
                        role=Roles.objects.get(id=1),
                        description="Blank For Now"
                    )
                    squadMemberToAdd.save()

                # deletion of members
                for memberToDelete in members_to_delete:
                    squadEntity = SquadMembers.objects.get(user=memberToDelete,team=team)
                    squadEntity.delete()

                # deletion of projects
                for projectToDelete in projects_to_delete:
                    project = Projects.objects.get(id=projectToDelete)
                    project.teams_set.remove(team)

                members_and_roles = {
                    'members': [],
                }
                team = Teams.objects.get(id=team_id)
                for member in team.team_members.all():
                    members_and_roles['members'] += [{
                        'member_id': member.id,
                        'name': member.first_name + " " + member.last_name,
                        'role_id': SquadMembers.objects.get(team=team, user=member).role.id,
                        'role_name': SquadMembers.objects.get(team=team, user=member).role.name
                    }]

                return render(request, 'edit_team.html', {'success': "Team " + editedTeam.name + " Edited",
                                                          'team': team, 'members_and_roles': members_and_roles})

        return render(request, 'edit_team.html', {'team' : team, 'members_and_roles' : members_and_roles})

def project_maker(request):
    if request.user.is_authenticated:
        if Users.objects.get(id=request.user.id).permission != 'MNGR':
            return redirect('profile')
        else:
            if request.method == 'POST':
                project_name    = request.POST['project_name']
                project_owner   = request.POST['project_lead']
                shrt_desc       = request.POST["short_description"]
                long_desc       = request.POST["long_description"]
                project_type    = request.POST["type"]
                projected_end   = request.POST["projected_end_date"]
                project_start   = request.POST["start_date"]
                teams_attached_list = request.POST.getlist("team_to_attach_id")


                if project_name == "" or project_owner == "" or shrt_desc == "" or long_desc == "" or project_type == "" or projected_end == "" or project_start == "":
                        return render(request, 'project_maker.html', {'Fail': "Invalid input, Make sure all fields are input"})

                createdProject = Projects(
                    name=project_name,
                    project_owner=Users.objects.get(id=project_owner),
                    short_description=shrt_desc,
                    description=long_desc,
                    type=project_type,
                    start_date=project_start,
                    projected_end_date=projected_end
                )
                createdProject.save()

                for team in teams_attached_list:
                    currentTeam = Teams.objects.get(id=team)
                    currentTeam.team_projects.add(createdProject)

                return render(request, 'project_maker.html', {'success': "Project " + createdProject.name + " Created"})

            return render(request, 'project_maker.html')

    return redirect("login")

def get_skill_request(request):
    if request.user.is_authenticated and request.user.permission == "MNGR":
        user = request.user

        employees = []
        for u in Users.objects.all():
            if u.supervisor_id == user.id:
                employees.append(u)

        jsonResponseData = {"suggestions": []}
        for employee in employees:
            temp = 0
            for skill in UserToSkill.objects.all():
                if skill.skill_status == "PEN" and skill.user_id == employee.id:
                    temp = temp + 1

            dictionary = {
                "id": employee.id,
                "name": employee.first_name + " " + employee.last_name,
                "numOfRequests": temp
            }

            if temp > 0:
                jsonResponseData["suggestions"] += [dictionary]

        return JsonResponse(jsonResponseData, safe=False)

    return redirect("login")


def project(request):
    return render(request, 'project.html')


def get_projects(request):
    projectToSearch = request.GET['query']
    projectsOfInterest = []

    projectsOfInterest = list(Projects.objects.filter(name__icontains=projectToSearch))


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
        personsOfInterest = list(
            Users.objects.filter(first_name__istartswith=personsNames[0], last_name__istartswith=personsNames[1]))
    else:
        personsOfInterest = list(Users.objects.filter(first_name__istartswith=personToSearch))

    jsonResponseData = {"suggestions": []}
    for person in personsOfInterest:
        dictionary = {
            "value": person.first_name + " " + person.last_name,
            "data": person.id
        }
        jsonResponseData["suggestions"] += [dictionary]

    return JsonResponse(jsonResponseData, safe=False)

def get_teams_autocomplete(request):
    teamToSearch = request.GET['query']
    teamsOfInterest = []

    teamsOfInterest = list(Teams.objects.filter(name__istartswith=teamToSearch))

    jsonResponseData = {"suggestions": []}
    for team in teamsOfInterest:
        dictionary = {
            "value": team.name,
            "data": team.id
        }
        jsonResponseData["suggestions"] += [dictionary]

    return JsonResponse(jsonResponseData, safe=False)


def save_skills(request):
    newSkills = json.loads(request.body)
    for newSkill in newSkills['skills']:
        skillName = newSkill[0]
        skillLevel = newSkill[1]

        techSkill = TechSkill.objects.all().filter(name=skillName)

        techSkill = techSkill[0]

        profLevel = ProficiencyLevels.objects.all().filter(level_name=skillLevel)[0]

        # print(skill)
        # print(skill[0])
        # print(skill[1])
        newSkill = UserToSkill(
            skill=techSkill,
            user=request.user,
            proficiency=profLevel,
            skill_status='PEN',
        )
        newSkill.save()

    return render(request, 'skills.html')


def get_new_skills(request):
    jsonResposnseData = {"suggestions": []}

    user = request.user
    userSkillsList = UserToSkill.objects.all().filter(user=user)
    allSkillsList = TechSkill.objects.all()

    # I've tried this every way I can think of and am getting a non iterable object
    # for i in ProficiencyLevels.level_name.LEVELS:
    #  print(i[0])

    for userSkill in userSkillsList:
        if userSkill.skill_status == "App" or userSkill.skill_status == "Approved" or userSkill.skill_status == "PEN" or userSkill.skill_status == "Pending":
            allSkillsList = allSkillsList.exclude(name=userSkill.skill.name)

    for possibleNewSkill in allSkillsList:
        dictionary = {
            "skillName": possibleNewSkill.name
        }
        jsonResposnseData["suggestions"] += [dictionary]
    return JsonResponse(jsonResposnseData, safe='False')


def project(request):
    return render(request, 'project.html')


def skills(request):

    if not request.user.is_authenticated:
        raise PermissionDenied
    user = request.user
    # user = authenticate(request, username = 'marySm1th', password = 'cosc481w')
    # user = authenticate(request, username='jack123', password='cosc481w')

    login(request, user)
    if not request.user.is_authenticated:
        raise PermissionDenied

    user = request.user
    userSkillsList = UserToSkill.objects.all().filter(user=user)
    allSkillsList = TechSkill.objects.all()

    # I've tried this every way I can think of and am getting a non iterable object
    # for i in ProficiencyLevels.:
    #  print(i[0])

    for userSkill in userSkillsList:
        if userSkill.skill_status == "App" or userSkill.skill_status == "Approved" or userSkill.skill_status == "PEN" or userSkill.skill_status == "Pending":
            allSkillsList = allSkillsList.exclude(name=userSkill.skill.name)

    userskills = UserToSkill.objects.all().filter(user=request.user)

    return_skills = userskills


    #for row in userskills:
     #   return_skills.append((row.skill.name, row.proficiency.level_name, row.skill_status))


    if request.GET:
        if request.GET["success"][0] == "1":
            return render(request, 'skills.html', {'skills': return_skills, "newSkills": allSkillsList,
                                                   "message": "The skills were added successfully!"})

    return render(request, 'skills.html', {'skills': return_skills, "newSkills": allSkillsList})


def skill_acceptance(request):

    if not request.user.is_authenticated or not request.user.permission == "MNGR":
        raise PermissionDenied
    user = request.user
    successMessage = ""
    if request.POST:
        for key in request.POST.items():
            if not key[0] == 'csrfmiddlewaretoken' :
                #this looks weird but otherwise Django returns a single item even though it's a list
                if key[1] != '':
                    if key[0].isdigit():
                        skillToUpdate = UserToSkill.objects.get(id=int(key[0]))
                        skillToUpdate.skill_status = key[1]
                        skillToUpdate.save()
                    else:
                        usertoskill_id = key[0][0]
                        if len(UserToSkill.objects.filter(id=usertoskill_id)) == 0:
                            continue
                        if UserToSkill.objects.get(id=usertoskill_id).skill_status == "PEN":
                            continue
                        else:
                            skillToUpdate = UserToSkill.objects.get(id=int(usertoskill_id))
                            skillToUpdate.skill_status_reason = key[1]
                            skillToUpdate.save()

                successMessage = "Skills have been updated for users and saved"


    employees = []
    for u in Users.objects.all():
        if u.supervisor_id == user.id:
            employees.append(u)


    employeeNameAndSkills = []
    listOfPendingSkills = []
    users = Users.objects.filter(supervisor=user)
    for emp in users:
        empSkills = UserToSkill.objects.filter(user=emp, skill_status="PEN")
        if (len(empSkills) == 0): continue
        interim = {
            "emp_id" : emp.id,
            "emp_name" : emp.first_name + " " + emp.last_name,
            "skills" : empSkills
        }
        listOfPendingSkills += [interim]

    if successMessage is "":
        return render(request, 'skill_acceptance.html', {'pendingSkills' : listOfPendingSkills})
    else:
        return render(request, 'skill_acceptance.html', {'pendingSkills': listOfPendingSkills, 'successMessage': successMessage})


def import_users(request):
    # print(request.method)
    # print(request.FILES.keys())
    # Next three lines are for testing demo purposes, remove at deploy
    # user = authenticate(request, username = 'jack123', password = 'cosc481w')
    # user = authenticate(request, username='jimboTheBro', password='cosc481w')
    # login(request, user)
    RegexStrings = {
        'Password': '^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$',
        'Email': '\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b',
        'NumbersAndSpecialCharacters': "^.*[0-9<>%$].*$",
        'ValidDate': "^(0[1-9]|1[0-2])[-/](0[1-9]|[12][0-9]|3[01])[-/](18|19|20)\\d\\d$",
        'SpecialCharacters': '^.*[<>%$].*$',
        'LettersAndSpecialCharacters': '^.*[a-zA-Z<>%$].*$',

    }
    if not request.user.is_authenticated or request.user.permission == 'EMP' or request.user.permission == 'LEAD':
        raise PermissionDenied
    if request.method == 'POST' and 'userfile' in request.FILES:
        filename = request.FILES['userfile'].name
        extension = filename.split(".")[-1]
        content = request.FILES['userfile'].read()
        excel = p.get_array(file_type=extension, file_content=content)
        
        excel = helper.trimarray(excel)

        invalidindicies = []
        userdata = []
        #start loop counter at -1 to add at the start of each loop
        count = -1

        for row in excel:
            #checks to see if row is entirely empty, skips if true

            if not any(row):
                pass
            else:
                count += 1
                userdata.append([])
                if len(row) < 1 or row[0] == "":  # Username
                    invalidindicies.append((count + 1, 1, 'Username cannot be empty'))
                elif Users.objects.all().filter(username=row[0]).exists():
                    invalidindicies.append((count + 1, 1, "Username already exists"))
                else:
                    userdata[count].append(row[0])

                if (len(row) < 2 or row[1] == ""):  # Password
                    invalidindicies.append((count + 1, 2, 'Password cannot be empty'))
                elif not re.match(RegexStrings['Password'], str(row[1])):
                    invalidindicies.append((count + 1, 2,
                                            'Password must contain at least 8 characters, at least 1  uppercase letter 1 lower case letter and 1 number'))
                else:
                    userdata[count].append(row[1])

                if (len(row) < 3 or row[2] == ""):  # Email
                    invalidindicies.append((count + 1, 3, 'Email cannot be empty'))
                elif not re.match(RegexStrings['Email'], row[2]):
                    invalidindicies.append((count + 1, 3, "Email must be valid"))
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
                else:
                    if len(row[5]) == 9: #if date is one character short of a valid string, try it with a 0 added to the front
                        row[5] = '0' + row[5]
                    
                    if not re.match(RegexStrings['ValidDate'], row[5]):
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
        if invalidindicies == []:  # Checks for Errors
            for row in userdata:  # (username, email, work_email,  password, first_name, last_name, address, position, marital_status, rate, supervisor, mentor, hire_date, permission):
                if row[10] is not None:
                    row[10] = Users.objects.all().filter(username=row[10])[0]
                if row[11] is not None:
                    row[11] = Users.objects.all().filter(username=row[11])[0]
                if(row[5][2]=="-"):
                    django_date = row[5].split("-")
                else:
                    django_date = row[5].split("/")

                django_date_format = django_date[2] + '-' + django_date[0] + '-' + django_date[1] + ' 00:00'
                row[5] = django_date_format
                user = Users.objects.create_user(row[0], row[2], helper.create__valid_work_email(row[3] + row[4]),
                                                 row[1], row[3], row[4], row[6], row[7], row[8], row[9], row[10],
                                                 row[5], 'EMP')

                user.mentor.add(row[11])
                if user is not None:
                    success_users.append((user.username, user.work_email))

            return render(request, 'importusers.html', {'values': excel, 'Output': success_users, 'Success': True})

        return render(request, 'importusers.html', {'values': excel, 'Output': invalidindicies})
    else:
        return render(request, 'importusers.html', {'values': []})


def display_project(request, id):
    if request.user.is_authenticated:
        try:
            displayed_project = Projects.objects.get(id = id)
        except:
            return redirect('profile')
        owner = Users.objects.get(id=displayed_project.project_owner_id)
        projectsTeams = []

        for team in Teams.objects.all():
            for proj in team.team_projects.all():
                if proj.id == id:
                    if not projectsTeams.__contains__(team):
                        projectsTeams.append(team)

        information = {
            "name" : displayed_project.name,
            "owner": owner.first_name + " " + owner.last_name,
            "owner_id": owner.id,
            "id": displayed_project.id,
            "short_description": displayed_project.short_description,
            "description": displayed_project.description,
        }

        return render(request, 'project_display.html', {"info": information, "projectTeams": projectsTeams})

    return redirect('login')



def display_team(request, id):
    if request.user.is_authenticated:
        try:
            displayedTeam = Teams.objects.get(id=id)
        except:
            return redirect('profile')
        squadMembers = SquadMembers.objects.filter(team_id=displayedTeam.id)
        teamMembers = []
        doesContain = False
        teamProjects = []


        for x in squadMembers:
            if x.user_id == request.user.id:
                doesContain = True
            temp = Users.objects.get(id = x.user_id)
            if not teamMembers.__contains__(temp):
                teamMembers.append(temp)

        for p in displayedTeam.team_projects.all():
            teamProjects.append(p)

        if request.user.permission == 'MNGR' or displayedTeam.type == 'PUB' or doesContain:

            information = {
                "name": displayedTeam.name,
                "short_description": displayedTeam.short_description
            }

            # Name of Team
            # Short Description
            return render(request, 'display_team.html',
                          {"team_information": information, "teamMembers": teamMembers, "teamProjects": teamProjects})

        else:
            return redirect('profile')

    return redirect('login')

def display_user(request, id):
    if request.user.is_authenticated:
        try:
            displayeduser = Users.objects.get(id=id)
        except:
            return redirect('profile')


        usersSquads = SquadMembers.objects.filter(user_id=id)

        projID = []
        usersTeams = []
        userSkills = []
        usersProjects = {
            "project": []
        }

        for skill in UserToSkill.objects.all():
            if skill.user_id == id and skill.skill_status == "APP":
                userSkills.append(TechSkill.objects.get(id=skill.skill_id))


        for team in Teams.objects.all():
            for u in usersSquads:
                if team.id == u.team_id:
                    if not usersTeams.__contains__(team):
                        usersTeams.append(team)
                        for project in team.team_projects.all():
                            if not projID.__contains__(project.id):
                                projID.append(project.id)
                                usersProjects["project"] += [{
                                    "name": project.name,
                                    "id": project.id
                                }]

        information = {
            "name": displayeduser.first_name + " " + displayeduser.last_name,
            "email": displayeduser.email,
            "position": displayeduser.position,
            "address": displayeduser.address,
            "id": displayeduser.id
        }

       
        return render(request, 'user_display.html', {"profile_info": information, "usersTeams": usersTeams, "usersProjects":
        usersProjects, "usersSkills": userSkills})


    return redirect('login')

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
