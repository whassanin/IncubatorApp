from rest_framework import serializers
from incubator.models import Incubator
from incubator.models import Analysis
from incubator.models import Condition
from incubator.models import Patient
from incubator.models import Bill
from incubator.models import Status
from incubator.models import Consumable
from incubator.models import Doctor
from incubator.models import Medicine
from incubator.models import Nurse
from incubator.models import XRay
from incubator.models import Shift

from incubator.models import DoctorShift
from incubator.models import NurseShift
from incubator.models import PatientAnalysis
from incubator.models import PatientXRay
from incubator.models import PatientPhone
from incubator.models import BillExtra
from incubator.models import PatientMedicineDoctor
from incubator.models import PatientConsumableNurse

# multi-value serializer

class BillExtraSerializer(serializers.ModelSerializer):
    class Meta: 
        model = BillExtra
        fields = [
            'id',
            'billId',
            'name',
            'cost',
            ]

class PatientPhoneSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientPhone
        fields = [
            'id',
            'patientId',
            'phone',
            ]

# many to many serializers

class DoctorShiftSerializer(serializers.ModelSerializer):

    class Meta: 
        model = DoctorShift
        fields = ['id','doctorId','shiftId','createdDate']

class ShiftDoctorSerializer(serializers.ModelSerializer):

    class Meta: 
        model = DoctorShift
        fields = ['id','doctorId','shiftId','createdDate']


class NurseShiftSerializer(serializers.ModelSerializer):

    class Meta: 
        model = NurseShift
        fields = ['id','nurseId','shiftId','createdDate']

class ShiftNurseSerializer(serializers.ModelSerializer):

    class Meta: 
        model = NurseShift
        fields = ['id','nurseId','shiftId','createdDate']



class PatientAnalysisSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientAnalysis
        fields = [
            'id',
            'patientId',
            'analysisId',
            'result',
            'createdDate',
            ]

class AnalysisPatientSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientAnalysis
        fields = [
            'id',
            'patientId',
            'analysisId',
            'result',
            'createdDate',
            ]


class PatientXRaySerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientXRay
        fields = [
            'id',
            'patientId',
            'xRayId',
            'comment',
            'createdDate',
            ]

class XRayPatientSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientXRay
        fields = [
            'id',
            'patientId',
            'xRayId',
            'comment',
            'createdDate',
            ]


class PatientConsumableNurseSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientConsumableNurse
        fields = [
            'id',
            'patientId',
            'consumableId',
            'nurseId',
            'quantity',
            'createdDate',
            ]

class PatientMedicineDoctorSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientMedicineDoctor
        fields = [
            'id',
            'patientId',
            'medicineId',
            'doctorId',
            'quantity',
            'createdDate',
            ]


# 1 to many serializer

class StatusSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = Status
        fields = [
            'id',
            'heartRate',
            'pulseRate',
            'oxygen',
            'weight',
            'sugar',
            'urine',
            'stool',
            'bloodPressure',
            'temperature',
            'incubatorTemperature',
            'createdDate',
            'patientId',
            'nurseId'
            ]

class PatientSerializer(serializers.ModelSerializer):
    patientphone = PatientPhoneSerializer(many=True,read_only=True)
    status = StatusSerializer(many=True,read_only=True)
    class Meta: 
        model = Patient
        fields = [
        'id',
        'motherName',
        'fatherName',
        'gender',
        'dateOfBirth',
        'address',
        'weight',
        'ssn',
        'state',
        'username',
        'password',
        'createdDate',
        'conditionId',
        'incubatorId',
        'patientphone',
        'status'
        ]

class BillSerializer(serializers.ModelSerializer):
    billextra = BillExtraSerializer(many=True,read_only=True)
    class Meta: 
        model = Bill
        fields = [
            'id',
            'date',
            'paid',
            'dayCost',
            'incubatorClean',
            'consumable',
            'analysis',
            'xRay',
            'lightRays',
            'medicine',
            'patientId',
            'billextra'
            ]

# main serializers

# basic data
class IncubatorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Incubator
        fields = ['id','name']

class ConditionSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Condition
        fields = ['id','name','cost',]

class AnalysisSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Analysis
        fields = ['id','name','price']

class ConsumableSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Consumable
        fields = ['id','name','amount','price']

class MedicineSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Medicine
        fields = ['id','name','amount','price']

class XRaySerializer(serializers.ModelSerializer):
    class Meta: 
        model = XRay
        fields = ['id','name','price']

class ShiftSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Shift
        fields = ['id','name','startTime','isStarTimePM','endTime','isEndTimePM']

# non basic data

class DoctorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Doctor
        fields = ['id','firstName','lastName','gender','username','password','dateOfBirth','createdDate']

class NurseSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Nurse
        fields = ['id','firstName','lastName','gender','username','password','dateOfBirth','createdDate']
