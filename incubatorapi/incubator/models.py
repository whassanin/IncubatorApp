from django.db import models

# Create your models here.

# main tables

# basic data

# 1
class Incubator(models.Model):
    name = models.CharField(max_length=200)

# 2
class StateType(models.Model):
    name = models.CharField(max_length=20)

# 3
class Condition(models.Model):
    name = models.CharField(max_length=20)
    price = models.FloatField()

# 4
class Analysis(models.Model):
    name = models.CharField(max_length=200)
    price = models.FloatField()

# 5
class Extra(models.Model):
    name = models.CharField(max_length=200)
    price = models.FloatField()

# 6
class Consumable(models.Model):
    name = models.CharField(max_length=200)
    amount = models.FloatField()
    price = models.FloatField()

# 7
class Medicine(models.Model):
    name = models.CharField(max_length=200)
    amount = models.FloatField()
    price = models.FloatField()

# 8
class XRay(models.Model):
    name = models.CharField(max_length=200)
    price = models.FloatField()

# 9
class Shift(models.Model):
    name = models.CharField(max_length=2)
    startTime = models.IntegerField()
    isStartTimePM = models.BooleanField()
    endTime = models.IntegerField()
    isEndTimePM = models.BooleanField()

# non basic data

# 10
class ReportProblem(models.Model):
    subject = models.CharField(max_length=200)
    body = models.CharField(max_length=1000)
    mailFrom = models.CharField(max_length=100)
    mailTo = models.CharField(max_length=100)
    status = models.CharField(max_length=20)
    createdDate = models.DateTimeField()

# 11
class User(models.Model):
    userType = models.CharField(max_length=20)
    email = models.CharField(max_length=200)
    password = models.CharField(max_length=30)
    provider = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    createdDate = models.DateTimeField()

# 12
class Doctor(models.Model): 
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    gender = models.BooleanField()
    dateOfBirth = models.DateTimeField()
    createdDate = models.DateTimeField()
    userId = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True,related_name='doctordetail')

# 13
class Nurse(models.Model):
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    gender = models.BooleanField()
    dateOfBirth = models.DateTimeField()
    createdDate = models.DateTimeField()
    userId = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True,related_name='nursedetial')

# 14
class Accountant(models.Model):
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    gender = models.BooleanField()
    dateOfBirth = models.DateTimeField()
    createdDate = models.DateTimeField()
    userId = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True,related_name='accoutantdetial')

# 1 to many

# 15
class Patient(models.Model):
    motherName = models.CharField(max_length=100)
    fatherName = models.CharField(max_length=100)
    gender = models.BooleanField()
    dateOfBirth = models.DateTimeField(auto_now=True)
    address = models.CharField(max_length=500)
    weight = models.FloatField()
    ssn = models.CharField(max_length=100)
    createdDate = models.DateTimeField(auto_now=True)
    isOnLightRay = models.BooleanField()
    userId = models.OneToOneField(User,on_delete=models.CASCADE,primary_key=True,related_name='patientdetail')
    conditionId = models.ForeignKey(Condition,on_delete=models.DO_NOTHING,related_name='patients')
    stateTypeId = models.ForeignKey(StateType,on_delete=models.DO_NOTHING,related_name='patients')
    incubatorId = models.ForeignKey(Incubator,on_delete=models.DO_NOTHING,related_name='patients')

# 16
class Bill(models.Model):
    date = models.DateTimeField()
    paid = models.FloatField()
    dayCost = models.FloatField()
    consumable = models.FloatField()
    analysis = models.FloatField()
    xRay = models.FloatField()
    lightRays = models.FloatField()
    medicine = models.FloatField()
    extra = models.FloatField()
    discount = models.FloatField()
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='bills')

# 17
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
    createdDate = models.DateTimeField()
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='status')
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE,related_name='nurse')

# many to many

# 18
class DoctorShift(models.Model):
    doctorId = models.ForeignKey(Doctor,on_delete=models.CASCADE,related_name='doctorshift')
    shiftId = models.ForeignKey(Shift,on_delete=models.CASCADE,related_name='shiftdoctor')
    startDateTime = models.DateTimeField()
    isSignedIn = models.BooleanField()
    endDateTime = models.DateTimeField()
    isSignedOut = models.BooleanField()
    createdDate = models.DateTimeField()
    changedDate = models.DateTimeField()

# 19
class NurseShift(models.Model):
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE,related_name='nurseshift')
    shiftId = models.ForeignKey(Shift,on_delete=models.CASCADE,related_name='shiftnurse')
    startDateTime = models.DateTimeField()
    isSignedIn = models.BooleanField()
    endDateTime = models.DateTimeField()
    isSignedOut = models.BooleanField()
    createdDate = models.DateTimeField()    
    changedDate = models.DateTimeField()

# 20
class PatientAnalysis(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientanalysis')
    analysisId = models.ForeignKey(Analysis,on_delete=models.CASCADE,related_name='analysispatient')
    result = models.CharField(max_length=500,blank=True)
    billStatus = models.CharField(max_length=50,blank=True)
    createdDate = models.DateTimeField()

# 21
class PatientExtra(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientextra')
    extraId = models.ForeignKey(Extra,on_delete=models.CASCADE,related_name='extrapatient')
    billStatus = models.CharField(max_length=50,blank=True)
    createdDate = models.DateTimeField()

# 22
class PatientXRay(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientxray')
    xRayId = models.ForeignKey(XRay,on_delete=models.CASCADE,related_name='xraypatient')
    comment = models.CharField(max_length=500,blank=True)
    billStatus = models.CharField(max_length=50,blank=True)
    createdDate = models.DateTimeField()

# 23
class PatientConsumableNurse(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientconsumablenurse')
    consumableId = models.ForeignKey(Consumable,on_delete=models.CASCADE,related_name='consumbalepatientnurse')
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE,related_name='nursepatientconsumable')
    quantity = models.IntegerField()
    billStatus = models.CharField(max_length=50,blank=True)
    createdDate = models.DateTimeField()

# 24
class PatientMedicineDoctor(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='patientmedicinedoctor')
    medicineId = models.ForeignKey(Medicine,on_delete=models.CASCADE,related_name='medicinepatientdoctor')
    doctorId = models.ForeignKey(Doctor,on_delete=models.CASCADE,related_name='doctorpatientmedicine')
    quantity = models.IntegerField()
    description = models.CharField(max_length=500,blank=True)
    date = models.DateTimeField()
    billStatus = models.CharField(max_length=50,blank=True)
    createdDate = models.DateTimeField()

# Multi value

# 25
class CreditCard(models.Model):
    number = models.CharField(max_length=20)
    holder = models.CharField(max_length=150)
    expireYear = models.IntegerField()
    expireMonth = models.IntegerField()
    createdDate = models.DateTimeField()
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE,related_name='creditcards')