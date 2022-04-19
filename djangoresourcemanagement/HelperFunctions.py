import datetime
from .models import *
def trimarray(array):
    for i in range(len(array)):
        for j in range(len(array[i])):
            if type(array[i][j]) is not int:
                array[i][j] = array[i][j].strip()

    return array

def valid_date(date):

    if date[2]=="-":
        date = date.split("-")
    else:
        date = date.split("/")




    try:
        datetime.datetime(day=int(date[1]), month=int(date[0]), year=int(date[2]))
    except ValueError:
        return False

    return True


def create__valid_work_email(name):

    email = name + '@wicrosoft.com'

    if not Users.objects.all().filter(work_email=email).exists():

        return email

    counter = 1

    while counter != -1:

        email = name + str(counter) + '@wicrosoft.com'
        if not Users.objects.all().filter(work_email=email).exists():

            return email
        counter += 1
