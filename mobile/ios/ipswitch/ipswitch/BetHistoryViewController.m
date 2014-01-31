//
//  BetHistoryViewController.m
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetHistoryViewController.h"
#import "AppDelegate.h"
#import "HistoryBetCell.h"
#import "Bet.h"
#import "BetViewController.h"

@interface BetHistoryViewController ()

@end

@implementation BetHistoryViewController

- (int) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *betHistory = [appDel betHistory];
    
    if(betHistory == nil){
        NSLog(@"Bet history is empty");
        return 0;
    }
    
    return [betHistory count];
    
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSArray *betHistory = [appDel betHistory];
    BetAccount *userAccount = [appDel userAccount];
    
    if(betHistory == nil){
        NSLog(@"Bet history is empty");
        return nil;
    }
    
    HistoryBetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HISTORY_BET_CELL"];
    
    if (cell == nil){
        
        NSLog(@"Looking for object at index %d, collection size is %d", [indexPath row], [betHistory count]);
        
        cell = [[HistoryBetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HISTORY_BET_CELL"];
        
    }
    
    Bet *bet = [betHistory objectAtIndex:[indexPath row]];
    cell.lblTitle.text = bet.title;
    cell.lblWager.text = [[bet wager] stringValue];

    
    if([[bet winner] isEqualToString:[userAccount username]]){
        cell.lblResult.text = @"You Won!";
        
    } else {
        cell.lblResult.text = @"You lost.";
    }
    
    NSLog(@"Title: %@, Wager: %@, Result: %@, ", [cell.lblTitle text], [cell.lblWager text], [cell.lblResult text]);
    
    return cell;
    
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Do nothing, handled by segue.
    
}


-(void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"SEGUE_HISTORY_BET_VIEW"]){
      
        NSLog(@"Segue Id: %@", [segue identifier]);
        BetViewController *betView = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSLog(@"Selecting %d", [indexPath row]);
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        NSArray *betHistory = [appDel betHistory];
        
        Bet *bet = [betHistory objectAtIndex:[indexPath row]];
        
        if(betHistory == nil){
            NSLog(@"Bet history is empty");
            return;
        }
        
//        [betView setBet:bet];
        betView.bet = bet;
        
       
        
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    
    
    
    [self.tableView reloadData];
    
    NSLog(@"Loading bet history");
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
