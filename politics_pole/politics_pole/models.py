from django.db import models


class Decree(models.Model):
    number = models.IntegerField(unique=True)
    title = models.TextField()
    link = models.TextField(blank=True, null=True)
    date = models.DateField(blank=True, null=True)

    class Meta:
        db_table = "Decree"


class Party(models.Model):
    name = models.TextField()

    class Meta:
        db_table = "Party"

    def __str__(self):
        return self.name


class Deputy(models.Model):
    surname = models.TextField()
    name = models.TextField()
    slug = models.TextField(unique=True)
    party = models.ForeignKey(Party, related_name='party')

    class Meta:
        db_table = "Deputy"

    def __str__(self):
        return "%s (%s)" % (self.slug, self.party)


class Vote(models.Model):
    deputy = models.ForeignKey(Deputy, related_name='votes')
    decree = models.ForeignKey(Decree, related_name='decree')
    vote_value = models.IntegerField()

    class Meta:
        db_table = "Vote"
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
