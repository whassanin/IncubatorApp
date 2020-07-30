from rest_framework import serializers
from incubator.models import Incubator
from incubator.models import Analysis
from incubator.models import Condition
from incubator.models import Patient
from incubator.models import Bill

class IncubatorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Incubator
        fields = ['id','name']

class ConditionSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Condition
        fields = ['colorId','cost',]

class PatientSerializer(serializers.ModelSerializer):
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
        ]

class AnalysisSerializer(serializers.ModelSerializer):

    class Meta: 
        model = Analysis
        fields = ['id','name']

class BillSerializer(serializers.ModelSerializer):
    
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
            'patientId'
            ]

