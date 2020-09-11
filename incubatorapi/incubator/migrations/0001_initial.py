# Generated by Django 3.0.5 on 2020-09-10 15:12

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Condition',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
                ('price', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Consumable',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('amount', models.FloatField()),
                ('price', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Extra',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('price', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Incubator',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
            ],
        ),
        migrations.CreateModel(
            name='Laboratory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('price', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Medicine',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('amount', models.FloatField()),
                ('price', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='ReportProblem',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('subject', models.CharField(max_length=200)),
                ('body', models.CharField(max_length=1000)),
                ('mailFrom', models.CharField(max_length=100)),
                ('mailTo', models.CharField(max_length=100)),
                ('status', models.CharField(max_length=20)),
                ('createdDate', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='Shift',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=2)),
                ('startTime', models.IntegerField()),
                ('isStartTimePM', models.BooleanField()),
                ('endTime', models.IntegerField()),
                ('isEndTimePM', models.BooleanField()),
            ],
        ),
        migrations.CreateModel(
            name='StateType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('userType', models.CharField(max_length=20)),
                ('email', models.CharField(max_length=200)),
                ('password', models.CharField(max_length=30)),
                ('provider', models.CharField(max_length=20)),
                ('phone', models.CharField(max_length=20)),
                ('createdDate', models.DateTimeField()),
            ],
        ),
        migrations.CreateModel(
            name='XRay',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=200)),
                ('price', models.FloatField()),
            ],
        ),
        migrations.CreateModel(
            name='Accountant',
            fields=[
                ('firstName', models.CharField(max_length=100)),
                ('lastName', models.CharField(max_length=100)),
                ('gender', models.BooleanField()),
                ('dateOfBirth', models.DateTimeField()),
                ('createdDate', models.DateTimeField()),
                ('userId', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='accoutantdetial', serialize=False, to='incubator.User')),
            ],
        ),
        migrations.CreateModel(
            name='Doctor',
            fields=[
                ('firstName', models.CharField(max_length=100)),
                ('lastName', models.CharField(max_length=100)),
                ('gender', models.BooleanField()),
                ('dateOfBirth', models.DateTimeField()),
                ('createdDate', models.DateTimeField()),
                ('userId', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='doctordetail', serialize=False, to='incubator.User')),
            ],
        ),
        migrations.CreateModel(
            name='Nurse',
            fields=[
                ('firstName', models.CharField(max_length=100)),
                ('lastName', models.CharField(max_length=100)),
                ('gender', models.BooleanField()),
                ('dateOfBirth', models.DateTimeField()),
                ('createdDate', models.DateTimeField()),
                ('userId', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='nursedetial', serialize=False, to='incubator.User')),
            ],
        ),
        migrations.CreateModel(
            name='Patient',
            fields=[
                ('motherName', models.CharField(max_length=100)),
                ('fatherName', models.CharField(max_length=100)),
                ('gender', models.BooleanField()),
                ('dateOfBirth', models.DateTimeField(auto_now=True)),
                ('address', models.CharField(max_length=500)),
                ('weight', models.FloatField()),
                ('ssn', models.CharField(max_length=100)),
                ('createdDate', models.DateTimeField(auto_now=True)),
                ('isOnLightRay', models.BooleanField()),
                ('userId', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='patientdetail', serialize=False, to='incubator.User')),
                ('conditionId', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='patients', to='incubator.Condition')),
                ('incubatorId', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='patients', to='incubator.Incubator')),
                ('stateTypeId', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, related_name='patients', to='incubator.StateType')),
            ],
        ),
        migrations.CreateModel(
            name='Status',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('heartRate', models.FloatField()),
                ('pulseRate', models.FloatField()),
                ('oxygen', models.FloatField()),
                ('weight', models.FloatField()),
                ('sugar', models.FloatField()),
                ('urine', models.FloatField()),
                ('stool', models.FloatField()),
                ('bloodPressure', models.FloatField()),
                ('temperature', models.FloatField()),
                ('incubatorTemperature', models.FloatField()),
                ('createdDate', models.DateTimeField()),
                ('nurseId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='nurse', to='incubator.Nurse')),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='status', to='incubator.Patient')),
            ],
        ),
        migrations.CreateModel(
            name='PatientXRay',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('comment', models.CharField(blank=True, max_length=500)),
                ('billStatus', models.CharField(blank=True, max_length=50)),
                ('createdDate', models.DateTimeField()),
                ('xRayId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='xraypatient', to='incubator.XRay')),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='patientxray', to='incubator.Patient')),
            ],
        ),
        migrations.CreateModel(
            name='PatientMedicineDoctor',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField()),
                ('description', models.CharField(blank=True, max_length=500)),
                ('date', models.DateTimeField()),
                ('billStatus', models.CharField(blank=True, max_length=50)),
                ('createdDate', models.DateTimeField()),
                ('medicineId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='medicinepatientdoctor', to='incubator.Medicine')),
                ('doctorId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='doctorpatientmedicine', to='incubator.Doctor')),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='patientmedicinedoctor', to='incubator.Patient')),
            ],
        ),
        migrations.CreateModel(
            name='PatientLaboratory',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('result', models.CharField(blank=True, max_length=500)),
                ('billStatus', models.CharField(blank=True, max_length=50)),
                ('createdDate', models.DateTimeField()),
                ('laboratoryId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='laboratorypatient', to='incubator.Laboratory')),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='patientlaboratory', to='incubator.Patient')),
            ],
        ),
        migrations.CreateModel(
            name='PatientExtra',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('billStatus', models.CharField(blank=True, max_length=50)),
                ('createdDate', models.DateTimeField()),
                ('extraId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='extrapatient', to='incubator.Extra')),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='patientextra', to='incubator.Patient')),
            ],
        ),
        migrations.CreateModel(
            name='PatientConsumableNurse',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField()),
                ('billStatus', models.CharField(blank=True, max_length=50)),
                ('createdDate', models.DateTimeField()),
                ('consumableId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='consumbalepatientnurse', to='incubator.Consumable')),
                ('nurseId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='nursepatientconsumable', to='incubator.Nurse')),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='patientconsumablenurse', to='incubator.Patient')),
            ],
        ),
        migrations.CreateModel(
            name='NurseShift',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('startDateTime', models.DateTimeField()),
                ('isSignedIn', models.BooleanField()),
                ('endDateTime', models.DateTimeField()),
                ('isSignedOut', models.BooleanField()),
                ('createdDate', models.DateTimeField()),
                ('changedDate', models.DateTimeField()),
                ('shiftId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='shiftnurse', to='incubator.Shift')),
                ('nurseId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='nurseshift', to='incubator.Nurse')),
            ],
        ),
        migrations.CreateModel(
            name='DoctorShift',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('startDateTime', models.DateTimeField()),
                ('isSignedIn', models.BooleanField()),
                ('endDateTime', models.DateTimeField()),
                ('isSignedOut', models.BooleanField()),
                ('createdDate', models.DateTimeField()),
                ('changedDate', models.DateTimeField()),
                ('shiftId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='shiftdoctor', to='incubator.Shift')),
                ('doctorId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='doctorshift', to='incubator.Doctor')),
            ],
        ),
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
        migrations.CreateModel(
            name='Bill',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateTimeField()),
                ('paid', models.FloatField()),
                ('dayCost', models.FloatField()),
                ('consumable', models.FloatField()),
                ('laboratory', models.FloatField()),
                ('xRay', models.FloatField()),
                ('lightRays', models.FloatField()),
                ('medicine', models.FloatField()),
                ('extra', models.FloatField()),
                ('discount', models.FloatField()),
                ('patientId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='bills', to='incubator.Patient')),
            ],
        ),
    ]
