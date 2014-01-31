from django.contrib import admin

from bet.models import Bet, BetInvite
#from bet.models import BetState
from tastypie.models import ApiAccess, ApiKey

admin.site.register(Bet)
#admin.site.register(BetState)
admin.site.register(BetInvite)

admin.site.register(ApiAccess)
admin.site.register(ApiKey)


