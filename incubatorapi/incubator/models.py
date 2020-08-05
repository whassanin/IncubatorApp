from django.db import models

# Create your models here.

# main tables

# basic data

class Incubator(models.Model):
    name = models.CharField(max_length=200)

class Condition(models.Model):
    name = models.CharField(max_length=20)
    cost = models.FloatField()

class Analysis(models.Model):
    name = models.CharField(max_length=200)
    price = models.FloatField()

class Consumable(models.Model):
    name = models.CharField(max_length=200)
    amount = models.FloatField()
    price = models.FloatField()

class Medicine(models.Model):
    name = models.CharField(max_length=200)
    amount = models.FloatField()
    price = models.FloatField()

class XRay(models.Model):
    name = models.CharField(max_length=200)
    price = models.FloatField()

class Shift(models.Model):
    startDate = models.DateTimeField()
    endDate = models.DateTimeField()

# non basic data

class Doctor(models.Model): 
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    dateOfBirth = models.DateTimeField()
    username = models.CharField(max_length=30)
    password = models.CharField(max_length=30)
    createdDate = models.DateTimeField(auto_now=True)

class Nurse(models.Model):
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    dateOfBirth = models.DateTimeField()
    username = models.CharField(max_length=30)
    password = models.CharField(max_length=30)
    createdDate = models.DateTimeField(auto_now=True)

# 1 to many

class Patient(models.Model):
    motherName = models.CharField(max_length=100)
    fatherName = models.CharField(max_length=100)
    gender = models.BooleanField()
    dateOfBirth = models.DateTimeField(auto_now=True)
    address = models.CharField(max_length=500)
    weight = models.FloatField()
    ssn = models.CharField(max_length=100)
    username = models.CharField(max_length=30)
    password = models.CharField(max_length=30)
    state = models.CharField(max_length=30)
    createdDate = models.DateTimeField(auto_now=True)
    conditionId = models.ForeignKey(Condition,on_delete=models.DO_NOTHING,related_name='patients')
    incubatorId = models.ForeignKey(Incubator,on_delete=models.DO_NOTHING,related_name='patients')

class Bill(models.Model):
    date = models.DateTimeField()
    paid = models.FloatField()
    dayCost = models.FloatField()
    incubatorClean = models.FloatField()
    consumable = models.FloatField()
    analysis = models.FloatField()
    xRay = models.FloatField()
    lightRays = models.FloatField()
    medicine = models.FloatField()
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='bills')

class Status(models.Model):
    heartRate = models.FloatField()
    pulseRate = models.FloatField()
    oxygen = models.FloatField()
    weight = models.FloatField()
    sugar = models.FloatField()
    urine = models.FloatField()
    stool = models.FloatField()
    bloodPressure = models.FloatField()
    temperature = models.FloatField()
    incubatorTemperature = models.FloatField()
    createdDate = models.DateTimeField(auto_now=True)
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='status')
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE,related_name='nurse')

# many to many

class DoctorShift(models.Model):
    doctorId = models.ForeignKey(Doctor,on_delete=models.CASCADE,related_name='doctorshift')
    shiftId = models.ForeignKey(Shift,on_delete=models.CASCADE,related_name='shiftdoctor')
    createdDate = models.DateTimeField(auto_now=True)

class NurseShift(models.Model):
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE,related_name='nurseshift')
    shiftId = models.ForeignKey(Shift,on_delete=models.CASCADE,related_name='shiftnurse')
    createdDate = models.DateTimeField(auto_now=True)

class PatientAnalysis(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientanalysis')
    analysisId = models.ForeignKey(Analysis,on_delete=models.CASCADE,related_name='analysispatient')
    result = models.CharField(max_length=200)
    createdDate = models.DateTimeField(auto_now=True)

class PatientXRay(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientxray')
    xRayId = models.ForeignKey(XRay,on_delete=models.CASCADE,related_name='xraypatient')
    comment = models.CharField(max_length=200)
    createdDate = models.DateTimeField(auto_now=True)

class PatientConsumableNurse(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientconsumablenurse')
    consumableId = models.ForeignKey(Consumable,on_delete=models.CASCADE,related_name='consumbalepatientnurse')
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE,related_name='nursepatientconsumable')
    quantity = models.IntegerField()
    createdDate = models.DateTimeField(auto_now=True)

class PatientMedicineDoctor(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientmedicinedoctor')
    medicineId = models.ForeignKey(Medicine,on_delete=models.CASCADE,related_name='medicinepatientdoctor')
    doctorId = models.ForeignKey(Doctor,on_delete=models.CASCADE,related_name='doctorpatientmedicine')
    quantity = models.IntegerField()
    createdDate = models.DateTimeField(auto_now=True)

# Multi value

class PatientPhone(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientphone')
    phone = models.CharField(max_length=15)

class BillExtra(models.Model):
    billId = models.ForeignKey(Bill,on_delete=models.CASCADE,related_name='billextra')
    name = models.CharField(max_length=100)
    cost = models.FloatField()
