# coding: utf-8
"""
    Number of functions to parse and create Database objects.
"""

import re
from datetime import date
from lxml import html


def apply_predicate_data(predicate, data):
    """ From a data string (html), apply the predicate and returns the result.

    (may not be relevant)

    :param predicate: xpath selector
    :type predicate: string
    :param data: a string representing the data to parsed
    :type data: string
    :returns: the result of the xpath selector
    """
    tree = html.fromstring(data)
    result = tree.xpath(predicate)

    return result


def get_decree_link(data_table):
    """
    """
    decree_link_selector = '//table[@class="scrutins"]//a[contains(@href, "/dossiers/")]/@href'
    decree_link = apply_predicate_data(decree_link_selector, data_table)
    if len(decree_link) == 0:
        decree_link = None

    return decree_link


def get_vote_links(data_table):
    """
    """
    all_scrutins_links_selector = '//table[@class="scrutins"]//a[contains(@href, "/scrutins/detail/")]/@href'
    return apply_predicate_data(all_scrutins_links_selector, data_table)


def get_solemn_decrees(data_table):
    """ Returns decree ids of solemn decree 
    """
    all_solemn_decree_id = '//table[@class="scrutins"]//td[@class="denom"]/text()[contains(.,"*")]'
    tmp = apply_predicate_data(all_solemn_decree_id, data_table)
    # Remove star to get id
    return [int(value[:-1]) for value in tmp]


# PARSING DECREES
def get_decree_number(data_vote):
    """
    :returns: the number of the decree.
    :rtype: integerr
    """
    decree_number_selector = '//div[@class="titre-bandeau-bleu"]/h1/text()'
    number_raw = apply_predicate_data(decree_number_selector, data_vote)
    number = re.search('\d+$', number_raw[0])

    if number_raw is None:
        raise Exception("Decree number not parsed")

    return int(number.group())


def get_decree_title(data_vote):
    """
    """
    decree_title_selector = '//*[@class="president-title"]/text()'
    return apply_predicate_data(decree_title_selector, data_vote)[0]


def get_decree_date(data_vote):
    """
    """
    decree_date_selector = '//div[@class="titre-bandeau-bleu"]/h1/text()'
    date_raw = apply_predicate_data(decree_date_selector, data_vote)

    date_decree = re.search('(\d+)/(\d+)/(\d+)$', date_raw[1])
    if re is None:
        raise Exception("Decree date not parsed")

    date_groups = list(map(int, date_decree.groups()))
    return date(date_groups[2], date_groups[1], date_groups[0])


# Parsing parties
def get_party_list(data_vote):
    """ Returns the node of parties
    """
    party_selector = '//*[@class="TTgroupe"]'
    parties_node = apply_predicate_data(party_selector, data_vote)

    return parties_node


def get_party_name(deputy):
    """
    """
    party_name_selector = '//a[@class="agroupe"]/@name'
    party_name = apply_predicate_data(party_name_selector, deputy)

    return party_name[0] if len(party_name) > 0 else ""


# PARSING DEPUTY
def get_deputy_list(data_vote):
    """
    """
    deputies_selector = '//*[@class="deputes"]/li'
    deputies_node = apply_predicate_data(deputies_selector, data_vote)

    return deputies_node


def get_deputy_name(deputy):
    """
    """
    deputy_name_selector = 'b/text()'
    name = apply_predicate_data(deputy_name_selector, deputy)

    return str.strip(name[0]) if len(name) > 0 else ""


def get_deputy_surname(deputy):
    """
    """
    deputy_surname_selector = 'text()'
    surname = apply_predicate_data(deputy_surname_selector, deputy)

    return str.strip(surname[0]) if len(surname) > 0 else ""


# VOTE
def get_yes_vote(vote_data):
    yes_selector = '//*[@class="Pour"]//*[@class="deputes"]/li'
    return apply_predicate_data(yes_selector, vote_data)


def get_no_vote(vote_data):
    yes_selector = '//*[@class="Contre"]//*[@class="deputes"]/li'
    return apply_predicate_data(yes_selector, vote_data)


def get_abstention_vote(vote_data):
    yes_selector = '//*[@class="Abstention"]//*[@class="deputes"]/li'
    return apply_predicate_data(yes_selector, vote_data)
