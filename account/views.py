

from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import redirect, get_object_or_404
from django.contrib.auth import authenticate, login, logout
from django.template import loader
from django.template.context import RequestContext
from django.core.context_processors import csrf

import mimetypes
from django.conf import settings
from boto.s3.connection import S3Connection
from boto.s3.key import Key



from core.utils import add_form_error, generate_slug
from core.forms import UserLoginForm
from core.views import view_404, view_error
from account.forms import UserAccountCreateForm, ProfileImageUploadForm
from account.utils import auto_login_user, get_bet_account
from django.contrib.auth.decorators import login_required
from django.views.decorators.csrf import csrf_exempt
from bet.forms import BetAccountCreateForm, BetUserLoginForm, BetAccountForm
from bet.json import EncodeJSON
from account.models import BetAccount
from django.forms.models import model_to_dict




def account_login(request):
    print 'User Login Request'
    # Grab any redirects
    redirect_to = request.GET.get('next', False)
    # Stop here if user is already logged in
    if request.user.is_authenticated():
        return redirect('account')
        
    if request.method == 'POST':
        form = UserLoginForm(request.POST)
        
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            user = authenticate(username=username, password=password)
            
            if user is not None:
                if user.is_active:
                    print u'User %s authenticated' % user
                    login(request, user)
                    
                    if redirect_to:
                        # Go back to previous page
                        return HttpResponseRedirect(redirect_to)
                    else:
                        return redirect('account_user', user.username)
                else:
                    add_form_error(form, u'Your account has been disabled!')
            else:
                add_form_error(form, u'Your username or password were incorrect.')
        else:
            print u'Form is Invalid'
    else:
        form = UserLoginForm()

    context = {'path':request.path,'form':form, 
               'csrf_token':csrf(request),'next':redirect_to}
    
    t = loader.get_template('user-login.html')
    c = RequestContext(request, context)
    return HttpResponse(t.render(c))


@csrf_exempt
def mobile_account_login(request):
    print 'Mobile User Login Request'
    # Stop here if user is already logged in
    
    print request.POST
        
    if request.method == 'POST':
        form = BetUserLoginForm(request.POST)
        
        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']
            print u'%s %s' % (username, password)
            user = authenticate(username=username, password=password)
            
            if user is not None:
                print u'User %s authenticated' % user
                login(request, user)
                
                bet_account = get_object_or_404(BetAccount, user=user)
                
                response = EncodeJSON()
                response.add('bet_account', bet_account.to_dict())
                print u'Responding %s' % response.encode()
                return HttpResponse(response.encode())
            else:
                response = EncodeJSON()
                response.add('errors', [u'Your username or password were incorrect.'])
                print u'Responding %s' % response.encode()
                return HttpResponse(response.encode())
        else:
            response = EncodeJSON()
            response.add('errors', form.errors)
            print u'Responding %s' % response.encode()
            return HttpResponse(response.encode())
    else:
        form = UserLoginForm()

    response = EncodeJSON()
    response.add('errors', ['Invalid Request'])
    return HttpResponse(response.encode())














@csrf_exempt
def mobile_account_create(request):
    print 'Account create request'
    
    print request.POST
    
    if request.method == 'POST':
        form = BetAccountCreateForm(request.POST)
        if form.is_valid():
            print u'Account Form is valid'
            
            user_account = form.save()
            
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            
            if auto_login_user(request, username, password):
                
                response = EncodeJSON()
                response.add('user', user_account.to_dict())
                return HttpResponse(response.encode()) 
                
            else:
                view_error(request, u'There was an error in creating your account')
        else:
            print u'Account Form is invalid'
            response = EncodeJSON()
            response.add('errors', form.errors)
            return HttpResponse(response.encode()) 
    else:
        form = BetAccountCreateForm()
    
    
#    context = {'path':request.path, 'form':form}
#    t = loader.get_template('account-create.html')
#    c = RequestContext(request, context)
#    return HttpResponse(t.render(c))
    return HttpResponse()











