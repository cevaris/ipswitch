//
//  com_cu_ooadAppDelegate.h
//  ipswitch
//
//  Created by Cevaris on 10/9/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//


//#define BASE_URL @"http://10.203.22.64:8000"
#define BASE_URL @"http://172.23.199.232:8000"
//#define BASE_URL @"http://localhost:8000"


#import <UIKit/UIKit.h>
#import "BetAccount.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> 


@property (strong, nonatomic) NSArray *betHistory;
@property (strong, nonatomic) NSArray *activeBets;
@property (strong, nonatomic) BetAccount *userAccount;
@property (strong, nonatomic) UIWindow *window;


- (BOOL) updateData;


@end
