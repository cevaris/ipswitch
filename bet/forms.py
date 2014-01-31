from django import forms
from account.utils import create_user
from account.models import BetAccount
from core.utils import generate_unique_slug
from django.contrib.auth.models import User
from bet.models import Bet
from django.shortcuts import get_object_or_404
import re




class BetAccountForm(forms.Form):
    username = forms.CharField(max_length=100)
    api_token = forms.CharField(max_length=100)
    slug = forms.SlugField(max_length=50)
    
    
    
class ActiveBetForm(forms.Form):
    api_token = forms.CharField(max_length=100)
    slug = forms.SlugField(max_length=50)
    
    
class HistoryBetForm(forms.Form):
    api_token = forms.CharField(max_length=100)
    slug = forms.SlugField(max_length=50)



class BetDecideForm(forms.Form):
    api_token = forms.CharField(max_length=100)
    slug = forms.SlugField(max_length=50)
    winner = forms.CharField(max_length=50)

class BetUserLoginForm(forms.Form):
    
    username = forms.CharField(max_length=100, error_messages={'required':u'Username is required'})           
    password = forms.CharField(widget=forms.PasswordInput(render_value=False), error_messages={'required':u'Password is required'})



class BetAccountCreateForm(forms.ModelForm):
    email = forms.EmailField(max_length=256)
    username = forms.CharField(max_length=75)
    password = forms.CharField(widget=forms.PasswordInput())
#    password_confirm = forms.CharField(widget=forms.PasswordInput())
    
    class Meta:
        model = BetAccount
        exclude = ('user', 'slug', 'losses', 'wins', 'monies')


    def clean_email(self):
        data = self.cleaned_data.get('email','').strip()
        try:
            User.objects.get(email=data)
            raise forms.ValidationError(u'Email %s already exists, please choose another' % data )
        except User.DoesNotExist:
            return data
        
        
    def clean_username(self):
        data = self.cleaned_data.get('username','').strip()
        try:
            User.objects.get(username=data)
            raise forms.ValidationError(u'Userame %s already exists, please choose another' % data )
        except User.DoesNotExist:
            return data        

#    def clean(self):
#        data = self.cleaned_data.get('password','').strip()
#        data_confirm = self.cleaned_data.get('password_confirm','').strip()
#        
#        if data and data_confirm and data != data_confirm:
#            self._errors["password"] = self.error_class([u'Passwords do not match' ])
#        
#        return self.cleaned_data
    
    
    def save(self, commit=True):
        """
        - Extracts form data
        - Searches User database for user with same email
          - Found email, reuse the User object for new Role
          - Did not find email, create teh User object for new Role 
        """
        email = self.cleaned_data.get('email')
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')
        
        # Create user for new role
        user = create_user(email, username, password, is_active=True)
        user.save()
        print user
        
        # Create each role
        user_account = BetAccount.objects.create(
               user=user,
               slug=generate_unique_slug('account','BetAccount')
        )
        
        user_account.save()
        print user_account
        
        return user_account
    
    
    

    
    
class BetCreateForm(forms.ModelForm):
    title = forms.CharField(max_length=75)
    wager = forms.IntegerField()
    description = forms.CharField(max_length=1024)
    invite_friend = forms.CharField(max_length=75)
    
    
    class Meta:
        model = Bet
        exclude = ('slug', 'creator', 'created', 'friend', 'state', 'winner', 'loser')


    def clean_invite_friend(self):
        data = self.cleaned_data.get('invite_friend','').strip()
        try:
            User.objects.get(username=data)
            return data # Valid User
        except User.DoesNotExist:
            raise forms.ValidationError(u'No such user "%s" found' % data )
    
    def clean_wager(self):
        data = str(self.cleaned_data.get('wager','')).strip()
        
        if re.match(r"[-+]?\d+$", data) is None:
            raise forms.ValidationError(u'Wager "%s" is not an integer' % data )
        return data
    
    def save(self, bet_account, commit=True):
        
        
        wager = self.cleaned_data.get('wager')
        title = self.cleaned_data.get('title')
        description = self.cleaned_data.get('description')
        
        
        if int(wager) > int(bet_account.monies):
            print u'Wager is invalid %s %s' % (wager, bet_account.monies)
            self._errors["wager"] = self.error_class([u'Invalid wager. Wager max is %d' % bet_account.monies ])
            return False
        
        try:
            # Convert friend
            friend = User.objects.get(username=self.cleaned_data.get('invite_friend').lower())
        except:
            return False
        
        # Everything checks out, proceed
        bet = Bet.objects.create(creator=bet_account.user, title=title, wager=wager, description=description, friend=friend)
                        
        return bet
    
    
    
    
    
    
    
    
    
    