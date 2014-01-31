#from account.models import UserAccount
from django import forms
from django.contrib.auth.models import User
from account.utils import create_user
from core.utils import generate_unique_slug
import bet
from account.models import BetAccount


class ProfileImageUploadForm(forms.Form):
    api_token = forms.CharField(max_length=100)
    slug = forms.SlugField(max_length=50)
#    file = forms.ImageField()


class UserAccountCreateForm(forms.ModelForm):
    pass
#    
#    email = forms.EmailField()
#    first_name = forms.CharField(max_length=75)
#    last_name = forms.CharField(max_length=75)
#    password = forms.CharField(widget=forms.PasswordInput())
#    password_confirm = forms.CharField(widget=forms.PasswordInput())
#    
#    class Meta:
#        model = UserAccount
#        exclude = ('user', 'slug', 'activities')
#    
#    def clean_email(self):
#        """
#        Detect any other applicant with the same email.
#        Emails must be unique across Applicants
#        """
#        data = self.cleaned_data.get('email','').strip()
#        try:
#            User.objects.get(email=data)
#            raise forms.ValidationError(u'Email %s already exists, please choose another' % data )
#        except User.DoesNotExist:
#            return data
#
#    def clean(self):
#        data = self.cleaned_data.get('password','').strip()
#        data_confirm = self.cleaned_data.get('password_confirm','').strip()
#        
#        if data and data_confirm and data != data_confirm:
#            self._errors["password"] = self.error_class([u'Passwords do not match' ])
#        
#        return self.cleaned_data
#    
#    
#    def save(self, commit=True):
#        """
#        - Extracts form data
#        - Searches User database for user with same email
#          - Found email, reuse the User object for new Role
#          - Did not find email, create teh User object for new Role 
#        """
#        password = self.cleaned_data.get('password')
#        email = self.cleaned_data.get('email')
#        first_name = self.cleaned_data.get('first_name')
#        last_name = self.cleaned_data.get('last_name') 
#        
#        # Create user for new role
#        user = create_user(email, password, is_active=True)
#        user.first_name = first_name
#        user.last_name = last_name
#        # TODO: Need to send email request to mark as active
#        user.save()
#        print user
#        
#        # Create each role
#        user_account = UserAccount.objects.create(
#               user=user,
#               slug=generate_unique_slug('account','UserAccount')
#        )
#        
#        user_account.save()
#        print user_account
#        
#        return user_account










