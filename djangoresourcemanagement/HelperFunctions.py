import datetime


def valid_date(date):
    date = date.split("-")

    try:
        datetime.datetime(day=date[1], month=date[0], year=date[2])
    except ValueError:
        return False

    return True
