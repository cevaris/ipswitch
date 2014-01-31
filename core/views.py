# Create your views here.

import random

from django.template import loader
from django.template.context import RequestContext
from django.http import HttpResponse
from django.http import HttpResponseNotFound
from django.shortcuts import redirect

from account.utils import get_bet_account





def home(request):
    
    print 'Requesting home'
    
    user_account = get_bet_account(request)
    
    if user_account:
        return redirect('account', user_account.slug)

    context = {
       'path':request.path ,'user':request.user,
       'account':user_account,
    }
    t = loader.get_template('home.html')
    c = RequestContext(request, context)
    return HttpResponse(t.render(c))





def contact(request):
    print 'Requesting contact info'
    
    user_account = get_bet_account(request)
    
    context = {'path':request.path,'user':request.user,
               'account':user_account}
    
    t = loader.get_template('contact.html')
    c = RequestContext(request, context)
    return HttpResponse(t.render(c))





def about(request):
    print 'Requesting about'
    
    user_account = get_bet_account(request)
    
    context = {'path':request.path,'user':request.user,
               'account':user_account}
    
    t = loader.get_template('about.html')
    c = RequestContext(request, context)
    return HttpResponse(t.render(c))





def view_404(request,message=None):
    
    collection_size = 3
    collection_404 = []
    #Load 404 pages
    for i in range(0,collection_size):
        collection_404.append('404_%d.html' % i)
    #Choose random 404 page
    page_404 = random.choice(collection_404) or '400_1.html'
    
    context = {'message': unicode(str(message) or ''),}
    t = loader.get_template(page_404)
    c = RequestContext(request, context)
    return HttpResponseNotFound(t.render(c))





def view_error(request,message=None):
    """
    Same as 404 page
    """
    print u'Error %s' % message
    
    user_account = get_bet_account(request)
    
    collection_size = 3
    collection_404 = []
    #Load 404 pages
    for i in range(0,collection_size):
        collection_404.append('404_%d.html' % i)
    #Choose random 404 page
    page_404 = random.choice(collection_404) or '400_1.html'
    
    context = {'message': unicode(str(message) or ''),
               'account':user_account}
    t = loader.get_template(page_404)
    c = RequestContext(request, context)
    return HttpResponseNotFound(t.render(c))



    
    
    
    
    
    
    
    
    
    
    
    

    
    
        
    
            
    
    
    
    
    