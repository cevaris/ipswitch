//
//  CreateBetViewController.m
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "CreateBetViewController.h"
#import "BetCreateRequest.h"
#import "BetViewController.h"
#import "AppDelegate.h"
#import "BetAccount.h"

@interface CreateBetViewController ()

@end

@implementation CreateBetViewController

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
	// Do any additional setup after loading the view.
    
    self.txtDescription.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animateTextView:textView up:YES];
    NSLog(@"Editing textView");
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animateTextView:textView up:NO];
}



- (void) animateTextView: (UITextView*) textView up: (BOOL) up
{
    const int movementDistance = 130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (IBAction)actionCancel:(id)sender {    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if([[segue identifier] isEqualToString:@"SEGUE_VIEW_BET_AFTER_CREATE"]){
//        
//        NSLog(@"Segue Id: %@", [segue identifier]);
//        BetViewController *betView = [segue destinationViewController];
//        
//        
//        NSLog(@"Selecting %d", [indexPath row]);
//        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        NSArray *betHistory = [appDel betHistory];
//        
//        Bet *bet = [betHistory objectAtIndex:[indexPath row]];
//        
//        if(betHistory == nil){
//            NSLog(@"Bet history is empty");
//            return;
//        }
//        
//        //        [betView setBet:bet];
//        betView.bet = bet;
//        
//        
//        
//    }
//    
//}

- (IBAction)actionCreate:(id)sender {
    
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *betAcccount = [appDel userAccount];
    NSNumber *wager = [NSNumber numberWithInt:[[self.txtWager text] intValue]];
    
    if (betAcccount){
        
        NSLog(@"BetAccountMonies:%@ ProposedWager:%@", betAcccount.monies, wager);
        if([betAcccount.monies integerValue] < [wager integerValue]){

           [[[UIAlertView alloc] initWithTitle:@"Invalid Wager"
                                       message:[NSString stringWithFormat:@"Max Wager is %@ ", betAcccount.monies]
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil] show];
            return;
        }
        
    } else {
        //Do not do request, user is not logged in
        return;
    }
    
    
    
    
    BetCreateRequest *betCreateRequest = [[BetCreateRequest alloc] init];
    BOOL result = [betCreateRequest createBet:[self.txtTitle text]
                                             :wager
                                             :[self.txtDescription text]
                                             :[self.txtInviteFriend text]];
    
    if(!result){
        
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Could not create bet"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        
    } else {
        // Succesfull bet creation]
        //[self performSegueWithIdentifier:@"SEGUE_VIEW_BET_AFTER_CREATE" sender:self];
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDel updateData];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
