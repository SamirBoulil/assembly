from django.db import models


class Decree(models.Model):
    id = models.IntegerField(primary_key=True)  # AutoField?
    number = models.IntegerField(unique=True, blank=True, null=True)
    title = models.TextField(blank=True, null=True)  # This field type is a guess.
    link = models.TextField(blank=True, null=True)  # This field type is a guess.
    date = models.DateField(blank=True, null=True)

    class Meta:
        db_table="Decree"


class Deputy(models.Model):
    id = models.IntegerField(primary_key=True)
    surname = models.TextField(blank=True, null=True)
    name = models.TextField(blank=True, null=True)
    slug = models.TextField(unique=True, blank=True, null=True)

    class Meta:
        db_table="Deputy"

class Vote(models.Model):
    deputy = models.ForeignKey(Deputy, primary_key=True, related_name='votes')
    decree = models.ForeignKey(Decree, related_name='decree')
    vote_value = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table="Vote"
        unique_together = (('deputy', 'decree'),)

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
