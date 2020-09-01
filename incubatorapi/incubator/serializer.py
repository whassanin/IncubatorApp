from rest_framework import serializers

from incubator.models import User
from incubator.models import Incubator
from incubator.models import Analysis
from incubator.models import Condition
from incubator.models import Patient
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
from incubator.models import PatientAnalysis
from incubator.models import PatientXRay
from incubator.models import BillExtra
from incubator.models import CreditCard
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


class PatientAnalysisSerializer(serializers.ModelSerializer):

    class Meta:
        model = PatientAnalysis
        fields = [
            'id',
            'patientId',
            'analysisId',
            'result',
            'billStatus',
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
            'billStatus',
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
            'billStatus',
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
            'billStatus',
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
    billextra = BillExtraSerializer(many=True, read_only=True)

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


class PatientSerializer(serializers.ModelSerializer):
    # patientanalysis = PatientAnalysisSerializer(many=True,read_only=True)
    # patientxray = PatientXRaySerializer(many=True,read_only=True)
    # patientconsumablenurse = PatientConsumableNurseSerializer(many=True,read_only=True)
    # patientmedicinedoctor = PatientMedicineDoctorSerializer(many=True,read_only=True)
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
            'state',
            'createdDate',
            'conditionId',
            'incubatorId'
        ]

# main serializers

# basic data


class IncubatorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Incubator
        fields = ['id', 'name']


class ConditionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Condition
        fields = ['id', 'name', 'price', ]


class AnalysisSerializer(serializers.ModelSerializer):
    class Meta:
        model = Analysis
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
