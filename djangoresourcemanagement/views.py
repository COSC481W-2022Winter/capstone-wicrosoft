from django.shortcuts import render, redirect
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
    if request.method == 'POST' and 'userfile' in request.FILES:
        print("got here")
        filename = request.FILES['userfile'].name
        extension = filename.split(".")[-1]
        content = request.FILES['userfile'].read()
        excel = p.get_array(file_type=extension,file_content=content)
        invalidindicies =[]
        for count, row in enumerate(excel):
            if len(row) < 1 or row[0] == "":
                invalidindicies.append((count, 1, 'Cannot be empty'))
            elif Users.objects.all().filter(username=row[0]).exists():
                invalidindicies.append((count, 1, "Username already exists"))
            if (len(row) < 2 or row[1] == ""):
                invalidindicies.append((count, 2, 'Cannot be empty'))
            elif not re.match("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$", str(row[1])):
                invalidindicies.append((count,  2, 'Password must contain at least 8 characters, at least 1  uppercase letter 1 lower case letter and 1 number'))
            if (len(row) < 3 or row[2] == ""):
                invalidindicies.append((count, 3, 'Cannot be empty'))
            elif not re.match("\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b", row[2]):
                invalidindicies.append((count,  3, "Email must be valid"))
            if invalidindicies == []:
                return render(request,  'importusers.html', {'values': excel, 'Errors': ''})
        return render(request,  'importusers.html', {'values': excel, 'Errors':invalidindicies})
    else:
        return render(request, 'importusers.html',{'values': []})


