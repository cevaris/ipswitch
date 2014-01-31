# Create your views here.
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from bet.json import EncodeJSON
from bet.forms import BetCreateForm, ActiveBetForm, BetDecideForm, HistoryBetForm
from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from account.models import BetAccount
from bet.models import Bet

from account.utils import get_bet_account
from django.db.models import Q



@csrf_exempt
@login_required
def mobile_bet_create(request):
    print 'Account bet request'
    
    print request.POST
    
    
    if request.method == 'POST':
        response = EncodeJSON()
        form = BetCreateForm(request.POST)
        
        if form.is_valid():
            print u'Bet Form is valid'
            
            bet_account = get_object_or_404(BetAccount, user=request.user)
            bet = form.save(bet_account) 
            
            if not bet:
                print u'Could not save bet'
                response.add('errors', 'Could not save bet')
            else:    
                print bet.to_dict() 
                response.add('bet', bet.to_dict())

        else:   
            print u'Bet form is invalid'
            response.add('errors', form.errors)
        
        return HttpResponse(response.encode())
     
    else:
        form = BetCreateForm()
    
    return HttpResponse()





    
    
    
    
    
    
    
    
    
@csrf_exempt
@login_required
def mobile_bet_active(request):
    print 'Requesting active bets'
    
    print request.POST
    
    response = EncodeJSON()
    
    bet_account = get_bet_account(request)
        
    if not bet_account:
        response.add('errors', u'Invalid user session')
        return HttpResponse(response.encode())
        
    if request.method == 'POST':
        
        form = ActiveBetForm(request.POST)
        
        if form.is_valid():
            print u'Active Bet Form is valid'
            
            api_token = form.cleaned_data.get('api_token','')
            slug = form.cleaned_data.get('slug','')
        
            if not bet_account.authenticate(slug, api_token):
                response.add('errors', u'Invalid user credentials')
                return HttpResponse(response.encode())

            active_bets = Bet.objects.filter( Q(creator=bet_account.user) | Q(friend=bet_account.user ),
                                              Q(state="new") | Q(state="active") )    
            
            # Converts list of models to list of dictionary
            active_bets = [a.to_dict() for a in active_bets]
            
            print active_bets
            
            response.add('active_bets', active_bets)
            
        else:   
            print u'Active Bet Form invalid'
            response.add('errors', form.errors)
        
        return HttpResponse(response.encode())
     
    else:
        form = ActiveBetForm()
    
    return HttpResponse({'error':u'What are you doing here?'})













@csrf_exempt
@login_required
def mobile_bet_history(request):
    print 'Requesting active bets'
    
    print request.POST
    
    response = EncodeJSON()
    
    bet_account = get_bet_account(request)
        
    if not bet_account:
        response.add('errors', u'Invalid user session')
        return HttpResponse(response.encode())
        
    if request.method == 'POST':
        
        form = HistoryBetForm(request.POST)
        
        if form.is_valid():
            print u'Active Bet Form is valid'
            
            api_token = form.cleaned_data.get('api_token','')
            slug = form.cleaned_data.get('slug','')
        
            if not bet_account.authenticate(slug, api_token):
                response.add('errors', u'Invalid user credentials')
                return HttpResponse(response.encode())

            # Query only completed bets
            active_bets = Bet.objects.filter( Q(creator=bet_account.user) | Q(friend=bet_account.user ),
                                              Q(state="completed") )    
            
            # Converts list of models to list of dictionary
            active_bets = [a.to_dict() for a in active_bets]
            
            print active_bets
            
            response.add('active_bets', active_bets)
            
        else:   
            print u'Active Bet Form invalid'
            response.add('errors', form.errors)
        
        return HttpResponse(response.encode())
         
    return HttpResponse(str({'error':u'What are you doing here?'}))














@csrf_exempt
@login_required
def mobile_bet_decision(request):
    print 'Requesting active bets'
    
    print request.POST
    
    response = EncodeJSON()
    bet_account = get_bet_account(request)
    
    bet = None
    creator_bet_account = None
    friend_bet_account = None    
    
    if not bet_account:
        response.add('errors', u'Invalid user session')
        return HttpResponse(response.encode())
        
    if request.method == 'POST':
        
        form = BetDecideForm(request.POST)
        
        if form.is_valid():
            print u'Active Bet Form is valid'
            
            api_token = form.cleaned_data.get('api_token','')
            slug = form.cleaned_data.get('slug','')
            winner = form.cleaned_data.get('winner', '')
            
            if not bet_account.authenticate(slug, api_token):
                response.add('errors', u'Invalid user credentials')
                return HttpResponse(response.encode())
            
            print api_token, slug, winner, 'Form and user authenticated'
            
            try:
                bet = Bet.objects.get( slug=slug )
                creator_bet_account = BetAccount.objects.get(user=bet.creator)
                friend_bet_account = BetAccount.objects.get(user=bet.friend)
            except Bet.DoesNotExist:
                response.add('errors', u'No such bet found')
                return HttpResponse(response.encode())
            except BetAccount.DoesNotExist:
                response.add('errors', u'Error fetching bet participants')
                return HttpResponse(response.encode())
            
            print creator_bet_account, friend_bet_account, 'Bet accounts located'
            
            if bet.creator != bet_account.user:
                response.add('errors', u'Only the bet creator can decide a bet')
                return HttpResponse(response.encode())
            
            print 'Bet creator and requester match'
            
            print 'Bet wager %d' % bet.wager
            print 'Creator %d, Friend %d' % (creator_bet_account.monies, friend_bet_account.monies)
            
            if bet.creator.username == winner: 
                print 'Creator won'
                bet.winner = bet.creator
                bet.loser = bet.friend
                
                creator_bet_account.monies = creator_bet_account.monies+bet.wager
                creator_bet_account.wins = creator_bet_account.wins+1 
                
                friend_bet_account.monies = friend_bet_account.monies-bet.wager
                friend_bet_account.losses = friend_bet_account.losses+1
                
                if friend_bet_account.monies < 0:
                    friend_bet_account.monies = 0;
                
            elif bet.friend.username == winner:
                print 'Friend won'
                bet.winner = bet.friend
                bet.loser = bet.loser
                
                creator_bet_account.monies = creator_bet_account.monies-bet.wager
                creator_bet_account.losses = creator_bet_account.losses+1
                  
                friend_bet_account.monies = friend_bet_account.monies+bet.wager
                friend_bet_account.wins = friend_bet_account.wins+1
                
                if creator_bet_account.monies < 0:
                    creator_bet_account.monies = 0;
            
            
            print 'Creator %d, Friend %d' % (creator_bet_account.monies, friend_bet_account.monies)
            
            
            
            response.add('result','success')
            
            print 'Successfull'
            
            friend_bet_account.save()
            creator_bet_account.save()
            
            bet.state = 'completed'
            bet.save()
            
            
        else:   
            print u'Active Bet Form invalid'
            response.add('errors', form.errors)
        
        return HttpResponse(response.encode())
    
    return HttpResponse(str({'error': u'What are you doing here?'}))


    
        
    
            
    
    
    
    
    