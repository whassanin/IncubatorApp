# Generated by Django 3.0.5 on 2020-08-25 06:36

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('incubator', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='CreditCard',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('number', models.CharField(max_length=20)),
                ('holder', models.CharField(max_length=150)),
                ('expireYear', models.IntegerField()),
                ('expireMonth', models.IntegerField()),
                ('createdDate', models.DateTimeField()),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='creditcards', to='incubator.Patient')),
            ],
        ),
    ]