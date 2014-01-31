//
//  SettingsViewController.m
//  ipswitch
//
//  Created by Cevaris on 12/6/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "SettingsViewController.h"
#import "BetUserLogoutRequest.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

- (IBAction)actionLogout:(id)sender {
    
    
    BetUserLogoutRequest *logoutRequest = [[BetUserLogoutRequest alloc] init];
    [logoutRequest logout];
    
    NSLog(@"Logged out user");
    [self.navigationController popToRootViewControllerAnimated:YES];
         
    
}




@end
