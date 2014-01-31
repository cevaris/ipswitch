from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('bet.views',
                       
    url(r'^mobile/create/?$',  'mobile_bet_create',  name='mobile_bet_create'),
    url(r'^mobile/active/?$',  'mobile_bet_active',  name='mobile_bet_active'),
    url(r'^mobile/history/?$',  'mobile_bet_history',  name='mobile_bet_history'),
    
    url(r'^mobile/decision/?$',  'mobile_bet_decision',  name='mobile_bet_decision'),
    
    
    # Examples:
    # url(r'^$', 'argos.views.home', name='home'),
#    url(r'^/?$', 'home', name='home'),
#    url(r'^about/?$', 'about', name='about'),
#    url(r'^contact/?$', 'contact', name='contact'),
    
    # url(r'^argos/', include('argos.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
