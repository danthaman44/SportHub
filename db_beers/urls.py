from django.conf.urls import patterns, include, url

urlpatterns = patterns('db_beers.views',
    url(r'^login$', 'login'),
    url(r'^logout$', 'logout'),
    url(r'^create_game', 'create_game'),
    url(r'^see_games', 'see_games'),
    url(r'^create_user', 'create_user'),
    url(r'^login_user', 'login_user'),
    url(r'^join_game', 'join_game'),
    url(r'^see_my_games', 'see_my_games'),
    url(r'^leave_game', 'leave_game')
)

