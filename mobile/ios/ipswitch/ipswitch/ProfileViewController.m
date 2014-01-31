//
//  ProfileViewController.m
//  ipswitch
//
//  Created by Cevaris on 10/23/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "BetAccount.h"
#import "SelectProfileImageViewController.h"
#import "BetUserProfileImageUploadRequest.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    
    
    assert(self.betAccount != nil);
    
    
    self.lblWins.text = [[self.betAccount wins] stringValue];
    self.lblLosses.text = [[self.betAccount losses]stringValue];

    if ([[self.betAccount losses] intValue] == 0){
        self.lblWLRatio.text = @"1.0";
    } else {
        float wlRatio = [[self.betAccount wins] doubleValue]/([[self.betAccount losses] doubleValue]+[[self.betAccount wins] doubleValue]) ;
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:2];
        [formatter setMinimumFractionDigits:0];
        NSString *wlRatioStr = [formatter stringFromNumber:[NSNumber numberWithFloat:wlRatio]];
        
        NSLog(@"%@ %@ %@", wlRatioStr, [self.betAccount wins], [self.betAccount losses]);

        self.lblWLRatio.text = [NSString stringWithFormat:@"%.2f",[wlRatioStr floatValue]];;
    }

    self.lblUsername.text = [self.betAccount username];
    self.lblMonies.text = [[self.betAccount monies]stringValue];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    self.lblJoinDate.text = [dateFormatter stringFromDate:[self.betAccount joinDate]];
    
    if([self.betAccount profileImage] != nil){
        [self.imgProfile setImage: [self.betAccount profileImage]];
    }
    
    
}

- (IBAction) selectImageTypeAction {
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];
    
    if(!userAccount){
        NSLog(@"Bet Account is nil");
        return;
    }
    
    if (![[self.betAccount username] isEqualToString:[userAccount username]]){
        NSLog(@"Cannot edit another users profile image");
        return;
    }
    
    UIActionSheet *selectImageTypeSheet = [[UIActionSheet alloc]
                                           initWithTitle:@""
                                           delegate:self
                                           cancelButtonTitle:@"Cancel"
                                           destructiveButtonTitle:nil
                                           otherButtonTitles:@"Take a Picutre", @"Image from Library", @"Image from Photo Album", nil];
    
    
    [selectImageTypeSheet showInView:self.view];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    BetAccount *userAccount = [appDel userAccount];
    
    if(!userAccount){
        NSLog(@"Bet Account is nil");
        return;
    }
    
    UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    // Set profile view image
    [self.imgProfile setImage:pickedImage];
    // Set user account image
    [[appDel userAccount] setProfileImage:pickedImage];
    
    BetUserProfileImageUploadRequest *profileImageUplaodRequest = [[BetUserProfileImageUploadRequest alloc]init];
    [profileImageUplaodRequest setProfileImage:pickedImage];
    [profileImageUplaodRequest setApiToken:[userAccount apiToken]];
    [profileImageUplaodRequest setSlug:[userAccount slug]];
    BOOL success = [profileImageUplaodRequest sendRequest];
    NSLog(@"Succesful image upload %@", success ? @"Yes" : @"No");
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.editing = YES;
    self.picker.delegate = self;
    
    switch (buttonIndex) {
        case 0:
            NSLog(@"Open Camera");
            [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1:
            NSLog(@"Open Library");
            [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        
        case 2:
            NSLog(@"Open Photo Albums");
            [self.picker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            break;
        
        case 3:
            NSLog(@"Nevermind...");
            return;
            break;
            
        default:
            assert(FALSE);
            break;
    }
    [self presentViewController:self.picker animated:YES completion:nil];
    
//    [self.navigationController pushViewController:selectProfileImageView animated:YES];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
