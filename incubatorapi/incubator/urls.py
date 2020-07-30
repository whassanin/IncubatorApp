from django.urls import path
from rest_framework.urlpatterns import format_suffix_patterns
from . import views

urlpatterns = [

    path('incubator/', views.IncubatorList.as_view()),
    path('incubator/<int:pk>', views.IncubatorDetail.as_view()),

    path('condition/', views.ConditionList.as_view()),
    path('condition/<int:pk>', views.ConditionDetail.as_view()),
    
    path('patient/', views.PatientList.as_view()),
    path('patient/<int:pk>', views.PatientDetail.as_view()),
    
    path('analysis/', views.AnalysisList.as_view()),
    path('analysis/<int:pk>', views.AnalysisDetail.as_view()),

    path('bill/<int:pId>', views.BillList.as_view()),
    path('bill/edit/<int:pk>', views.BillDetail.as_view()),
    
]

urlpatterns = format_suffix_patterns(urlpatterns)