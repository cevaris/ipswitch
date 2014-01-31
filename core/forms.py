from django import forms

class UserLoginForm(forms.Form):
    
    username = forms.EmailField(max_length=100)           
    password = forms.CharField(widget=forms.PasswordInput(render_value=False), error_messages={'required':u'Password is required'})
    
        
        
    