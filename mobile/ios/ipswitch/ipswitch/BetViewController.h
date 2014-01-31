//
//  BetViewController.h
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bet.h"

@class Bet;

@interface BetViewController : UIViewController {
    Bet *bet;
}
@property (weak, nonatomic) IBOutlet UIButton *btnCreator;
@property (weak, nonatomic) IBOutlet UIButton *btnFriend;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblWager;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblBetResult;

@property (weak, nonatomic) IBOutlet UIButton *btnWin;
@property (weak, nonatomic) IBOutlet UIButton *btnLose;



@property (strong, nonatomic) Bet *bet;



- (IBAction)winAction:(id)sender;
- (IBAction)loseAction:(id)sender;

@end
