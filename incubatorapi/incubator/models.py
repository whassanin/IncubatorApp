from django.db import models

# Create your models here.

# main tables

class Incubator(models.Model):
    name = models.CharField(max_length=200)

class Condition(models.Model):
    colorId = models.IntegerField()
    cost = models.FloatField()

class Patient(models.Model):
    motherName = models.CharField(max_length=100)
    fatherName = models.CharField(max_length=100)
    gender = models.BooleanField()
    dateOfBirth = models.DateTimeField(auto_now=True)
    address = models.CharField(max_length=500)
    weight = models.FloatField()
    ssn = models.CharField(max_length=100)
    createdDate = models.DateTimeField(auto_now=True)
    conditionId = models.ForeignKey(Condition,on_delete=models.DO_NOTHING)
    incubatorId = models.ForeignKey(Incubator,on_delete=models.DO_NOTHING)

class Analysis(models.Model):
    name = models.CharField(max_length=200)

class Bill(models.Model):
    date = models.DateTimeField(auto_now_add=True)
    paid = models.FloatField()
    daycost = models.FloatField()
    staying = models.FloatField()
    incubatorClean = models.FloatField()
    consumable = models.FloatField()
    analysis = models.FloatField()
    xRay = models.FloatField()
    lightRays = models.FloatField()
    medicine = models.FloatField()
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE)

class Consumable(models.Model):
    name = models.CharField(max_length=200)
    amount = models.FloatField()

class Doctor(models.Model): 
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    dateOfBirth = models.DateTimeField(auto_now=True)
    createdDate = models.DateTimeField(auto_now=True)

class Medicine(models.Model):
    name = models.CharField(max_length=200)
    amount = models.FloatField()

class Nurse(models.Model):
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    dateOfBirth = models.DateTimeField(auto_now=True)
    createdDate = models.DateTimeField(auto_now=True)

class XRay(models.Model):
    name = models.CharField(max_length=200)

class Shift(models.Model):
    startDate = models.DateTimeField(auto_now=True)
    endDate = models.DateTimeField()

# many to many

class DoctorShift(models.Model):
    doctorId = models.ForeignKey(Doctor,on_delete=models.CASCADE)
    shiftId = models.ForeignKey(Shift,on_delete=models.CASCADE)
    createdDate = models.DateTimeField(auto_now=True)

class NurseShift(models.Model):
    nurseId = models.ForeignKey(Doctor,on_delete=models.CASCADE)
    shiftId = models.ForeignKey(Shift,on_delete=models.CASCADE)
    createdDate = models.DateTimeField(auto_now=True)

class PatientAnalysis(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE)
    analysisId = models.ForeignKey(Analysis,on_delete=models.CASCADE)
    result = models.CharField(max_length=200)
    createdDate = models.DateTimeField(auto_now=True)

class PatientXRay(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE)
    xRayId = models.ForeignKey(XRay,on_delete=models.CASCADE)
    comment = models.CharField(max_length=200)
    createdDate = models.DateTimeField(auto_now=True)

class PatientConsumableNurse(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE)
    consumableId = models.ForeignKey(Consumable,on_delete=models.CASCADE)
    nurseId = models.ForeignKey(Nurse,on_delete=models.CASCADE)
    quantity = models.IntegerField()
    createdDate = models.DateTimeField(auto_now=True)

class PatientMedicineDoctor(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE)
    medicineId = models.ForeignKey(Medicine,on_delete=models.CASCADE)
    doctorId = models.ForeignKey(Doctor,on_delete=models.CASCADE)
    quantity = models.IntegerField()
    createdDate = models.DateTimeField(auto_now=True)


# Multi value

class PatientPhone(models.Model):
    patientId = models.ForeignKey(Patient,on_delete=models.CASCADE)
    phone = models.CharField(max_length=15)

class BillExtra(models.Model):
    billId = models.ForeignKey(Bill,on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    cost = models.FloatField()
