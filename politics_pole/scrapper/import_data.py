# coding: utf-8


import pdb
import requests
import xml.etree.ElementTree as ET

from django.db import transaction
from django.core.exceptions import ObjectDoesNotExist

from .parsing import get_vote_links
from .parsing import get_solemn_decrees
from .parsing import get_decree_number
from .parsing import get_decree_title
from .parsing import get_decree_date
from .parsing import get_party_list
from .parsing import get_party_name
from .parsing import get_deputy_list
from .parsing import get_deputy_name
from .parsing import get_deputy_surname
from .parsing import get_yes_vote
from .parsing import get_no_vote
from .parsing import get_abstention_vote

from politics_pole.models import Deputy
from politics_pole.models import Decree
from politics_pole.models import Vote
from politics_pole.models import Party

from slugify import slugify

from scrapper.settings import BASE_URL


def is_valid_deputy(surname, name):
    INVALID_SURNAME_VALUES = [
        "membres du groupe",
        "membre du groupe",
        "présent ou ayant délégué son droit de vote",
        "présents ou ayant délégué leur droit de vote"
    ]

    INVALID_NAME_VALUES = []

    return not (surname in INVALID_SURNAME_VALUES or name in INVALID_NAME_VALUES)


def import_decree(decree_vote_data, solemn_decree_list):
    """
    """
    number = get_decree_number(decree_vote_data)

    try:
        Decree.objects.get(number=number)
    except ObjectDoesNotExist:
        decree = Decree.objects.create(
            number=number,
            title=get_decree_title(decree_vote_data),
            date=get_decree_date(decree_vote_data),
            is_solemn=False if number not in solemn_decree_list else True
        )
        print("Inserted decree %s" % (str(decree)))


def import_deputies(decree_vote_data):
    """
    """
    for party_node in get_party_list(decree_vote_data):
        party_name = get_party_name(ET.tostring(party_node))

        try:
            party = Party.objects.get(name=party_name)
        except ObjectDoesNotExist:
            party = Party.objects.create(name=party_name)
            print("Party %s insterted" % party_name)

        # party, created = Party.objects.get_or_create(name=party_name)

        for deputy in get_deputy_list(ET.tostring(party_node)):
            name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
            surname = get_deputy_surname(ET.tostring(deputy))
            slug = slugify(name + "_" + surname).lower()

            if is_valid_deputy(surname, name):
                try:
                    Deputy.objects.get(slug=slug)
                except ObjectDoesNotExist:
                    deputy = Deputy.objects.create(
                        name=name,
                        surname=surname,
                        slug=slug,
                        party=party
                    )
                    print("Inserting Deputy %s" % (str(deputy)))


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

        if is_valid_deputy(surname, name):
            try:
                deputy = Deputy.objects.get(slug=slug)
            except ObjectDoesNotExist:
                raise Exception("Yes vote - Deputy not found")

            try:
                Vote.objects.get(
                    deputy=deputy,
                    decree=decree,
                    vote_value=1)
            except ObjectDoesNotExist:
                Vote.objects.create(
                    decree=decree,
                    deputy=deputy,
                    vote_value=1
                )
                print("Inserting Yes Vote for deputy %s %s" % (surname, name))


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

        if is_valid_deputy(surname, name):
            try:
                deputy = Deputy.objects.get(slug=slug)
            except ObjectDoesNotExist:
                raise Exception("Yes vote - Deputy not found")

            try:
                Vote.objects.get(deputy=deputy,
                                decree=decree,
                                vote_value=0)
            except ObjectDoesNotExist:
                Vote.objects.create(
                    decree=decree,
                    deputy=deputy,
                    vote_value=0
                )
                print("Inserting No Vote for deputy %s %s" % (surname, name))


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

        if is_valid_deputy(surname, name):
            try:
                deputy = Deputy.objects.get(slug=slug)
            except ObjectDoesNotExist:
                raise Exception("Yes vote - Deputy not found")

            try:
                Vote.objects.get(
                    deputy=deputy,
                    decree=decree,
                    vote_value=2)
            except ObjectDoesNotExist:
                Vote.objects.create(
                    decree=decree,
                    deputy=deputy,
                    vote_value=2
                )
                print("Inserting No Vote for deputy %s %s" % (surname, name))


def download_data(url):
    """ Downloads data
    """
    response = requests.get(url)
    response.raise_for_status()
    return response.text


def import_data_votes_for_link(page_list):
    """ Parses the list of scrutin URL from the list of scrutin.
    """

    print("****** Decree list : %s  ******" % page_list)
    poll_list_page = download_data(page_list)
    links = get_vote_links(poll_list_page)
    solemn_decree_list = get_solemn_decrees(poll_list_page)
    print("number of votes to parse  %d" % (len(links)))

    for link in links:
        print("******* Parsing link %s *******" % (BASE_URL + link))
        decree_vote_data = download_data(BASE_URL + link)

        print("*** Inserting Decrees ***")
        import_decree(decree_vote_data, solemn_decree_list)

        print("*** Inserting Deputies ***")
        import_deputies(decree_vote_data)

        print("*** Inserting Votes  ***")
        import_yes_votes(decree_vote_data)
        import_no_votes(decree_vote_data)
        import_abstention_votes(decree_vote_data)
