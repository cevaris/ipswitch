//
//  MainMenuViewController.h
//  ipswitch
//
//  Created by Cevaris on 11/29/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *txtUsername;
@property (weak, nonatomic) IBOutlet UIButton *btnActiveBets;

- (IBAction)fullRefreshAction:(id)sender;

@end
