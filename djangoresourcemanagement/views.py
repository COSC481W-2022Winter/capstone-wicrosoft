from django.shortcuts import render, redirect
from django.core.exceptions import  PermissionDenied
import pyexcel as p
import pyexcel_xls, pyexcel_xlsx
import re
from django.contrib.auth import authenticate, login, logout
from .models import *
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
        for count, row in enumerate(excel):
            if len(row) < 1 or row[0] == "":                                            # Username
                invalidindicies.append((count, 1, 'Cannot be empty'))
            elif Users.objects.all().filter(username=row[0]).exists():
                invalidindicies.append((count, 1, "Username already exists"))
            if (len(row) < 2 or row[1] == ""):                                          # Password
                invalidindicies.append((count, 2, 'Cannot be empty'))
            elif not re.match("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$", str(row[1])):
                invalidindicies.append((count,  2, 'Password must contain at least 8 characters, at least 1  uppercase letter 1 lower case letter and 1 number'))
            if (len(row) < 3 or row[2] == ""):                                          # Email
                invalidindicies.append((count, 3, 'Cannot be empty'))
            elif  not re.match("\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b", row[2]):
                invalidindicies.append((count,  3, "Email must be valid"))
            if (len(row) < 4 or row[3] == ""):
                invalidindicies.append((count, 4, 'First Name cannot be empty'))
            elif not re.match("^[^0-9<>%$]{2,}$", row[3]):
                invalidindicies.append((count, 4, "First Name cannot have numbers or <>%$"))
            if (len(row) < 5 or row[4] == ""):
                invalidindicies.append((count, 4, 'Last Name cannot be empty'))
            elif not re.match("^[^0-9<>%$]{2,}$", row[4]):
                invalidindicies.append((count, 5, "Last name cannot have numbers or <>%$"))
            if (len(row) < 6 or row[5] == ""):
                invalidindicies.append((count, 6, 'HireDate cannot be empty'))
            if row[6] == "":
                excel[count][6] = None
            if row[7] == "":
                excel[count][7] = None
            if row[8] == "":
                excel[count][8] = None
            if row[9] == "":
                excel[count][9] = None
            if row[10] == "":
                excel[count][10] = None
            if row[11] == "":
                excel[count][11] = None
            if row[12] == "":
                excel[count][12] = None
            if row[13] == "":
                excel[count][13] = None
        if invalidindicies == []:                                                   # Checks for Errors
            for row in excel:               # (username, email, work_email,                    password, first_name, last_name, address, position, marital_status, rate, supervisor, mentor, hire_date, permission):
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