//
//  ActiveBetsViewController.m
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "ActiveBetsViewController.h"
#import "ActiveBetCell.h"
#import "AppDelegate.h"
#import "Bet.h"
#import "BetViewController.h"


@interface ActiveBetsViewController ()

@end

@implementation ActiveBetsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *actveBets = [appDel activeBets];
    
    if(actveBets == nil){
        NSLog(@"No Active Bets Exists");
        return 0;
    }
    
    return [actveBets count];

}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *actveBets = [appDel activeBets];
    
    if(actveBets == nil){
        NSLog(@"No Active Bets Exists");
        return nil;
    }
    
    ActiveBetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ACTIVE_BET_CELL"];
    
    if (cell == nil){
        
        NSLog(@"Looking for object at index %d, collection size is %d", [indexPath row], [actveBets count]);

       
        cell = [[ActiveBetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ACTIVE_BET_CELL"];
        
    }
    
    Bet *bet = [actveBets objectAtIndex:[indexPath row]];
    cell.lblTitle.text = bet.title;
    cell.lblFriendUsername.text = bet.friend;
    cell.lblWager.text = [[bet wager] stringValue];

    
    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Do nothing, handled by segue.

}


-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"SEGUE_BET_VIEW"]){
        NSLog(@"Segue Id: %@", [segue identifier]);
        BetViewController *betView = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSLog(@"Selecting %d", [indexPath row]);
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSArray *actveBets = [appDel activeBets];
        Bet *bet = [actveBets objectAtIndex:[indexPath row]];
        
        if(actveBets == nil){
            NSLog(@"No Active Bets Exists");
            return;
        }
        
        betView.bet = bet;
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];

    [self.tableView reloadData];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
