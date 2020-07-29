from django.urls import path
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^incubator$',views.readAllIncubator),
    url(r'^incubator/add$',views.addIncubator)
]