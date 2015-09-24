# coding: utf-8


from django.conf.urls import patterns, include, url

from .views import DeputyViewSet
from .views import VotesForDeputyView

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns(
    '',
    url(r'^deputies$', DeputyViewSet.as_view()),

    url(
        r'^deputies/(?P<deputy_slug>.+)/votes$',
        VotesForDeputyView.as_view()
    ),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
