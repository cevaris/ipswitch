//
//  SelectProfileImageViewController.m
//  ipswitch
//
//  Created by Cevaris on 12/12/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "SelectProfileImageViewController.h"
#import "BetUserProfileImageUploadRequest.h"
#import "AppDelegate.h"
#import "BetAccount.h"

@interface SelectProfileImageViewController ()

@end

@implementation SelectProfileImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

        self.picker = [[UIImagePickerController alloc] init];
        
        self.picker.delegate = self;
        self.picker.sourceType = self.sourceType;
        
        
    }
    return self;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];
    
    if(!userAccount){
        NSLog(@"Bet Account is nil");
        return;
    }
    
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [userAccount setProfileImage:pickedImage];


//    BetUserProfileImageUploadRequest *imageUploadRequest = [[BetUserProfileImageUploadRequest alloc]init];
//    [imageUploadRequest setProfileImage:pickedImage];
//    BOOL success = [imageUploadRequest sendRequest];
//
//    NSLog(@"Successfull Image Upload: %@", success ? @"Yes" : @"No");




    
    

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
