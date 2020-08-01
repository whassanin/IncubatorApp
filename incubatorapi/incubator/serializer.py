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

class IncubatorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Incubator
        fields = ['id','name']

class ConditionSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Condition
        fields = ['colorId','cost',]

class BillExtraSerializer(serializers.ModelSerializer):
    class Meta: 
        model = BillExtra
        fields = ['billId','name','cost',]

class BillSerializer(serializers.ModelSerializer):
    billextra = BillExtraSerializer(many=True,read_only=True)
    class Meta: 
        model = Bill
        fields = [
            'id',
            'date',
            'paid',
            'dayCost',
            'staying',
            'incubatorClean',
            'consumable',
            'analysis',
            'xRay',
            'lightRays',
            'medicine',
            'patientId',
            'billextra'
            ]

class StatusSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = Status
        fields = [
            'id',
            'urine',
            'stool',
            'sugar',
            'weight',
            'pulse',
            'temperature',
            'incubatorTemperature',
            'createdDate',
            'patientId',
            'nurseId'
            ]

class PatientAnalysisSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = Status
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

class PatientPhoneSerializer(serializers.ModelSerializer):
    
    class Meta: 
        model = PatientPhone
        fields = [
            'id',
            'patientId',
            'phone',
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

class PatientSerializer(serializers.ModelSerializer):
    bills = BillSerializer(many=True,read_only=True)
    status = StatusSerializer(many=True,read_only=True)
    patientanalysis = PatientAnalysisSerializer(many=True,read_only=True)
    patientxray = PatientXRaySerializer(many=True,read_only=True)
    patientphone = PatientPhoneSerializer(many=True,read_only=True)
    patientconsumablenurse = PatientConsumableNurseSerializer(many=True,read_only=True)
    patientmedicinedoctor = PatientMedicineDoctorSerializer(many=True,read_only=True)
    class Meta: 
        model = Patient
        fields = [
        'motherName',
        'fatherName',
        'gender',
        'dateOfBirth',
        'address',
        'weight',
        'ssn',
        'createdDate',
        'conditionId',
        'incubatorId',
        'bills',
        'status',
        'patientanalysis',
        'patientxray',
        'patientphone',
        'patientmedicinedoctor',
        'patientconsumablenurse'
        ]

class AnalysisSerializer(serializers.ModelSerializer):

    class Meta: 
        model = Analysis
        fields = ['id','name']

class ConsumableSerializer(serializers.ModelSerializer):

    class Meta: 
        model = Consumable
        fields = ['id','name','amount']

class XRaySerializer(serializers.ModelSerializer):

    class Meta: 
        model = XRay
        fields = ['id','name']

class DoctorShiftSerializer(serializers.ModelSerializer):

    class Meta: 
        model = DoctorShift
        fields = ['id','doctorId','shiftId','createdDate']

class NurseShiftSerializer(serializers.ModelSerializer):

    class Meta: 
        model = NurseShift
        fields = ['id','nurseId','shiftId','createdDate']

class ShiftSerializer(serializers.ModelSerializer):
    shiftdoctor = DoctorShiftSerializer(many=True,read_only=True)
    shiftnurse = NurseShiftSerializer(many=True,read_only=True)
    class Meta: 
        model = Shift
        fields = ['id','startDate','endDate','shiftdoctor','shiftnurse']

class DoctorSerializer(serializers.ModelSerializer):
    doctorshift = DoctorShiftSerializer(many=True,read_only=True)
    class Meta: 
        model = Doctor
        fields = ['id','firstName','lastName','dateOfBirth','createdDate','doctorshift']

class NurseSerializer(serializers.ModelSerializer):
    nurseshift = NurseShiftSerializer(many=True,read_only=True)
    class Meta: 
        model = Nurse
        fields = ['id','firstName','lastName','dateOfBirth','createdDate','nurseshift']

class MedicineSerializer(serializers.ModelSerializer):

    class Meta: 
        model = Medicine
        fields = ['id','name','amount']

# create views from here
