import re
import json
import logging
import sys
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse, reverse_lazy
from django.template import RequestContext
from django.shortcuts import render_to_response, get_object_or_404
from db_beers.models import Player, Games
from django.forms.models import ModelForm, inlineformset_factory
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.decorators import login_required
import datetime
import pytz

logger = logging.getLogger('django')   # Django's catch-all logger
hdlr = logging.StreamHandler()   # Logs to stderr by default
formatter = logging.Formatter('%(asctime)s %(levelname)s %(message)s')
hdlr.setFormatter(formatter)
logger.addHandler(hdlr) 
logger.setLevel(logging.WARNING)



def login(request):
    return render_to_response('db_beers/login.html',
        {},
        context_instance=RequestContext(request))

def logout(request):
    auth_logout(request)


def login_user(request):
    body = json.loads(request.body)
    username = body['Username']
    password = body['Password']
    
    user = Player.objects.filter(name=username, password=password)
    if user.count():
      return HttpResponse("True", content_type="text/plain")
    else:
      return HttpResponse("False", content_type="text/plain")


def create_game(request):
    body = json.loads(request.body)
    time = body['Time']
    time = datetime.datetime.strptime(time, "%A, %B %d, %Y at %I:%M:%S %p")
    time = time + datetime.timedelta(hours=-5)
    end_time = time + datetime.timedelta(hours=1)
    field = body['Location']
    private = body['Private']
    sport = body['Sport']
    creator = body['Username']
    creator_obj = Player.objects.filter(name=creator)[0]
    priv = False
    if private == "T":
      priv = True
    g = Games(creator=creator_obj, location=field, when_created = datetime.datetime.now(), start_time = time, end_time=end_time, private=priv, visible=False, sport_type=sport)
    g.save()
    g.members.add(creator_obj)
    return HttpResponse("Success", content_type="text/plain")

def join_game(request):
    body = json.loads(request.body)
    username = body['Username']
    gameID = body['GameId']
    user_obj = Player.objects.filter(name=username)[0]
    game_obj = Games.objects.get(id=int(gameID))
    game_obj.members.add(user_obj)
    game_obj.save()
    return HttpResponse("Success", content_type="text/plain")

def leave_game(request):
    body = json.loads(request.body)
    username = body['Username']
    gameID = body['GameId']
    user_obj = Player.objects.filter(name=username)[0]
    game_obj = Games.objects.get(id=int(gameID))
    game_obj.members.remove(user_obj)
    game_obj.save()
    return HttpResponse("Success", content_type="text/plain")

def see_my_games(request):
    body = json.loads(request.body)
    username = body['Username']
    user = Player.objects.filter(name=username)[0]
    my_games = []
    utc = pytz.UTC
    for g in user.participates.all():
      #only return games that haven't ended
      game = []
      if g.end_time < utc.localize(datetime.datetime.now()):
        continue
      game.append(g.creator.name)
      game.append(g.location)
      game.append(g.start_time.strftime("%Y-%m-%d %H:%M"))
      game.append(g.sport_type)
      game.append(g.members.count())
      game.append(g.private)
      game.append(g.id)
      members = []
      for player in g.members.all():
        members.append(player.name)
      game.append(members)
      my_games.append(game)
    return HttpResponse(json.dumps(my_games), content_type="text/plain")

def see_games(request):
    # Returns all games
    games = []
    utc = pytz.UTC
    for g in Games.objects.all():
      #only return games that haven't ended
      game = []
      if g.end_time < utc.localize(datetime.datetime.now()):
        continue
      game.append(g.creator.name)
      game.append(g.location)
      game.append(g.start_time.strftime("%Y-%m-%d %H:%M"))
      game.append(g.sport_type)
      game.append(g.members.count())
      game.append(str(g.private))
      game.append(g.id)
      members = []
      for player in g.members.all():
        members.append(player.name)
      game.append(members)
      games.append(game)
    return HttpResponse(json.dumps(games), content_type="text/plain")

def create_user(request):
    body = json.loads(request.body)
    username = body['Username']
    password = body['Password']
    email = body['Email']
    phone = body['Phone']
    
    overlap = Player.objects.filter(name=username).count()
    new_player = True
    if overlap:
      new_player = False
    else:
      p = Player(name=username, password=password, email=email, phone=phone)
      p.save()
    return HttpResponse(new_player, content_type="text/plain")

def test_create_game(request):
    response = '<html><h3>Creating Sample Data:</h3><p>Player</p><p>Sport</><p>Field</p><p>Game</p>'
    p = Player(name='Sean', password='test')
    p.save()
    s = Sport(name='BasketBall')
    s.save()
    f = Field(name = 'wilson')
    f.save()
    g = Games(creator=p, location=f, when_created = datetime.now(), start_time = datetime.now(), end_time=datetime.now(), private=True, visible=False, sport_type=s)
    g.save()
    response = response + '<p><b>Successful</b></p><h3>Created</h3>'
    response = response + '<p>'+str(p)+'</p>'+'<p>'+str(s)+'</p>'    
    response = response + '<p>'+str(f)+'</p><p>'+str(g)+'</p>'
    return HttpResponse(response, content_type="text/html")

