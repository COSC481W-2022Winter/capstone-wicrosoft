# Generated by Django 4.0.2 on 2022-02-16 01:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('djangoresourcemanagement', '0004_alter_users_mentor_alter_users_supervisor'),
    ]

    operations = [
        migrations.AlterField(
            model_name='users',
            name='rate',
            field=models.DecimalField(decimal_places=2, max_digits=10, null=True),
        ),
    ]
