# coding: utf-8


from django.core.management.base import BaseCommand, CommandError

from scrapper.import_data import import_data_votes_for_link

from scrapper.settings import BASE_URL
from scrapper.settings import LISTE_SCRUTIN_URL


class Command(BaseCommand):
    help = 'Imports decrees, deputy information and votes'

    def add_arguments(self, parser):
        parser.add_argument('--overwrite',
                            '-o',
                            dest='overwrite',
                            default=False,
                            help="If TRUE truncate the current database before "
                            "importing data")
        parser.add_argument('--offset',
                            dest='offset',
                            default=0,
                            type=int,
                            help="define the offset uri component in url to start with")

    def handle(self, *args, **options):
        overwrite = options.get('overwrite')
        offset = options.get('offset')

        if overwrite:
            raise NotImplemented("Dump all data from db feature")
            return

        for i in range(offset, 1200, 100):
            page_url = BASE_URL+LISTE_SCRUTIN_URL.format(offset=i)
            print("Parsing link page %s" %  page_url)
            import_data_votes_for_link(page_url)
