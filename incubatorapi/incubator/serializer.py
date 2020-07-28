from rest_framework import serializers
from incubator.models import Incubator

class IncubatorSerializer(serializers.ModelSerializer):
    class Meta: 
        model = Incubator
        fields = ('id','name')