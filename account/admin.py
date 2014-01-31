from django.contrib import admin
from account.models import FriendInvite, AdminAccount, BetAccount


admin.site.register(BetAccount)
admin.site.register(FriendInvite)
admin.site.register(AdminAccount)


