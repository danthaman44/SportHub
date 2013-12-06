from django.db import models


class Player(models.Model):
    name = models.CharField(max_length=40)
    password = models.CharField(max_length=40)
    email = models.CharField(max_length=40)
    phone = models.CharField(max_length=40)

class Games(models.Model):
    creator = models.ForeignKey(Player)
    location = models.CharField(max_length=40)
    when_created = models.DateTimeField()
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    private = models.BooleanField()
    visible = models.BooleanField()
    members = models.ManyToManyField(Player, related_name="participates")
    sport_type = models.CharField(max_length=40)

