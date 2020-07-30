from incubator.models import Incubator
from incubator.models import Analysis
from incubator.models import Condition
from incubator.models import Patient
from incubator.models import Bill

from incubator.serializer import IncubatorSerializer
from incubator.serializer import AnalysisSerializer
from incubator.serializer import ConditionSerializer
from incubator.serializer import PatientSerializer
from incubator.serializer import BillSerializer

from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

# Create your views here.

# Incubator Class
class IncubatorList(generics.ListCreateAPIView):
    queryset = Incubator.objects.all()
    serializer_class = IncubatorSerializer

class IncubatorDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Incubator.objects.all()
    serializer_class = IncubatorSerializer

# Condition CLass
class ConditionList(generics.ListCreateAPIView):
    queryset = Condition.objects.all()
    serializer_class = ConditionSerializer

class ConditionDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Condition.objects.all()
    serializer_class = ConditionSerializer

# Patient CLass
class PatientList(generics.ListCreateAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer

class PatientDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer

# Analysis Class
class AnalysisList(generics.ListCreateAPIView):
    queryset = Analysis.objects.all()
    serializer_class = AnalysisSerializer

class AnalysisDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Analysis.objects.all()
    serializer_class = AnalysisSerializer

# Bill Class
class BillList(generics.ListCreateAPIView):
    serializer_class = BillSerializer
    def get_queryset(self):
        patientId = self.kwargs['pId']
        return Bill.objects.filter(patientId=patientId)

class BillDetail(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = BillSerializer
    def get_queryset(self):
        id = self.kwargs['pk']
        return Bill.objects.filter(id=id)
