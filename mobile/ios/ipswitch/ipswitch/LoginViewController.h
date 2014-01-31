//
//  LoginViewController.h
//  ipswitch
//
//  Created by Cevaris on 11/27/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

//@interface LoginViewController : UINavigationController
@interface LoginViewController : UIViewController <UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;




- (IBAction)loginAction:(id)sender;


@end
