from django.shortcuts import render, redirect
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
