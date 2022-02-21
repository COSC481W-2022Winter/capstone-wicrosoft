from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from .models import *


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


def project(request):
    return render(request, 'project.html')
