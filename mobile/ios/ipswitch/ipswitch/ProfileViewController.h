//
//  ProfileViewController.h
//  ipswitch
//
//  Created by Cevaris on 10/23/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BetAccount.h"


@class BetAccount;
@interface ProfileViewController : UIViewController <UINavigationControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnChangeImage;
@property (weak, nonatomic) IBOutlet UILabel *lblWins;
@property (weak, nonatomic) IBOutlet UILabel *lblLosses;
@property (weak, nonatomic) IBOutlet UILabel *lblWLRatio;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblMonies;
@property (weak, nonatomic) IBOutlet UILabel *lblJoinDate;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) BetAccount *betAccount;


- (IBAction)selectImageTypeAction;

@end
