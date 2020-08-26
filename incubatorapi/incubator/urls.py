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
    path('user/', views.UserList.as_view()),
    path('user/<int:pk>', views.UserDetail.as_view()),

    path('doctor/', views.DoctorList.as_view()),
    path('doctor/<int:pk>', views.DoctorDetail.as_view()),

    path('nurse/', views.NurseList.as_view()),
    path('nurse/<int:pk>', views.NurseDetail.as_view()),

    path('frontdesk/', views.ForntDeskList.as_view()),
    path('frontdesk/<int:pk>', views.FrontDeskDetail.as_view()),

    path('reportproblem/', views.ReportProblemList.as_view()),
    path('reportproblem/<int:pk>', views.ReportProblemDetail.as_view()),

    # 1 to many data
    path('patient/', views.PatientList.as_view()),
    path('patient/<int:pk>', views.PatientDetail.as_view()),

    path('bill/', views.BillList.as_view()),
    path('bill/<int:pk>', views.BillDetail.as_view()),

    path('status/', views.StatusList.as_view()),
    path('status/<int:pk>', views.StatusDetail.as_view()),

    path('doctorshift/', views.DoctorShiftList.as_view()),
    path('doctorshift/<int:pk>', views.DoctorShiftDetail.as_view()),

    path('nurseshift/', views.NurseShiftList.as_view()),
    path('nurseshift/<int:pk>', views.NurseShiftDetail.as_view()),

    path('patientanalysis/', views.PatientAnalysisList.as_view()),
    path('patientanalysis/<int:pk>', views.PatientAnalysisDetail.as_view()),

    path('patientxray/', views.PatientXRayList.as_view()),
    path('patientxray/<int:pk>', views.PatientXRayDetail.as_view()),

    path('patientconsumablenurse/', views.PatientConsumableNurseList.as_view()),
    path('patientconsumablenurse/<int:pk>', views.PatientConsumableNursetDetail.as_view()),

    path('patientmedicinedoctor/', views.PatientMedicineDoctorList.as_view()),
    path('patientmedicinedoctor/<int:pk>', views.PatientMedicineDoctortDetail.as_view()),

    # Multi value

    path('billextra/', views.BillExtraList.as_view()),
    path('billextra/<int:pk>', views.BillExtraDetail.as_view()),

    path('creditcard/', views.CreditCardList.as_view()),
    path('creditcard/<int:pk>', views.CreditCardDetail.as_view()),

]

urlpatterns = format_suffix_patterns(urlpatterns)