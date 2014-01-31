//
//  MainMenuViewController.m
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "MainMenuViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "ActiveBetsRequest.h"
#import "BetAccountRequest.h"
#import "ProfileViewController.h"


@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:FALSE];
}

- (void) viewDidAppear:(BOOL)animated {
    
//    self.navigationController.navigationBar.hidden = NO;

    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];

    if(userAccount != nil){
        self.txtUsername.text = [userAccount username];
        NSLog(@"%@ logged in", [userAccount username]);
        
        [appDel updateData];
        
    } else {
        LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        //        [self.navigationController pushViewController:loginViewController animated:YES];
        //        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([[segue identifier] isEqualToString:@"SEGUE_MENU_TO_PROFILE"]){
        
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        BetAccount *userAccount = [appDel userAccount];
        
        if(!userAccount){
            NSLog(@"Bet Account is nil");
            return;
        }
        
        ProfileViewController *profileView = [segue destinationViewController];
        [profileView setBetAccount:userAccount];
        
    }

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fullRefreshAction:(id)sender {
    
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDel updateData];
    
//    // Update active bets
//    ActiveBetsRequest *activeBetRequest = [[ActiveBetsRequest alloc] init];
//    BOOL activeBetSuccess = [activeBetRequest requestActiveBets:[userAccount apiToken]:[userAccount slug]];
//    NSLog(@"Update Active Bets Success: %@", activeBetSuccess ? @"Yes":@"NO");
//    
//    BetAccountRequest *betAccountRequest = [[BetAccountRequest alloc]init];
//    betAccountRequest.username = [userAccount username];
//    betAccountRequest.slug = [userAccount slug];
//    betAccountRequest.api_token = [userAccount apiToken];
//    id betAccountData = [betAccountRequest sendRequest];
//    NSLog(@"Update BetUser Success: %@", betAccountData);
//    
//    if([betAccountData isMemberOfClass:[BetAccount class]]){
//        appDel.userAccount = betAccountData;
//        
//    } else if([betAccountData isMemberOfClass:[NSArray class]]){
//        NSLog(@"Error: %@", [betAccountData componentsJoinedByString:@","]);
//        
//    }
    
}
@end
