from django.db import models
from django.contrib.auth.models import User
from core.utils import generate_slug

class BetInvite(models.Model):
    INITIAL_STATE = 'pending' 
    INVITE_STATES = (
        ('pending', 'Pending'),
        ('accepted', 'Accepted'),
        ('rejected', 'Rejected'),
    )
    creator = models.ForeignKey(User, related_name="bet_invite_creator")
    invited = models.ForeignKey(User, related_name="bet_invite_invited")
    state = models.CharField(max_length=30, choices=INVITE_STATES, default=INITIAL_STATE)
    
    def __unicode__(self):
        return u'%s => %s "%s"' % (self.creator, self.invited, self.state)
    
    
class Bet(models.Model):
    
    INITIAL_STATE = 'active' 
    BET_STATES = (
        ('new', 'New'),
        ('active', 'Active'),
        ('completed', 'Completed'),
    )
    
    slug = models.SlugField(default=generate_slug)
    title = models.CharField(max_length=50)
    description = models.CharField(max_length=500)
    wager = models.IntegerField(default=10)
    
    created = models.DateTimeField(auto_now_add=True)
    creator = models.ForeignKey(User)
    
    friend = models.ForeignKey(User, related_name='bet_friend')
    
    state = models.CharField(max_length=30, choices=BET_STATES, default=INITIAL_STATE)
    
    winner = models.ForeignKey(User, blank=True, null=True, related_name='bet_winner')
    loser = models.ForeignKey(User, blank=True, null=True, related_name='bet_loser')
    
    def __unicode__(self):
        return u'Title[%s] Bet[%s->%s] Wager[%d] State[%s]' % (self.title, self.creator, self.friend, self.wager, self.state)


    def to_dict(self):
        store = {}
        
        store['id'] = self.id
        store['slug'] = self.slug
        store['title'] = self.title
        store['wager'] = self.wager
        store['description'] = self.description
        store['state'] = self.state
        
        if self.winner:
            store['winner'] = self.winner.username
        if self.loser:
            store['loser'] = self.loser.username
                
        store['created'] = self.created.strftime('%Y-%m-%dT%H:%M:%S-000')
        
        store['creator'] = self.creator.username
        store['friend'] = self.friend.username

        return store
  
    
    