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
