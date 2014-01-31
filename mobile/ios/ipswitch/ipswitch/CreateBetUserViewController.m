//
//  CreateBetUserViewController.m
//  ipswitch
//
//  Created by Cevaris on 12/1/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "CreateBetUserViewController.h"
#import "BetUserCreateRequest.h"
#import "Validation.h"

@interface CreateBetUserViewController ()

@end

@implementation CreateBetUserViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createBetUserAction:(id)sender {
    
    if([Validation isPasswordValid:[self.txtPassword text]] && ([[self.txtPassword text] isEqualToString:[self.txtConfirmPassword text]])
       && (![self.txtUsername.text length] == 0) && (![self.txtEmail.text length] == 0)){
        
        
        BetUserCreateRequest *createBetUserRequest = [[BetUserCreateRequest alloc] init];
        createBetUserRequest.username = [self.txtUsername text];
        createBetUserRequest.email = [self.txtEmail text];
        createBetUserRequest.password = [self.txtPassword text];
        BOOL success = [createBetUserRequest sendRequest];
        NSLog(@"Success Create User: %c",success);
        
        //[createBetUserRequest createBetUser:[self.txtUsername text]: [self.txtEmail text] :[self.txtPassword text]];

        [self dismissViewControllerAnimated:YES completion:nil];
        //[self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could Not Create User"
                                                        message:@"Please make sure you have entered your username and email, your passwords match, are at least 4 characters long, and have at least one letter and one number"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}



- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}




@end
