# coding: utf-8


from django.db import models


class Decree(models.Model):
    number = models.IntegerField(unique=True)
    title = models.TextField()
    link = models.TextField(blank=True, null=True)
    date = models.DateField(blank=True, null=True)
    is_solemn = models.BooleanField(default=False)

    class Meta:
        db_table = "Decree"


class Party(models.Model):
    name = models.TextField()

    class Meta:
        db_table = "Party"

    def __str__(self):
        return self.name


class Deputy(models.Model):
    """ Model linked to concrete data table
    """
    id = models.AutoField(primary_key=True)
    surname = models.TextField()
    name = models.TextField()
    slug = models.TextField(unique=True)
    party = models.ForeignKey(Party, related_name='party')

    class Meta:
        db_table = "Deputy"

    def __str__(self):
        return "%s (%s)" % (self.slug, self.party)


# class Deputy(models.Model):
    # """ Model linked to view (
    # """
    # id = models.AutoField(primary_key=True)
    # surname = models.TextField()
    # name = models.TextField()
    # slug = models.TextField(unique=True)
    # stat_vote_count = models.DecimalField(max_digits=42, decimal_places=2)
    # stat_no_vote = models.DecimalField(max_digits=42, decimal_places=2)
    # stat_participation = models.DecimalField(max_digits=42, decimal_places=2)
    # party = models.ForeignKey(Party, related_name='party')

    # class Meta:
        # managed = False
        # db_table = "deputy_statistics"

    # def __str__(self):
        # return "%s (%s)" % (self.slug, self.party)


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
