from rest_framework import serializers

from incubator.models import User
from incubator.models import Incubator
from incubator.models import StateType
from incubator.models import Laboratory
from incubator.models import Condition
from incubator.models import Patient
from incubator.models import Extra
from incubator.models import Bill
from incubator.models import Status
from incubator.models import Consumable
from incubator.models import Accountant
from incubator.models import Doctor
from incubator.models import Medicine
from incubator.models import Nurse
from incubator.models import XRay
from incubator.models import Shift
from incubator.models import ReportProblem

from incubator.models import DoctorShift
from incubator.models import NurseShift
from incubator.models import PatientLaboratory
from incubator.models import PatientExtra
from incubator.models import PatientXRay
from incubator.models import CreditCard
from incubator.models import PatientMedicineDoctor
from incubator.models import PatientConsumableNurse

# multi-value serializer

class CreditCardSerializer(serializers.ModelSerializer):
    class Meta:
        model = CreditCard
        fields = [
            'id',
            'number',
            'holder',
            'expireYear',
            'expireMonth',
            'createdDate',
            'patientId'
        ]

# many to many serializers

class DoctorShiftSerializer(serializers.ModelSerializer):

    class Meta:
        model = DoctorShift
        fields = [
            'id',
            'doctorId',
            'shiftId',
            'startDateTime',
            'isSignedIn',
            'endDateTime',
            'isSignedOut',
            'createdDate',
            'changedDate'
        ]


class NurseShiftSerializer(serializers.ModelSerializer):

    class Meta:
        model = NurseShift
        fields = [
            'id',
            'nurseId',
            'shiftId',
            'startDateTime',
            'isSignedIn',
            'endDateTime',
            'isSignedOut',
            'createdDate',
            'changedDate'
        ]


class PatientLaboratorySerializer(serializers.ModelSerializer):

    class Meta:
        model = PatientLaboratory
        fields = [
            'id',
            'patientId',
            'laboratoryId',
            'result',
            'createdDate',
        ]


class PatientExtraSerializer(serializers.ModelSerializer):

    class Meta:
        model = PatientExtra
        fields = [
            'id',
            'patientId',
            'extraId',
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
            'description',
            'date',
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


class BillSerializer(serializers.ModelSerializer):

    class Meta:
        model = Bill
        fields = [
            'id',
            'date',
            'paid',
            'dayCost',
            'consumable',
            'laboratory',
            'xRay',
            'lightRays',
            'medicine',
            'extra',
            'discount',
            'patientId',
        ]


class PatientSerializer(serializers.ModelSerializer):
    status = serializers.SerializerMethodField()
    bills = serializers.SerializerMethodField()
    patientlaboratory = serializers.SerializerMethodField()
    patientxray = serializers.SerializerMethodField()
    patientconsumablenurse = serializers.SerializerMethodField()
    patientmedicinedoctor = serializers.SerializerMethodField()
    patientextra = serializers.SerializerMethodField()
    class Meta:
        model = Patient
        fields = [
            'userId',
            'motherName',
            'fatherName',
            'gender',
            'dateOfBirth',
            'address',
            'weight',
            'ssn',
            'stateTypeId',
            'isOnLightRay',
            'createdDate',
            'conditionId',
            'incubatorId',
            'status',
            'bills',
            'patientlaboratory',
            'patientxray',
            'patientconsumablenurse',
            'patientmedicinedoctor',
            'patientextra'
        ]

    def get_status(self, instance):
        status = instance.status.all().order_by('-createdDate')
        return StatusSerializer(status, many=True).data
    
    def get_bills(self, instance):
        bill = instance.bills.all().order_by('-date')
        return BillSerializer(bill, many=True).data

    def get_patientlaboratory(self, instance):
        laboratory = instance.patientlaboratory.all().order_by('-createdDate')
        return PatientLaboratorySerializer(laboratory, many=True).data

    def get_patientxray(self, instance):
        xray = instance.patientxray.all().order_by('-createdDate')
        return PatientXRaySerializer(xray, many=True).data

    def get_patientconsumablenurse(self, instance):
        consumable = instance.patientconsumablenurse.all().order_by('-createdDate')
        return PatientConsumableNurseSerializer(consumable, many=True).data        

    def get_patientmedicinedoctor(self, instance):
        medicine = instance.patientmedicinedoctor.all().order_by('-createdDate')
        return PatientMedicineDoctorSerializer(medicine, many=True).data        

    def get_patientextra(self, instance):
        extra = instance.patientextra.all().order_by('-createdDate')
        return PatientExtraSerializer(extra, many=True).data
    

# main serializers

# basic data


class IncubatorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Incubator
        fields = ['id', 'name']


class StateTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = StateType
        fields = ['id', 'name']


class ConditionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Condition
        fields = ['id', 'name', 'price', ]


class LaboratorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Laboratory
        fields = ['id', 'name', 'price']


class ConsumableSerializer(serializers.ModelSerializer):
    class Meta:
        model = Consumable
        fields = ['id', 'name', 'amount', 'price']


class MedicineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Medicine
        fields = ['id', 'name', 'amount', 'price']


class XRaySerializer(serializers.ModelSerializer):
    class Meta:
        model = XRay
        fields = ['id', 'name', 'price']


class ShiftSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shift
        fields = ['id', 'name', 'startTime',
                  'isStartTimePM', 'endTime', 'isEndTimePM']


class ExtraSerializer(serializers.ModelSerializer):
    class Meta:
        model = Extra
        fields = ['id', 'name', 'price']

# non basic data


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = [
            'id',
            'userType',
            'email',
            'password',
            'phone',
            'provider',
            'createdDate',
        ]


class AccountantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Accountant
        fields = ['userId', 'firstName', 'lastName',
                  'gender', 'dateOfBirth', 'createdDate']


class DoctorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Doctor
        fields = ['userId', 'firstName', 'lastName',
                  'gender', 'dateOfBirth', 'createdDate']


class NurseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Nurse
        fields = ['userId', 'firstName', 'lastName',
                  'gender', 'dateOfBirth', 'createdDate']


class ReportProblemSerializer(serializers.ModelSerializer):
    class Meta:
        model = ReportProblem
        fields = ['id', 'subject', 'body', 'mailFrom',
                  'mailTo', 'status', 'createdDate']
