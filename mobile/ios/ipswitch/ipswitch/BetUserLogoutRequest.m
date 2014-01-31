//
//  BetUserLogoutRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/6/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetUserLogoutRequest.h"
#import "AppDelegate.h"

@implementation BetUserLogoutRequest

- (BOOL) logout {
    
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/account/mobile/logout/" ];
    NSLog(@"%@", url);
    
    NSData *postData = [url dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    

    NSString *response = [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil] encoding:NSUTF8StringEncoding];
    

    NSLog(@"Response: %@", response);
    
    
    AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDel.userAccount = nil;

    return YES;
    
}


@end
