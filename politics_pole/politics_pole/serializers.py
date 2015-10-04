# coding: utf-8


from .models import Decree
from .models import Deputy
from .models import Vote

from rest_framework import serializers


class DecreeSerializer(serializers.ModelSerializer):

    class Meta:
        model = Decree


class VoteSerializer(serializers.ModelSerializer):
    decree = DecreeSerializer()

    class Meta:
        model = Vote
        exclude = ['deputy']


class DeputySerializer(serializers.ModelSerializer):
    party = serializers.StringRelatedField()

    class Meta:
        model = Deputy


class DeputyDetailsSerializer(serializers.ModelSerializer):
    votes = VoteSerializer(many=True)

    class Meta:
        model = Deputy
