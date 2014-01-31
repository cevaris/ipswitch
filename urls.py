from django.conf.urls import patterns, include, url
from account.api import BetAccountResource
# Uncomment the next two lines to enable the admin:
from django.contrib import admin


admin.autodiscover()

bet_account_resources = BetAccountResource()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ipswitch.views.home', name='home'),
    # url(r'^ipswitch/', include('ipswitch.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    
    
    
    # The normal jazz here...
    url(r'^account/', include('account.urls')),
    url(r'^bet/', include('bet.urls')),
    url(r'^api/', include(bet_account_resources.urls)),

)




