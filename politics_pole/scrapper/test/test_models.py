# coding: utf-8

import os
import unittest

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

from scrapper.models import Deputy
from scrapper.models import Decree

Base = declarative_base()
engine = create_engine('sqlite:///tests_data.db')
Base.metadata.bind = engine
session = sessionmaker(bind=engine)
db_session = session()


class TestModel(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        """
        """
        self.decree_number = 1064
        self.decree_title = """Scrutin public sur la motion de rejet préalable, présentée par M. Bruno Le Roux, de la proposition de loi visant à assouplir le mécanisme dit du "droit d'option départemental" (première lecture)."""
        self.decree_date = '12/06/2015'
        self.deputy_name = 'Bachelay'
        self.deputy_surname = 'Alexis'
        self.vote_type = 1

    def test_insert_decree(self):
        decree = Decree(
            decree_number=get_decree_number(decree_vote_data),
            title=get_decree_title(decree_vote_data),
            date=get_decree_date(decree_vote_data)
        )
        db_session.add(decree)
        db.commit()

    def test_insert_deputy(self):
        self.assertTrue(False)

    def test_insert_vote(self):
        self.assertTrue(False)

    @classmethod
    def tearDownClass(cls):
        """
        """
        os.remove('tests_data.db')

if __name__=="__main__":
    print("Hello tests")
    unittest.main()