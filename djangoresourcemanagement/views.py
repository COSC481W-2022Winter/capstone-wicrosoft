from django.shortcuts import render, redirect
from django.http import JsonResponse
from django.core import serializers
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

def team_maker(request):
    return render(request, 'team_maker.html')

def get_users(request):
    personToSearch = request.GET['query']
    personOfInterest = [];

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

    print(jsonResponseData)



    return JsonResponse(jsonResponseData, safe=False)

def project(request):
    return render(request, 'project.html')
