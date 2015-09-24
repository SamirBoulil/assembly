# coding: utf-8


import requests

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

from models import import_deputies
from models import import_decree
from models import import_yes_votes
from models import import_no_votes
from models import import_abstention_votes

from parsing import get_vote_links

base_url = "http://www2.assemblee-nationale.fr"
liste_scrutin_url = "/scrutins/liste/(legislature)/14/(type)/TOUS/(idDossier)/TOUS"


def download_data(url):
    """ Downloads data
    """
    response = requests.get(url)
    response.raise_for_status()
    return response.text


def main():
    """ Parses the list of scrutin URL from the list of scrutin.
    """
    Base = declarative_base()
    engine = create_engine('sqlite:///data.db')
    Base.metadata.bind = engine
    session = sessionmaker(bind=engine)
    db_session = session()

    print("****** Parsing list of links ******")
    poll_list_page = download_data(base_url + liste_scrutin_url)
    links = get_vote_links(poll_list_page)
    print("number of votes to parse  %d" % (len(links)))

    for link in links:
        print("******* Parsing link %s *******" % (base_url + link))
        decree_vote_data = download_data(base_url + link)

        print("*** Inserting Decrees ***")
        import_decree(decree_vote_data, db_session)

        print("*** Parsing Deputies ***")
        import_deputies(decree_vote_data, db_session)

        import_yes_votes(decree_vote_data, db_session)
        import_no_votes(decree_vote_data, db_session)
        import_abstention_votes(decree_vote_data, db_session)

    db_session.commit()


if __name__ == "__main__":
    main()