@csrf_exempt
@login_required
def mobile_bet_account(request):
    print 'Requesting bet account'
    
    print request.POST
    
    response = EncodeJSON()
    
    bet_account = get_bet_account(request)
        
    if not bet_account:
        response.add('errors', u'Invalid user session')
        return HttpResponse(response.encode())
        
    if request.method == 'POST':
        
        form = BetAccountForm(request.POST)
        
        if form.is_valid():
            print u'Active Bet Form is valid'
            
            username = form.cleaned_data.get('username','')
            api_token = form.cleaned_data.get('api_token','')
            slug = form.cleaned_data.get('slug','')
        
            if not bet_account.authenticate(slug, api_token):
                response.add('errors', u'Invalid user credentials')
                return HttpResponse(response.encode())
            
            requested_bet_account = BetAccount.objects.get(user__username=username)
            
            response = EncodeJSON()
            response.add('bet_account', requested_bet_account.to_dict())
            print u'Responding %s' % response.encode()
            return HttpResponse(response.encode())
            
        else:   
            print u'Active Bet Form invalid'
            response.add('errors', form.errors)
        
        return HttpResponse(response.encode())
     
    
    return HttpResponse(str({'error':u'What are you doing here?'}))







@csrf_exempt
def mobile_account_logout(request):
    
    logout(request)
    return HttpResponse('Successful')

def account_logout(request):
    
    logout(request)
    return HttpResponse('Successful')










@login_required(login_url='/account/login')
def account(request, slug):
    print 'request Account %s ' % slug

    context = {'path':request.path}
    t = loader.get_template('account.html')
    c = RequestContext(request, context)
    return HttpResponse(t.render(c))










@csrf_exempt
@login_required
def account_create(request):
    
    print 'Account create request'
    
    if request.method == 'POST':
        form = UserAccountCreateForm(request.POST)
        if form.is_valid():
            print u'Account Form is valid'
            
            user_account = form.save()
            
            username = form.cleaned_data.get('email')
            password = form.cleaned_data.get('password')
            
            if auto_login_user(request, username, password):
                return redirect('account', user_account.slug)
            else:
                view_error(request, u'There was an error in creating your account')
        else:
            print u'Account Form is invalid'
    else:
        form = UserAccountCreateForm()
    
    
    context = {'path':request.path, 'form':form}
    t = loader.get_template('account-create.html')
    c = RequestContext(request, context)
    return HttpResponse(t.render(c))







@csrf_exempt
@login_required
def account_mobile_profile_image_upload(request):   
    
    print request.POST
    print request.FILES
    
    response = EncodeJSON()
    
    bet_account = get_bet_account(request)
        
    if not bet_account:
        response.add('errors', u'Invalid user session')
        return HttpResponse(response.encode())
        
    if request.method == 'POST':
        
        form = ProfileImageUploadForm(request.POST)
        
        if form.is_valid():
            print u'Active Bet Form is valid'
            
            api_token = form.cleaned_data.get('api_token','')
            slug = form.cleaned_data.get('slug','')
        
            if not bet_account.authenticate(slug, api_token):
                response.add('errors', u'Invalid user credentials')
                return HttpResponse(response.encode())

            print 'Authorized User'
            
            
            file_obj = request.FILES['file']
            filename = file_obj.name 
            pre_filename = generate_slug(25) + '-' +bet_account.slug + '-'
            content = file_obj.read()
            
            
            conn = S3Connection(settings.AWS_ACCESS_KEY_ID, settings.AWS_SECRET_ACCESS_KEY)
            b = conn.create_bucket('images.my.bet')
            mime = mimetypes.guess_type(filename)[0]
            k = Key(b)
            k.key = pre_filename + filename 
            k.set_metadata("Content-Type", mime)
            k.set_contents_from_string(content)
            k.set_acl("public-read")
            print 'Saved file to S3', filename
            
            
            # Save to bet account
            bet_account.profile_image_url = "https://s3.amazonaws.com/images.my.bet/"  + pre_filename + filename 
            bet_account.save()
            
            print 'Saved to', filename
            
            return HttpResponse("Success")
            
        else:   
            print u'Active Bet Form invalid'
            response.add('errors', form.errors)
        
        return HttpResponse(response.encode())  
    
    return HttpResponse(str({'error':u'What are you doing here?'}))



