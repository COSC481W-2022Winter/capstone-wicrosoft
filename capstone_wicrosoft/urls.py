"""capstone_wicrosoft URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from djangoresourcemanagement import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', views.login_page, name='login'),
    path('logout/', views.logout_user, name='logout'),
    path('profile/', views.profile_page, name='profile'),
    path('team/', views.team, name='team'),
    path('teammaker/', views.team_maker, name='teammaker'),
    path('teammaker/get_users/', views.get_users),
    path('teammaker/get_projects/', views.get_projects),
    path('teammaker/edit/<int:team_id>', views.get_edit_team),
    path('project/', views.project, name='project'),
    path('importusers/', views.import_users, name='import'),
    path('skills/', views.skills, name='skills'),
    path('skills/success<int:num>', views.skills),
    path('skills/get_new_skills/', views.get_new_skills),
    path('skills/save_skills/', views.save_skills),
    path('nav/', views.nav),
    path('getNotifications', views.get_skill_request),
]
