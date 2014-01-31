//
//  SettingsViewController.h
//  ipswitch
//
//  Created by Cevaris on 12/6/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

- (IBAction)actionLogout:(id)sender;

@end
