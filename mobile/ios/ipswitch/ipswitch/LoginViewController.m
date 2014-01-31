//
//  LoginViewController.m
//  ipswitch
//
//  Created by Cevaris on 11/27/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "LoginViewController.h"
#import "BetUserLoginRequest.h"
#import "MainMenuViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    
//    self.navigationController.navigationBar.hidden = YES;
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)loginAction:(id)sender {
    
    
    BetUserLoginRequest *loginRequest = [[BetUserLoginRequest alloc] init];
    loginRequest.username = [self.txtUsername text];
    loginRequest.password = [self.txtPassword text];
    
    BOOL result = [loginRequest sendRequest];    
    //Boolean result = [loginRequest login:[self.txtUsername text] :[self.txtPassword text]];
    
    
    if(!result){
        
        [[[UIAlertView alloc] initWithTitle:@"Login Error"
                                    message:@"Username/Password is Invalid."
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
        return;
    } else {
        // Pops current view back to previous view controller
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }     
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
