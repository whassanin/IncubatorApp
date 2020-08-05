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
from incubator.models import Status
from incubator.models import DoctorShift
from incubator.models import NurseShift
from incubator.models import PatientAnalysis
from incubator.models import PatientXRay
from incubator.models import PatientConsumableNurse
from incubator.models import PatientMedicineDoctor
from incubator.models import PatientPhone
from incubator.models import BillExtra

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
from incubator.serializer import StatusSerializer
from incubator.serializer import PatientAnalysisSerializer
from incubator.serializer import PatientXRaySerializer
from incubator.serializer import PatientConsumableNurseSerializer
from incubator.serializer import PatientMedicineDoctorSerializer
from incubator.serializer import PatientPhoneSerializer
from incubator.serializer import BillExtraSerializer

from rest_framework import generics
from rest_framework.views import APIView
from rest_framework.response import Response

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

# 1 to many data

# Patient Views CLass
class PatientList(generics.ListCreateAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer

class PatientDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer

# Bill Views Class
class BillList(generics.ListCreateAPIView):
    serializer_class = BillSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return Bill.objects.filter(patientId=patientId)

class BillDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Bill.objects.all()
    serializer_class = BillSerializer

# Status Views Class
class StatusList(generics.ListCreateAPIView):
    serializer_class = StatusSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return Status.objects.filter(patientId=patientId).order_by('-createdDate')[:2]

class StatusDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Status.objects.all()
    serializer_class = StatusSerializer


# many to many
class DoctorShiftList(generics.ListCreateAPIView):
    serializer_class = DoctorShiftSerializer
    def get_queryset(self):
       doctorId = self.kwargs['docId']
       return DoctorShift.objects.filter(doctorId=doctorId)

class DoctorShiftDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = DoctorShift.objects.all()
    serializer_class = DoctorShiftSerializer

class ShiftDoctorList(generics.ListCreateAPIView):
    serializer_class = DoctorShiftSerializer
    def get_queryset(self):
       shiftId = self.kwargs['shiftId']
       return DoctorShift.objects.filter(shiftId=shiftId)

class ShiftDoctortDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = DoctorShift.objects.all()
    serializer_class = DoctorShiftSerializer


class NurseShiftList(generics.ListCreateAPIView):
    serializer_class = NurseShiftSerializer
    def get_queryset(self):
       nurseId = self.kwargs['nurseId']
       return NurseShift.objects.filter(nurseId=nurseId)

class NurseShiftDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = NurseShift.objects.all()
    serializer_class = NurseShiftSerializer

class ShiftNurseList(generics.ListCreateAPIView):
    serializer_class = NurseShiftSerializer
    def get_queryset(self):
       shiftId = self.kwargs['shiftId']
       return NurseShift.objects.filter(shiftId=shiftId)

class ShiftNursetDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = NurseShift.objects.all()
    serializer_class = NurseShiftSerializer


class PatientAnalysisList(generics.ListCreateAPIView):
    serializer_class = PatientAnalysisSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return PatientAnalysis.objects.filter(patientId=patientId)

class PatientAnalysisDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientAnalysis.objects.all()
    serializer_class = PatientAnalysisSerializer

class AnalysisPatientList(generics.ListCreateAPIView):
    serializer_class = PatientAnalysisSerializer
    def get_queryset(self):
       analysisId = self.kwargs['analysisId']
       return PatientAnalysis.objects.filter(analysisId=analysisId)

class AnalysisPatientDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientAnalysis.objects.all()
    serializer_class = PatientAnalysisSerializer


class PatientXRayList(generics.ListCreateAPIView):
    serializer_class = PatientXRaySerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return PatientXRay.objects.filter(patientId=patientId)

class PatientXRayDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientXRay.objects.all()
    serializer_class = PatientXRaySerializer

class XRayPatientList(generics.ListCreateAPIView):
    serializer_class = PatientXRaySerializer
    def get_queryset(self):
       xrayId = self.kwargs['xrayId']
       return PatientXRay.objects.filter(xRayId=xrayId)

class XRayPatientDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientXRay.objects.all()
    serializer_class = PatientXRaySerializer


class PatientConsumableNurseList(generics.ListCreateAPIView):
    serializer_class = PatientConsumableNurseSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return PatientConsumableNurse.objects.filter(patientId=patientId)

class PatientConsumableNursetDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientConsumableNurse.objects.all()
    serializer_class = PatientConsumableNurseSerializer


class PatientMedicineDoctorList(generics.ListCreateAPIView):
    serializer_class = PatientMedicineDoctorSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return PatientMedicineDoctor.objects.filter(patientId=patientId)

class PatientMedicineDoctortDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientMedicineDoctor.objects.all()
    serializer_class = PatientMedicineDoctorSerializer

# Multi value

class PatientPhoneList(generics.ListCreateAPIView):
    serializer_class = PatientPhoneSerializer
    def get_queryset(self):
       patientId = self.kwargs['pId']
       return PatientPhone.objects.filter(patientId=patientId)

class PatientPhoneDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = PatientPhone.objects.all()
    serializer_class = PatientPhoneSerializer

class BillExtraList(generics.ListCreateAPIView):
    serializer_class = BillExtraSerializer
    def get_queryset(self):
       billId = self.kwargs['billId']
       return BillExtra.objects.filter(billId=billId)

class BillExtraDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = BillExtra.objects.all()
    serializer_class = BillExtraSerializer
