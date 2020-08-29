from incubator.models import Incubator
from incubator.models import Analysis
from incubator.models import Condition
from incubator.models import Patient
from incubator.models import Bill
from incubator.models import Consumable
from incubator.models import XRay
from incubator.models import Shift
from incubator.models import User
from incubator.models import Accountant
from incubator.models import ReportProblem
from incubator.models import Doctor
from incubator.models import Nurse
from incubator.models import Medicine
from incubator.models import Status
from incubator.models import DoctorShift
from incubator.models import NurseShift
from incubator.models import PatientAnalysis
from incubator.models import PatientXRay
from incubator.models import PatientConsumableNurse
from incubator.models import PatientMedicineDoctor
from incubator.models import BillExtra
from incubator.models import CreditCard

from incubator.serializer import IncubatorSerializer
from incubator.serializer import AnalysisSerializer
from incubator.serializer import ConditionSerializer
from incubator.serializer import PatientSerializer
from incubator.serializer import BillSerializer
from incubator.serializer import ConsumableSerializer
from incubator.serializer import XRaySerializer
from incubator.serializer import ShiftSerializer
from incubator.serializer import UserSerializer
from incubator.serializer import AccountantSerializer
from incubator.serializer import ReportProblemSerializer
from incubator.serializer import DoctorSerializer
from incubator.serializer import NurseSerializer
from incubator.serializer import DoctorShiftSerializer
from incubator.serializer import NurseShiftSerializer
from incubator.serializer import MedicineSerializer
from incubator.serializer import StatusSerializer
from incubator.serializer import PatientAnalysisSerializer
from incubator.serializer import PatientXRaySerializer
from incubator.serializer import PatientConsumableNurseSerializer
from incubator.serializer import PatientMedicineDoctorSerializer
from incubator.serializer import BillExtraSerializer
from incubator.serializer import CreditCardSerializer

from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend

# Create your views here.

# basic data

# Incubator Views Class
class IncubatorList(generics.ListCreateAPIView):
    queryset = Incubator.objects.all()
    serializer_class = IncubatorSerializer
    ordering_fields = ['id']
    ordering = ['id']

class IncubatorDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Incubator.objects.all()
    serializer_class = IncubatorSerializer

# Condition Views CLass
class ConditionList(generics.ListCreateAPIView):
    queryset = Condition.objects.all()
    serializer_class = ConditionSerializer

class ConditionDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Condition.objects.all()
    serializer_class = ConditionSerializer

# Analysis Views Class
class AnalysisList(generics.ListCreateAPIView):
    queryset = Analysis.objects.all()
    serializer_class = AnalysisSerializer

class AnalysisDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Analysis.objects.all()
    serializer_class = AnalysisSerializer

# Consumable Views Class
class ConsumableList(generics.ListCreateAPIView):
    queryset = Consumable.objects.all()
    serializer_class = ConsumableSerializer

class ConsumableDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Consumable.objects.all()
    serializer_class = ConsumableSerializer

# Medicine Views Class
class MedicineList(generics.ListCreateAPIView):
    queryset = Medicine.objects.all()
    serializer_class = MedicineSerializer

class MedicineDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Medicine.objects.all()
    serializer_class = MedicineSerializer

# XRay Views Class
class XRayList(generics.ListCreateAPIView):
    queryset = XRay.objects.all()
    serializer_class = XRaySerializer

class XRayDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = XRay.objects.all()
    serializer_class = XRaySerializer

# Shift Views Class
class ShiftList(generics.ListCreateAPIView):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer

class ShiftDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Shift.objects.all()
    serializer_class = ShiftSerializer

# None basic Data

class UserList(generics.ListCreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['email','password','provider','phone']

class UserDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

# Doctor Class
class DoctorList(generics.ListCreateAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['userId']

class DoctorDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Doctor.objects.all()
    serializer_class = DoctorSerializer

# Nurse Class
class NurseList(generics.ListCreateAPIView):
    queryset = Nurse.objects.all()
    serializer_class = NurseSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['userId']

class NurseDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Nurse.objects.all()
    serializer_class = NurseSerializer

# Front Desk Class
class AccountantList(generics.ListCreateAPIView):
    queryset = Accountant.objects.all()
    serializer_class = AccountantSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['userId']

class AccountantDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Accountant.objects.all()
    serializer_class = AccountantSerializer

class ReportProblemList(generics.ListCreateAPIView):
    queryset = ReportProblem.objects.all()
    serializer_class = ReportProblemSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['status']

class ReportProblemDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = ReportProblem.objects.all()
    serializer_class = ReportProblemSerializer

# 1 to many data

# Patient Views CLass
class PatientList(generics.ListCreateAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['state','userId']

class PatientDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer

# Bill Views Class
class BillList(generics.ListCreateAPIView):
    queryset = Bill.objects.all().order_by('-date')
    serializer_class = BillSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId']

class BillDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Bill.objects.all()
    serializer_class = BillSerializer

# Status Views Class
class StatusList(generics.ListCreateAPIView):
    queryset = Status.objects.all().order_by('-createdDate')
    serializer_class = StatusSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId']

class StatusDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Status.objects.all()
    serializer_class = StatusSerializer

# many to many
class DoctorShiftList(generics.ListCreateAPIView):
    queryset = DoctorShift.objects.all().order_by('startDateTime')
    serializer_class = DoctorShiftSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['doctorId','shiftId']

class DoctorShiftDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = DoctorShift.objects.all()
    serializer_class = DoctorShiftSerializer

class NurseShiftList(generics.ListCreateAPIView):
    queryset = NurseShift.objects.all().order_by('createdDate')
    serializer_class = NurseShiftSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['nurseId','shiftId']

class NurseShiftDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = NurseShift.objects.all()
    serializer_class = NurseShiftSerializer

class PatientAnalysisList(generics.ListCreateAPIView):
    queryset = PatientAnalysis.objects.all().order_by('-createdDate') 
    serializer_class = PatientAnalysisSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId','analysisId']

class PatientAnalysisDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientAnalysis.objects.all()
    serializer_class = PatientAnalysisSerializer

class PatientXRayList(generics.ListCreateAPIView):
    queryset = PatientXRay.objects.all().order_by('-createdDate')
    serializer_class = PatientXRaySerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId','xRayId']

class PatientXRayDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientXRay.objects.all()
    serializer_class = PatientXRaySerializer

class PatientConsumableNurseList(generics.ListCreateAPIView):
    queryset = PatientConsumableNurse.objects.all().order_by('-createdDate')
    serializer_class = PatientConsumableNurseSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId','consumableId','nurseId']

class PatientConsumableNursetDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientConsumableNurse.objects.all()
    serializer_class = PatientConsumableNurseSerializer

class PatientMedicineDoctorList(generics.ListCreateAPIView):
    queryset = PatientMedicineDoctor.objects.all().order_by('-createdDate')
    serializer_class = PatientMedicineDoctorSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId','medicineId','doctorId'] 

class PatientMedicineDoctortDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientMedicineDoctor.objects.all()
    serializer_class = PatientMedicineDoctorSerializer

# Multi value

class BillExtraList(generics.ListCreateAPIView):
    queryset = BillExtra.objects.all()
    serializer_class = BillExtraSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['billId'] 

class BillExtraDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = BillExtra.objects.all()
    serializer_class = BillExtraSerializer

class CreditCardList(generics.ListCreateAPIView):
    queryset = CreditCard.objects.all()
    serializer_class = CreditCardSerializer
    filter_backends =[DjangoFilterBackend]
    filterset_fields = ['patientId'] 

class CreditCardDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = CreditCard.objects.all()
    serializer_class = CreditCardSerializer
