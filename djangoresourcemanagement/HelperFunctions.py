import datetime
from .models import *


def valid_date(date):
    date = date.split("-")

    try:
        datetime.datetime(day=int(date[1]), month=int(date[0]), year=int(date[2]))
    except ValueError:
        return False

    return True


def create__valid_work_email(name):

    email = name + '@wicrosoft.com'
    if not Users.objects.all().filter(work_email='email').exists():
        return email

    counter = 1

    while counter != -1:
        email = name + counter + '@wicrosoft.com'
        if not Users.objects.all().filter(work_email='email').exists():
            return email
        counter += 1
