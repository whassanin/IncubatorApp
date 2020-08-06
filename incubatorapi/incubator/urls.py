from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [

    # basic data
    path('incubator/', views.IncubatorList.as_view()),
    path('incubator/<int:pk>', views.IncubatorDetail.as_view()),

    path('condition/', views.ConditionList.as_view()),
    path('condition/<int:pk>', views.ConditionDetail.as_view()),

    path('analysis/', views.AnalysisList.as_view()),
    path('analysis/<int:pk>', views.AnalysisDetail.as_view()),

    path('consumable/', views.ConsumableList.as_view()),
    path('consumable/<int:pk>', views.ConsumableDetail.as_view()),

    path('medicine/', views.MedicineList.as_view()),
    path('medicine/<int:pk>', views.MedicineDetail.as_view()),

    path('xray/', views.XRayList.as_view()),
    path('xray/<int:pk>', views.XRayDetail.as_view()),

    path('shift/', views.ShiftList.as_view()),
    path('shift/<int:pk>', views.ShiftDetail.as_view()),

    # Non basic data
    path('doctor/', views.DoctorList.as_view()),
    path('doctor/<int:pk>', views.DoctorDetail.as_view()),

    path('nurse/', views.NurseList.as_view()),
    path('nurse/<int:pk>', views.NurseDetail.as_view()),

    # 1 to many data
    path('patient/', views.PatientList.as_view()),
    path('patient/<int:pk>', views.PatientDetail.as_view()),

    path('bill/<int:pId>', views.BillList.as_view()),
    path('bill/edit/<int:pk>', views.BillDetail.as_view()),

    path('status/<int:pId>', views.StatusList.as_view()),
    path('status/edit/<int:pk>', views.StatusDetail.as_view()),

    path('doctorshift/<int:docId>', views.DoctorShiftList.as_view()),
    path('doctorshift/edit/<int:pk>', views.DoctorShiftDetail.as_view()),

    path('shiftdoctor/<int:shiftId>', views.ShiftDoctorList.as_view()),
    path('shiftdoctor/edit/<int:pk>', views.ShiftDoctortDetail.as_view()),

    path('nurseshift/<int:docId>', views.NurseShiftList.as_view()),
    path('nurseshift/edit/<int:pk>', views.NurseShiftDetail.as_view()),

    path('shiftnurse/<int:shiftId>', views.ShiftNurseList.as_view()),
    path('shiftnurse/edit/<int:pk>', views.ShiftNursetDetail.as_view()),

    path('patientanalysis/<int:pId>', views.PatientAnalysisList.as_view()),
    path('patientanalysis/edit/<int:pk>', views.PatientAnalysisDetail.as_view()),

    path('analysispatient/<int:analysisId>', views.AnalysisPatientList.as_view()),
    path('analysispatient/edit/<int:pk>', views.AnalysisPatientDetail.as_view()),

    path('patientxray/<int:pId>', views.PatientXRayList.as_view()),
    path('patientxray/edit/<int:pk>', views.PatientXRayDetail.as_view()),

    path('xraypatient/<int:xrayId>', views.XRayPatientList.as_view()),
    path('xraypatient/edit/<int:pk>', views.XRayPatientDetail.as_view()),

    path('patientconsumablenurse/<int:pId>', views.PatientConsumableNurseList.as_view()),
    path('patientconsumablenurse/edit/<int:pk>', views.PatientConsumableNursetDetail.as_view()),

    path('patientmedicinedoctor/<int:pId>', views.PatientMedicineDoctorList.as_view()),
    path('patientmedicinedoctor/edit/<int:pk>', views.PatientMedicineDoctortDetail.as_view()),

    # Multi value

    path('patientphone/<int:pId>', views.PatientPhoneList.as_view()),
    path('patientphone/edit/<int:pk>', views.PatientPhoneDetail.as_view()),

    path('billextra/<int:billId>', views.BillExtraList.as_view()),
    path('billextra/edit/<int:pk>', views.BillExtraDetail.as_view()),

]

urlpatterns = format_suffix_patterns(urlpatterns)