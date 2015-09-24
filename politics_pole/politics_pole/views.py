# coding: utf-8


from rest_framework import viewsets
from rest_framework import generics

from .models import Deputy

from .serializers import DeputySerializer
from .serializers import DeputyDetailsSerializer


class DeputyViewSet(generics.ListAPIView):
    queryset = Deputy.objects.all()
    serializer_class = DeputySerializer


class VotesForDeputyView(generics.ListAPIView):
    serializer_class = DeputyDetailsSerializer

    def get_queryset(self):
        """ Retrieves the list of votes for one deputy and the
        decree information.
        """
        deputy_slug = self.kwargs['deputy_slug']
        return Deputy.objects.filter(slug=deputy_slug)
