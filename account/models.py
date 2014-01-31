from django.db import models
from core.models import UserProfile
from django.contrib.auth.models import User
from tastypie.models import ApiKey
import datetime



#class PhotoUrl(models.Model):
#    url = models.CharField(max_length=128)
#    uploaded = models.DateTimeField()
#
#    def save(self):                                                                             
#        self.uploaded = datetime.datetime.now()
#        models.Model.save(self)
    

class FriendInvite(models.Model):
    INITIAL_STATE = 'pending' 
    INVITE_STATES = (
        ('pending', 'Pending'),
        ('accepted', 'Accepted'),
        ('rejected', 'Rejected'),
    )
    creator = models.ForeignKey(User, related_name="friend_invite_creator")
    invited = models.ForeignKey(User, related_name="friend_invite_invited")
    state = models.CharField(max_length=30, choices=INVITE_STATES, default=INITIAL_STATE)
    
    def __unicode__(self):
        return u'%s => %s "%s"' % (self.creator, self.invited, self.state)
    
    

class BetAccount(UserProfile):
    

    
    friends = models.ManyToManyField(User, blank=True, null=True, related_name='bet_account_friends')
    friend_invites = models.ManyToManyField(FriendInvite, blank=True, null=True)
    
    monies = models.IntegerField(default=1000)
    
    wins = models.IntegerField(default=0)
    losses = models.IntegerField(default=0)
    
    profile_image_url = models.CharField(max_length=2048,blank=True, null=True)
    
    
    
    def __unicode__(self):
        return u'%s' % self.user
    
    def get_key(self):
        
        try:
            key = ApiKey.objects.get(user=self.user)
            return key.key
        except ApiKey.DoesNotExist:
            return 'No key found'
    
    
    def to_dict(self):
        store = {}
        
        store['id'] = self.id
        store['username'] = self.user.username
        store['slug'] = self.slug
        store['api_token'] = self.get_key()
        store['monies'] = self.monies
        store['wins'] = self.wins
        store['losses'] = self.losses
        store['date_joined'] = self.user.date_joined.strftime('%Y-%m-%dT%H:%M:%S-000')
        
        if self.profile_image_url and len(self.profile_image_url) > 0:
            store['profile_image_url'] = self.profile_image_url
        
        store_friends = []
        for friend in self.friends.all():
            store_friends.append(friend.username)
        store['friends'] =  store_friends
        
            
        store_friend_invites = []
        for invite in self.friend_invites.all():
            store_friend_invites.append([invite.invited.username, invite.state])
        store['friend_invites'] = store_friend_invites
        
        return store
    
    def authenticate(self, slug, api_token):
        
        try:
            ApiKey.objects.get(user=self.user, key=api_token)
            print u'Bet user/api_token match'
            return True
        except:
            return False
        
        try:
            BetAccount.objects.get(user=self.user, slug=slug)
            print u'Bet user/slug match'
            return True
        except:
            return False
        
        
        
        
        
        

class AdminAccount(UserProfile):
    pass

    def __unicode__(self):
        return u'%s' % self.user
    
    
    


