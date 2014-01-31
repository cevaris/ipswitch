//
//  CreateBetViewController.h
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateBetViewController : UIViewController <UITextViewDelegate>



@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnCreate;
@property (weak, nonatomic) IBOutlet UITextField *txtTitle;

@property (weak, nonatomic) IBOutlet UITextField *txtWager;
@property (weak, nonatomic) IBOutlet UITextField *txtInviteFriend;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

- (IBAction)actionCancel:(id)sender;
- (IBAction)actionCreate:(id)sender;



@end
