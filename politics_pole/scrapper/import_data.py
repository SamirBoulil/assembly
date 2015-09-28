# coding: utf-8


import requests
import xml.etree.ElementTree as ET

from django.db import transaction
from django.core.exceptions import ObjectDoesNotExist

from .parsing import get_vote_links
from .parsing import get_decree_number
from .parsing import get_decree_title
from .parsing import get_decree_date
from .parsing import get_deputy_list
from .parsing import get_deputy_name
from .parsing import get_deputy_surname
from .parsing import get_yes_vote
from .parsing import get_no_vote
from .parsing import get_abstention_vote

from politics_pole.models import Deputy
from politics_pole.models import Decree
from politics_pole.models import Vote

from slugify import slugify

from scrapper.settings import BASE_URL


def import_decree(decree_vote_data):
    """
    """
    number = get_decree_number(decree_vote_data)

    try:
        Decree.objects.get(number=number)
    except ObjectDoesNotExist:
        decree = Decree(
            number=number,
            title=get_decree_title(decree_vote_data),
            date=get_decree_date(decree_vote_data)
        )
        print("Inserting decree %s" % (str(decree)))
        decree.save()


def import_deputies(decree_vote_data):
    """
    """
    for deputy in get_deputy_list(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        try:
            Deputy.objects.get(slug=slug)
        except ObjectDoesNotExist:
            deputy = Deputy(
                name=name,
                surname=surname,
                slug=slug
            )
            print("Inserting Deputy %s" % (str(deputy)))
            deputy.save()


def import_yes_votes(decree_vote_data):
    """
    """
    number = get_decree_number(decree_vote_data)
    try:
        decree = Decree.objects.get(number=number)
    except ObjectDoesNotExist:
        raise Exception("Yes vote - Decree not found")

    for deputy in get_yes_vote(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        try:
            deputy = Deputy.objects.get(slug=slug)
        except ObjectDoesNotExist:
            raise Exception("Yes vote - Deputy not found")

        try:
            Vote.objects.get(
                deputy=deputy.id,
                decree=decree.id,
                vote_value=1)
        except ObjectDoesNotExist:
            vote = Vote(
                decree=decree,
                deputy=deputy,
                vote_value=1
            )
            print(vote)
            print("Inserting Yes Vote for deputy %s %s" % (surname, name))
            vote.save()


def import_no_votes(decree_vote_data):
    """
    """
    number = get_decree_number(decree_vote_data)
    try:
        decree = Decree.objects.get(number=number)
    except ObjectDoesNotExist:
        raise Exception("Yes vote - Decree not found")

    for deputy in get_no_vote(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        try:
            deputy = Deputy.objects.get(slug=slug)
        except ObjectDoesNotExist:
            raise Exception("Yes vote - Deputy not found")

        try:
            Vote.objects.get(deputy=deputy.id,
                             decree=decree.id,
                             vote_value=1)
        except ObjectDoesNotExist:
            vote = Vote(
                decree=decree,
                deputy=deputy,
                vote_value=0
            )
            print("Inserting No Vote for deputy %s %s" % (surname, name))
            vote.save()


def import_abstention_votes(decree_vote_data):
    """
    """
    number = get_decree_number(decree_vote_data)
    try:
        decree = Decree.objects.get(number=number)
    except ObjectDoesNotExist:
        raise Exception("Yes vote - Decree not found")

    for deputy in get_abstention_vote(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        try:
            deputy = Deputy.objects.get(slug=slug)
        except ObjectDoesNotExist:
            raise Exception("Yes vote - Deputy not found")

        try:
            Vote.objects.get(deputy=deputy.id,
                             decree=decree.id,
                             vote_value=2)
        except ObjectDoesNotExist:
            vote = Vote(
                decree=decree,
                deputy=deputy,
                vote_value=2
            )
            print("Inserting No Vote for deputy %s %s" % (surname, name))
            print(vote)
            vote.save()


def download_data(url):
    """ Downloads data
    """
    response = requests.get(url)
    response.raise_for_status()
    return response.text


def import_data_votes_for_link(page_list):
    """ Parses the list of scrutin URL from the list of scrutin.
    """

    print("****** Parsing list of links ******")
    poll_list_page = download_data(page_list)
    links = get_vote_links(poll_list_page)
    print("number of votes to parse  %d" % (len(links)))

    for link in links:
        print("******* Parsing link %s *******" % (link))
        decree_vote_data = download_data(BASE_URL + link)

        print("*** Inserting Decrees ***")
        import_decree(decree_vote_data)

        print("*** Parsing Deputies ***")
        import_deputies(decree_vote_data)

        import_yes_votes(decree_vote_data)
        import_no_votes(decree_vote_data)
        import_abstention_votes(decree_vote_data)