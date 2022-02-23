from django.shortcuts import render, redirect
from django.core.exceptions import  PermissionDenied
import pyexcel as p
import pyexcel_xls, pyexcel_xlsx
import re
from django.contrib.auth import authenticate, login, logout
from .models import *
from djangoresourcemanagement import HelperFunctions as helper
# Create your views here.

def login_page(request):
    return render(request, 'login.html')

def profile_page(request):
    return render(request, 'profile.html')

def logout_user(request):
    return render(request, 'logout.html')

def team(request):
    return render(request, 'team.html')

def project(request):
    return render(request, 'project.html')

def import_users(request):
    print(request.method)
    print(request.FILES.keys())
    # Next three lines are for testing demo purposes, remove at deploy
    user = authenticate(request, username = 'jack123', password = 'cosc481w')
    # user = authenticate(request, username='jimboTheBro', password='cosc481w')
    login(request, user)
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
                invalidindicies.append((count, 1, 'Username cannot be empty'))
            elif Users.objects.all().filter(username=row[0]).exists():
                invalidindicies.append((count, 1, "Username already exists"))
            else:
                userdata[count].append(row[0])

            if (len(row) < 2 or row[1] == ""):                                          # Password
                invalidindicies.append((count, 2, 'Password cannot be empty'))
            elif not re.match("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$", str(row[1])):
                invalidindicies.append((count,  2, 'Password must contain at least 8 characters, at least 1  uppercase letter 1 lower case letter and 1 number'))
            else:
                userdata[count].append(row[1])

            if (len(row) < 3 or row[2] == ""):                                          # Email
                invalidindicies.append((count, 3, 'Email cannot be empty'))
            elif  not re.match("\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b", row[2]):
                invalidindicies.append((count,  3, "Email must be valid"))
            else:
                userdata[count].append(row[2])

            if (len(row) < 4 or row[3] == ""):
                invalidindicies.append((count, 4, 'First Name cannot be empty'))
            elif re.match("^[0-9<>%$]{2,}$", row[3]):
                invalidindicies.append((count, 4, "First Name cannot have numbers or <>%$"))
            else:
                userdata[count].append(row[3])

            if (len(row) < 5 or row[4] == ""):
                invalidindicies.append((count, 4, 'Last Name cannot be empty'))
            elif re.match("^[0-9<>%$]{2,}$", row[4]):
                invalidindicies.append((count, 5, "Last name cannot have numbers or <>%$"))
            else:
                userdata[count].append(row[4])

            if (len(row) < 6 or row[5] == ""):
                invalidindicies.append((count, 6, 'HireDate cannot be empty'))
            elif re.match("^(0[1-9]|1[0-2])[-](0[1-9]|[12][0-9]|3[01])[-](18|19|20)\\d\\d$", row[5]):
                invalidindicies.append((count, 6, 'Improperly formatted date, must be in mm-dd-yyyy'))
            elif not helper.valid_date(row[5]):
                invalidindicies.append(count, 6, "Date submitted is in correct format but invalid, (Eg. >32 days, 31 days in a month with 30, Before year 1800)")
            else:
                userdata[count].append(row[5])

            if (len(row) < 7 or row[6] == ""):
                userdata[count].append(None)
            elif re.match("^[<>%$]{2,}$", row[6]):
                invalidindicies.append((count, 7, "Address cannot have <>%$"))
            else:
                userdata[count].append(row[6])

            if (len(row) < 8 or row[7] == ""):
                userdata[count].append(None)
            elif re.match("^[0-9<>%$]{2,}$", row[7]):
                invalidindicies.append((count, 8, "Position cannot have <>%$ or numbers"))
            else:
                userdata[count].append(row[7])

            if (len(row) < 9 or row[8] == ""):
                userdata[count].append(None)
            elif re.match("^[0-9<>%$]{2,}$", row[8]):
                invalidindicies.append((count, 9, "Marital Status cannot have numbers or <>%$"))
            else:
                userdata[count].append(row[8])

            if (len(row) < 10 or row[9] == ""):
                userdata[count].append(None)
            elif re.match("^[a-zA-Z<>%$]{2,}$", row[9]):
                invalidindicies.append((count, 10, "Rate cannot have letters or <>%$"))
            else:
                userdata[count].append(row[9])

            if (len(row) < 11 or row[10] == ""):
                userdata[count].append(None)
            elif not Users.objects.all().filter(username=row[10]).exists():
                invalidindicies.append((count, 11, "User by that username does not exist"))
            elif Users.objects.all().filter(username=row[10])[0].permission == 'MNGR':
                invalidindicies.append((count, 11, "Given user is not a Manager"))
            else:
                userdata[count].append(row[10])

            if (len(row) < 12 or row[11] == ""):
                userdata[count].append(None)
            elif re.match("^[0-9<>%$]{2,}$", row[11]):
                invalidindicies.append((count, 12, "Mentor cannot have numbers or <>%$"))
            elif not Users.objects.all().filter(username=row[10]).exists():
                invalidindicies.append((count, 12, "User by that username does not exist"))
            else:
                userdata[count].append(row[11])

        if invalidindicies == []:                                                   # Checks for Errors
            for row in userdata:               # (username, email, work_email,  password, first_name, last_name, address, position, marital_status, rate, supervisor, mentor, hire_date, permission):
                user = Users.objects.create_user(row[0], row[2], row[3] + row[4] + '@wicrosoft.com', row[1], row[3], row[4], row[6], row[7], row[8], row[9], row[10], row[11], row[5], 'EMP')

            return render(request,  'importusers.html', {'values': excel, 'Errors': ''})

        return render(request,  'importusers.html', {'values': excel, 'Errors': invalidindicies})
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