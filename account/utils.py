from django.contrib.auth.models import User
from django.db import IntegrityError
from django.shortcuts import redirect
from django.contrib.auth import login, authenticate
from account.models import BetAccount
from bet.models import Bet




def create_user(email, username, password=None, is_staff=None, is_active=None):
    try:
        user = User.objects.create_user(username, email, password)
    except IntegrityError, err:
        if err.message == 'column username is not unique':
            raise IntegrityError('user email is not unique')
        raise

    if is_active is not None or is_staff is not None:
        if is_active is not None:
            user.is_active = is_active
        if is_staff is not None:
            user.is_staff = is_staff
        user.save()
    return user




def get_bet_account(request):
    try:
        if request.user.is_authenticated():
            return BetAccount.objects.get(user=request.user)
    except BetAccount.DoesNotExist:
        return None

    
    
    
def auto_login_user(request, username, password):
    # Auto log in user
    user = authenticate(username=username, password=password)
    
    if user is not None:
        print u'User %s authenticated' % user
        # Log in user
        login(request, user)
        return True
    else:
        return False    
    
    
    
    
    
    
    
    
    