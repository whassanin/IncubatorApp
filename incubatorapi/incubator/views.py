from django.shortcuts import render
from django.http.response import JsonResponse
from rest_framework.parsers import JSONParser
from rest_framework import status
from incubator.models import Incubator
from incubator.serializer import IncubatorSerializer
from rest_framework.decorators import api_view 

# Create your views here.

# incubator functions
@api_view(['GET'])
def readAllIncubator(request):
    incubatorData = Incubator.objects.all()
    incubator_serializer_Data = IncubatorSerializer(incubatorData,many=True)
    return JsonResponse(incubator_serializer_Data.data,safe=False)
