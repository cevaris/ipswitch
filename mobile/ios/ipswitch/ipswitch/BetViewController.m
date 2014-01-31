//
//  BetViewController.m
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetViewController.h"
#import "BetAccount.h"
#import "AppDelegate.h"
#import "BetDecisionRequest.h"
#import "BetAccountRequest.h"
#import "ProfileViewController.h"

@interface BetViewController ()

@end

@implementation BetViewController

@synthesize bet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.lblTitle.text = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.lblTitle.text = [self.bet title];
    [self.btnCreator setTitle:[self.bet creator] forState:UIControlStateNormal];
    [self.btnFriend setTitle:[self.bet friend] forState:UIControlStateNormal];
    self.lblWager.text = [[self.bet wager] stringValue];
    self.txtViewDescription.text = [self.bet description];
    
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];
    
    if(userAccount != nil){
        // If current user is creator of bet
        if ([[userAccount username] isEqualToString:[self.bet creator]]){
            // Admin can view bet decision controls
            self.btnLose.hidden = FALSE;
            self.btnWin.hidden = FALSE;
            
        } else {
            // Non-admin cannot view bet decision controls
            self.btnLose.hidden = TRUE;
            self.btnWin.hidden = TRUE;
        }
    }
    
    
    
    if([self.bet winner] != nil && [[self.bet state] isEqualToString:@"completed" ]){
        self.btnWin.hidden = TRUE;
        self.btnLose.hidden = TRUE;
        
        self.lblBetResult.hidden = FALSE;
        
        NSLog(@" Winner:%@, User:%@", self.bet.winner, [userAccount username]);
        if ([self.bet.winner isEqualToString:[userAccount username]]) {
            self.lblBetResult.text = @"You won!";
        } else {
            self.lblBetResult.text = @"You lost.";
        }
    }


    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (IBAction)viewFriendAction:(id)sender {
//    
//}
//
//- (IBAction)viewCreatorAction:(id)sender {
//}

-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender {
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *betAccount = [appDel userAccount];

    
    NSLog(@"Segue Id: %@", [segue identifier]);
    
    
    if([[segue identifier] isEqualToString:@"SEGUE_BET_CREATOR"] || [[segue identifier] isEqualToString:@"SEGUE_BET_FRIEND"]){
        
        NSString *queryUsername = nil;

        if([[segue identifier] isEqualToString:@"SEGUE_BET_CREATOR"] ){
            queryUsername = [self.bet creator];
        }
        
        
        if([[segue identifier] isEqualToString:@"SEGUE_BET_FRIEND"]){            
            queryUsername = [self.bet friend];
        }
        
        
        BetAccountRequest *betAccountRequest = [[BetAccountRequest alloc]init];
        [betAccountRequest setApi_token: [betAccount apiToken]];
        [betAccountRequest setSlug:[betAccount slug]];
        [betAccountRequest setUsername:queryUsername];
        //Fetch data
        id data = [betAccountRequest sendRequest];
        
        if ([data isMemberOfClass:[BetAccount class]]){
            ProfileViewController *profileView = [segue destinationViewController];
            [profileView setBetAccount:data];
        }
        
    }
}

- (IBAction)winAction:(id)sender {
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];
    
    if(userAccount == nil){
        return;
    }
    
    BetDecisionRequest *betDecision = [[BetDecisionRequest alloc]init];
    betDecision.api_token = [userAccount apiToken];
    betDecision.slug = [self.bet slug];
    // User/Creator One
    betDecision.winner = [self.bet creator];

    BOOL success = [betDecision sendRequest];
    
    if (success) {
        self.btnLose.hidden = TRUE;
        self.btnWin.hidden = TRUE;
    }
    
    self.lblBetResult.text = @"You won!";
    self.lblBetResult.hidden = FALSE;
    
    //Refresh data
    [appDel updateData];
    
}

- (IBAction)loseAction:(id)sender {
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];
    
    if(userAccount == nil){
        return;
    }
    
    BetDecisionRequest *betDecision = [[BetDecisionRequest alloc]init];
    betDecision.api_token = [userAccount apiToken];
    betDecision.slug = [self.bet slug];
    // Friend one
    betDecision.winner = [self.bet friend];

    BOOL success = [betDecision sendRequest];
    
    if (success) {
        self.btnLose.hidden = TRUE;
        self.btnWin.hidden = TRUE;
    }
    
    self.lblBetResult.text = @"You lost.";
    self.lblBetResult.hidden = FALSE;
  
    //Refresh data
    [appDel updateData];
}
@end
