# coding: utf-8


import xml.etree.ElementTree as ET
from sqlalchemy import create_engine
from sqlalchemy import Sequence
from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Date
from sqlalchemy import ForeignKey
from sqlalchemy import and_
from sqlalchemy.sql import exists
from sqlalchemy.orm import relationship, backref
from sqlalchemy.ext.declarative import declarative_base
from slugify import slugify

from parsing import get_decree_number
from parsing import get_decree_title
from parsing import get_decree_date
from parsing import get_deputy_list
from parsing import get_deputy_name
from parsing import get_deputy_surname
from parsing import get_yes_vote
from parsing import get_no_vote
from parsing import get_abstention_vote


Base = declarative_base()


class Deputy(Base):
    __tablename__ = 'deputy'

    id = Column(Integer, Sequence('user_id_seq'), primary_key=True)
    surname = Column(String)
    name = Column(String)
    slug = Column(String, unique=True)

    votes = relationship("Vote")

    def __repr__(self):
        return "<User(id= '%s', surname='%s', name='%s', slug='%s')>" % (
            self.id, self.surname, self.name, self.slug)


class Decree(Base):
    __tablename__ = 'decree'

    id = Column(Integer, Sequence('decree_id_seq'),  primary_key=True)
    decree_number = Column(Integer, unique=True)
    title = Column(String)
    link = Column(String)
    date = Column(Date)
    # description = Column(String)

    def __repr__(self):
        return "<Decree(id='%s', number='%d', title='%s', date='%s')>" % (
            self.id, self.decree_number, self.title, str(self.date))


class Vote(Base):
    __tablename__ = 'vote'

    deputy_id = Column('deputy_id', Integer, ForeignKey('deputy.id'), primary_key=True)
    decree_id = Column('decree_id', Integer, ForeignKey('decree.id'), primary_key=True)
    vote_value = Column(Integer)  # 0: Against, 1: for, 2: abstention

    deputy = relationship("Deputy", backref="deputy_decree")
    decree = relationship("Decree", backref="decree_deputy")

    def __repr__(self):
        return "<Vote(deputy='%s', decree='%s', vote='%s')>" % (
            self.deputy, self.decree, self.vote_to_str(self.vote_value))

    def vote_to_str(vote_id):
        """ Translates the vote_type_id (integer)
        to sring.
        """
        if vote_id == 0:
            return "Contre"
        elif vote_id == 1:
            return "Pour"
        elif vote_id == 2:
            return "Abstention"
        else:
            raise ValueError("Vote type id unknown")


engine = create_engine('sqlite:///data.db')
Base.metadata.create_all(engine)


def import_decree(decree_vote_data, db):
    """
    """
    decree_number = get_decree_number(decree_vote_data)

    if not db.query(exists().where(Decree.decree_number==decree_number)).scalar():
        decree = Decree(
            decree_number=decree_number,
            title=get_decree_title(decree_vote_data),
            date=get_decree_date(decree_vote_data)
        )
        print("Inserting decree %s" % (str(decree)))
        db.add(decree)
    else:
        raise Exception("Decree not imported")


def import_deputies(decree_vote_data, db):
    """
    """
    for deputy in get_deputy_list(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        if not db.query(exists().where(Deputy.slug==slug)).scalar():
            deputy = Deputy(
                name=name,
                surname=surname,
                slug=slug
            )
            print("Inserting Deputy %s" % (str(deputy)))
            db.add(deputy)


def import_yes_votes(decree_vote_data, db):
    """
    """
    decree_number = get_decree_number(decree_vote_data)
    decree_id = db.query(Decree.id).filter(Decree.decree_number==decree_number).scalar()

    if decree_id is None:
        raise Exception("Yes vote - Decree not found")

    for deputy in get_yes_vote(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        deputy_id = db.query(Deputy.id).filter(Deputy.slug == slug).scalar()
        if deputy_id is None:
            raise Exception("Yes vote - Deputy not found")

        present = db.query(exists().where(and_(Vote.deputy_id==deputy_id,
                                               Vote.decree_id==decree_id,
                                               Vote.vote_value==1))).scalar()

        if not present:
            vote = Vote(
                decree_id=decree_id,
                deputy_id=deputy_id,
                vote_value=1
            )
            print("Inserting Yes Vote for deputy %s %s" % (surname, name))
            db.add(vote)


def import_no_votes(decree_vote_data, db):
    """
    """
    decree_number = get_decree_number(decree_vote_data)
    decree_id = db.query(Decree.id).filter(Decree.decree_number==decree_number).scalar()
    if decree_id is None:
        raise Exception("No vote - Decree not found")

    for deputy in get_no_vote(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        deputy_id = db.query(Deputy.id).filter(Deputy.slug == slug).scalar()
        if deputy_id is None:
            raise Exception("No vote - Deputy not found")

        present = db.query(exists().where(and_(Vote.deputy_id==deputy_id,
                                               Vote.decree_id==decree_id,
                                               Vote.vote_value==0))).scalar()
        if not present:
            vote = Vote(
                decree_id=decree_id,
                deputy_id=deputy_id,
                vote_value=0
            )
            print("Inserting No Vote for deputy %s %s" % (surname, name))
            db.add(vote)


def import_abstention_votes(decree_vote_data, db):
    """
    """
    decree_number = get_decree_number(decree_vote_data)
    decree_id = db.query(Decree.id).filter(Decree.decree_number==decree_number).scalar()
    if decree_id is None:
        raise Exception("No vote - Decree not found")

    for deputy in get_abstention_vote(decree_vote_data):
        name = get_deputy_name(ET.tostring(deputy).decode('utf-8'))
        surname = get_deputy_surname(ET.tostring(deputy))
        slug = slugify(name + "_" + surname).lower()

        deputy_id = db.query(Deputy.id).filter(Deputy.slug == slug).scalar()
        if deputy_id is None:
            raise Exception("No vote - Deputy not found")

        present = db.query(exists().where(and_(Vote.deputy_id==deputy_id,
                                               Vote.decree_id==decree_id,
                                               Vote.vote_value==2))).scalar()
        if not present:
            vote = Vote(
                decree_id=decree_id,
                deputy_id=deputy_id,
                vote_value=2
            )
            print("Inserting Abstention Vote for deputy %s %s" % (surname, name))
            db.add(vote)
