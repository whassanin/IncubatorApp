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

@api_view(['POST'])
def addIncubator(request):
    incubatorData = JSONParser().parse(request)
    incubator_serializer_Data = IncubatorSerializer(data=incubatorData)
    if incubator_serializer_Data.is_valid():
        incubator_serializer_Data.save()
        return JsonResponse(incubator_serializer_Data,status=status.HTTP_201_CREATED)
    return JsonResponse(incubator_serializer_Data.errors,status=status.HTTP_400_BAD_REQUEST)
