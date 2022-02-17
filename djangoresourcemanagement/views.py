from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from .models import *
# Create your views here.

def login_page(request):
    if request.user.is_authenticated:
        return redirect('profile')

    if request.method == 'POST':
        username = request.POST['login_username']
        password = request.POST['login_password']
        user = authenticate(request, username = username, password = password)
        print("auth")
        if user is not None:
            login(request, user)
            print("log")
            return redirect('profile')

    return render(request, 'login.html')

def profile_page(request):
    return render(request, 'profile.html')

def logout_user(request):
    if request.user.is_authenticated:
        logout(request)
        return redirect('login')

def team(request):
    return render(request, 'team.html')

def project(request):
    return render(request, 'project.html')
