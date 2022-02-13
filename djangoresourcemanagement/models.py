from django.db import models
from django.utils import timezone
from django.contrib.auth.models import BaseUserManager, AbstractBaseUser
# from datetime import date, datetime


# Standard user creation only, super and admin available
class AccountManager(BaseUserManager):
    def _create_user(self, username, email, password, first_name, last_name, is_staff, is_superuser):
        if not username:
            raise ValueError("Username Required")
        now = timezone.now()
        email = self.normalize_email(email)
        user = self.model(
            username=username,
            email=email,
            firstName=first_name,
            lastName=last_name,
            is_active=True,
            is_superuser=is_superuser,
            is_staff=is_staff,
            last_login=now,
            date_joined=now
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, username, email, password, first_name, last_name):
        return self._create_user(username, email, password, first_name, last_name, False, False)

    def create_superuser(self, username,  work_email, password):
        user = self._create_user(username, work_email, password, 'admin', 'superuser', True, True)
        return user


class Users(AbstractBaseUser):
    # no null availability, password to require password management
    username         = models.CharField(max_length=150)
    password         = models.CharField(max_length=150)
    email            = models.EmailField(max_length=150)
    work_email       = models.EmailField(max_length=60, unique=True, null=True)
    first_name       = models.CharField(max_length=50)
    last_name        = models.CharField(max_length=50)
    address          = models.CharField(max_length=250, null=True)
    position         = models.CharField(max_length=200, null=True)
    marital_status = models.CharField(max_length=150, null=True)
    rate             = models.DecimalField(max_digits=6, decimal_places=2, null=True)
    supervisor       = models.ForeignKey("Users", on_delete=models.CASCADE)
    mentor           = models.ManyToManyField("Users")
    hire_date        = models.DateTimeField()
    date_joined      = models.DateTimeField(auto_now_add=True)
    last_login       = models.DateTimeField(auto_now=True)
    user_project     = models.ManyToManyField("Projects")

    PERMISSIONS = [
        ('EMP', 'Employee'),
        ('LEAD', 'Team Lead'),
        ('MNGR', 'Manager'),
        ('SPRMGR', 'Super Manager'),
    ]
    permission = models.CharField(
        max_length=8,
        choices=PERMISSIONS,
        default='EMP'
    )

    # Abstract requirements
    is_admin        = models.BooleanField(default=False)
    is_staff        = models.BooleanField(default=False)
    is_superuser    = models.BooleanField(default=False)
    is_active       = models.BooleanField(default=True)

    objects = AccountManager()

    USERNAME_FIELD  = "username"
    REQUIRED_FIELDS = []

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.email

    def has_module_perms(self, app_label):
        return True


# Teams ---------------------------------------------------------------------

class SquadMembers(models.Model):
    user             = models.ForeignKey("Users", on_delete=models.SET_NULL, null=True)
    team             = models.ForeignKey("Teams", on_delete=models.SET_NULL, null=True)
    role             = models.ForeignKey("Roles", on_delete=models.SET_NULL, null=True)
    description      = models.CharField(max_length=150)
    is_active        = models.BooleanField(default=True)
    date_added       = models.DateTimeField(auto_now_add=True)

class Roles(models.Model):
    name                   = models.CharField(max_length=100)
    short_description      = models.CharField(max_length=100)
    long_description       = models.TextField()
    date_added             = models.DateTimeField(auto_now_add=True)

class Teams(models.Model):
    name                = models.CharField(max_length=150)
    leader              = models.ForeignKey("Users", on_delete=models.SET_NULL, null=True)
    short_description   = models.CharField(max_length=150)
    description         = models.TextField()
    team_creation_date  = models.DateTimeField(auto_now_add=True)
    is_active           = models.BooleanField(default=True)
    team_members = models.ManyToManyField(
        "Users",
        through="SquadMembers",
        through_fields=('team', 'user')
    )
    team_resources = models.ManyToManyField("Resources")
    team_announcements = models.ManyToManyField("Announcements")
    team_projects = models.ManyToManyField("Projects")
    TYPE = [
        ('PUB', 'Public'),
        ('PRI', 'Private'),
    ]
    type = models.CharField(
        max_length=3,
        choices=TYPE,
        default="PUB",
    )


class Announcements(models.Model):
    title                       = models.CharField(max_length=150)
    description                 = models.TextField()
    announcement_date           = models.DateTimeField()
    author                      = models.ForeignKey("Users", on_delete=models.SET_NULL, null=True)
    announcement_to_resource    = models.ManyToManyField("Resources")


# Skill ---------------------------------------------------------------------

class UserToSkill(models.Model):
    skill           = models.ForeignKey("TechSkill", on_delete=models.SET_NULL, null=True)
    user            = models.ForeignKey("Users", on_delete=models.SET_NULL, null=True)
    proficiency     = models.ForeignKey("ProficiencyLevels", on_delete=models.SET_NULL, null=True)
    date_added      = models.DateTimeField(auto_now_add=True)
    STATUS = [
        ('APP', "Approved"),
        ('PEN', "Pending"),
        ('REJ', "Rejected"),
    ]
    skill_status    = models.CharField(
        max_length=10,
        choices=STATUS,
        default = "PEN",
    )
    skill_status_reason = models.CharField(max_length=255)
    date_modified_status = models.DateTimeField()
    projects_that_show_experience_of_skill = models.ForeignKey("Projects", on_delete=models.SET_NULL, null=True)

class TechSkill(models.Model):
    name      = models.CharField(max_length=150)
    category        = models.CharField(max_length=255)
    domain          = models.CharField(max_length=255, null=True)
    description     = models.TextField()
    user_to_skill   = models.ManyToManyField(
        "Users",
        through="UserToSkill",
        through_fields=('skill', 'user')
    )


class ProficiencyLevels(models.Model):
    LEVELS = [
        ('BEG','Beginner'),
        ('INT','Intermediate'),
        ('ADV','Advanced'),
        ('EXP','Expert'),

    ]
    level_name = models.CharField(
        max_length=10,
        choices=LEVELS
        )
    description     = models.TextField()


# Project ---------------------------------------------------------------------

class Projects(models.Model):
    name                    = models.CharField(max_length=150)
    project_owner           = models.ForeignKey("Users", on_delete=models.SET_NULL, null=True)
    short_description       = models.CharField(max_length=150)
    description             = models.TextField()
    start_date              = models.DateTimeField()
    projected_end_date      = models.DateTimeField()
    actual_end_date         = models.DateTimeField(null=True)
    is_active                = models.BooleanField(default=True)
    project_to_announcement = models.ManyToManyField("Announcements")
    project_to_resource     = models.ManyToManyField("Resources")
    TYPE = [
        ('PUB', 'Public'),
        ('PRI', 'Private'),
    ]
    type = models.CharField(
        max_length=3,
        choices=TYPE,
        default="PUB",
    )


class Resources(models.Model):
    files = models.FileField(upload_to='resources/', null=True)
    title = models.CharField(max_length=255)
    text = models.TextField(null=True)
    link = models.URLField(null=True)
