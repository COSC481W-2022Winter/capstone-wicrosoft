import datetime


def valid_date(date):
    date = date.split("-")

    try:
        datetime.datetime(day=int(date[1]), month=int(date[0]), year=int(date[2]))
    except ValueError:
        return False

    return True
