# Generated by Django 3.0.5 on 2020-08-03 10:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('incubator', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='doctor',
            name='password',
            field=models.CharField(default='', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='doctor',
            name='username',
            field=models.CharField(default='', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='nurse',
            name='password',
            field=models.CharField(default='', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='nurse',
            name='username',
            field=models.CharField(default='', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='patient',
            name='password',
            field=models.CharField(default='', max_length=30),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='patient',
            name='username',
            field=models.CharField(default='', max_length=30),
            preserve_default=False,
        ),
    ]
