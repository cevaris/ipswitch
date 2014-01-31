//
//  com_cu_ooadAppDelegate.m
//  ipswitch
//
//  Created by Cevaris on 10/9/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "AppDelegate.h"
#import "ActiveBetsRequest.h"
#import "BetAccountRequest.h"
#import "BetHistoryRequest.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL) updateData {

    BetAccount *userAccount = [self userAccount];
    
    if(userAccount == nil){
        NSLog(@"You must be logged in to refresh");
        return FALSE;
    }
    
    // Update active bets
    ActiveBetsRequest *activeBetRequest = [[ActiveBetsRequest alloc] init];
    BOOL activeBetSuccess = [activeBetRequest requestActiveBets:[userAccount apiToken]:[userAccount slug]];
    NSLog(@"Update Active Bets Success: %@", activeBetSuccess ? @"Yes":@"NO");
        
    BetAccountRequest *betAccountRequest = [[BetAccountRequest alloc]init];
    betAccountRequest.username = [userAccount username];
    betAccountRequest.slug = [userAccount slug];
    betAccountRequest.api_token = [userAccount apiToken];
    id betAccountData = [betAccountRequest sendRequest];
    BOOL betAccountSuccess =FALSE;
    NSLog(@"Update BetUser Success: %@", betAccountData);
    
    if([betAccountData isMemberOfClass:[BetAccount class]]){
        self.userAccount = betAccountData;
        betAccountSuccess = TRUE;
    } else if([betAccountData isMemberOfClass:[NSArray class]]){
        NSLog(@"Error: %@", [betAccountData componentsJoinedByString:@","]);
        betAccountSuccess = FALSE;
    }
    
    
    BetHistoryRequest *betHistoryRequest = [[BetHistoryRequest alloc] init];
    [betHistoryRequest setApi_token:[userAccount apiToken]];
    [betHistoryRequest setSlug:[userAccount slug]];
    BOOL betHistorySuccess = [betHistoryRequest sendRequest];
    
//    BOOL BetHistorySuccess = [activeBetRequest requestActiveBets:[userAccount apiToken]:[userAccount slug]];
    NSLog(@"Update Bet History Success: %@", betHistorySuccess ? @"Yes":@"NO");
    
    return activeBetSuccess && betAccountSuccess;

}

@end
