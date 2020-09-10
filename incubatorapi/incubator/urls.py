from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [

    # basic data
    path('incubator/', views.IncubatorList.as_view()),
    path('incubator/<int:pk>', views.IncubatorDetail.as_view()),

    path('statetype/', views.StateTypeList.as_view()),
    path('statetype/<int:pk>', views.StateTypeDetail.as_view()),

    path('condition/', views.ConditionList.as_view()),
    path('condition/<int:pk>', views.ConditionDetail.as_view()),

    path('laboratory/', views.LaboratoryList.as_view()),
    path('laboratory/<int:pk>', views.LaboratoryDetail.as_view()),

    path('consumable/', views.ConsumableList.as_view()),
    path('consumable/<int:pk>', views.ConsumableDetail.as_view()),

    path('medicine/', views.MedicineList.as_view()),
    path('medicine/<int:pk>', views.MedicineDetail.as_view()),

    path('xray/', views.XRayList.as_view()),
    path('xray/<int:pk>', views.XRayDetail.as_view()),

    path('shift/', views.ShiftList.as_view()),
    path('shift/<int:pk>', views.ShiftDetail.as_view()),

    path('extra/', views.ExtraList.as_view()),
    path('extra/<int:pk>', views.ExtraDetail.as_view()),

    # Non basic data
    path('user/', views.UserList.as_view()),
    path('user/<int:pk>', views.UserDetail.as_view()),

    path('doctor/', views.DoctorList.as_view()),
    path('doctor/<int:pk>', views.DoctorDetail.as_view()),

    path('nurse/', views.NurseList.as_view()),
    path('nurse/<int:pk>', views.NurseDetail.as_view()),

    path('accountant/', views.AccountantList.as_view()),
    path('accountant/<int:pk>', views.AccountantDetail.as_view()),

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

    path('patientlaboratory/', views.PatientLaboratoryList.as_view()),
    path('patientlaboratory/<int:pk>', views.PatientLaboratoryDetail.as_view()),

    path('patientxray/', views.PatientXRayList.as_view()),
    path('patientxray/<int:pk>', views.PatientXRayDetail.as_view()),

    path('patientconsumablenurse/', views.PatientConsumableNurseList.as_view()),
    path('patientconsumablenurse/<int:pk>', views.PatientConsumableNursetDetail.as_view()),

    path('patientmedicinedoctor/', views.PatientMedicineDoctorList.as_view()),
    path('patientmedicinedoctor/<int:pk>', views.PatientMedicineDoctortDetail.as_view()),

    path('patientextra/', views.PatientExtraList.as_view()),
    path('patientextra/<int:pk>', views.PatientExtraDetail.as_view()),

    # Multi value
    
    path('creditcard/', views.CreditCardList.as_view()),
    path('creditcard/<int:pk>', views.CreditCardDetail.as_view()),

]

urlpatterns = format_suffix_patterns(urlpatterns)