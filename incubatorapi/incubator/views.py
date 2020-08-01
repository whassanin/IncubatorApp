from incubator.models import Incubator
from incubator.models import Analysis
from incubator.models import Condition
from incubator.models import Patient
from incubator.models import Bill
from incubator.models import Consumable
from incubator.models import XRay
from incubator.models import Shift
from incubator.models import Doctor
from incubator.models import Nurse
from incubator.models import Medicine

from incubator.serializer import IncubatorSerializer
from incubator.serializer import AnalysisSerializer
from incubator.serializer import ConditionSerializer
from incubator.serializer import PatientSerializer
from incubator.serializer import BillSerializer
from incubator.serializer import ConsumableSerializer
from incubator.serializer import XRaySerializer
from incubator.serializer import ShiftSerializer
from incubator.serializer import DoctorSerializer
from incubator.serializer import NurseSerializer
from incubator.serializer import DoctorShiftSerializer
from incubator.serializer import NurseShiftSerializer
from incubator.serializer import MedicineSerializer

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
    queryset = Bill.objects.all()
    serializer_class = BillSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return Bill.objects.filter(patientId=patientId)

class BillDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Bill.objects.all()
    serializer_class = BillSerializer

# Consumable Class
class ConsumableList(generics.ListCreateAPIView):
    queryset = Consumable.objects.all()
    serializer_class = ConsumableSerializer

class ConsumableDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Consumable.objects.all()
    serializer_class = ConsumableSerializer

# XRay Class
class XRayList(generics.ListCreateAPIView):
    queryset = XRay.objects.all()
    serializer_class = XRaySerializer

class XRayDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = XRay.objects.all()
    serializer_class = XRaySerializer

# Shift Class
class ShiftList(generics.ListCreateAPIView):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer

class ShiftDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer

# Doctor Class
class DoctorList(generics.ListCreateAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer

class DoctorDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer

# Nurse Class
class NurseList(generics.ListCreateAPIView):
    queryset = Nurse.objects.all()
    serializer_class = NurseSerializer

class NurseDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Nurse.objects.all()
    serializer_class = NurseSerializer

# Medicine Class
class MedicineList(generics.ListCreateAPIView):
    queryset = Medicine.objects.all()
    serializer_class = MedicineSerializer

class MedicineDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Medicine.objects.all()
    serializer_class = MedicineSerializer

