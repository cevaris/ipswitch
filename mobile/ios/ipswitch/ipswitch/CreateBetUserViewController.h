//
//  CreateBetUserViewController.h
//  ipswitch
//
//  Created by Cevaris on 12/1/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateBetUserViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIButton *btnCreateUser;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;




- (IBAction)createBetUserAction:(id)sender;
- (IBAction)cancelAction:(id)sender;



@end
