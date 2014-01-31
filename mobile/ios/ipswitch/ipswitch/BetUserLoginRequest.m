//
//  BetUserLoginRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/1/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetUserLoginRequest.h"
#import "BetAccount.h"
#import "AppDelegate.h"

@implementation BetUserLoginRequest : NSObject



//- (BOOL) login: (NSString*) username : (NSString*) password {
- (BOOL) sendRequest {
    
    assert(self.username != nil);
    assert(self.password != nil);
    
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/account/mobile/login/" ];
    NSLog(@"%@", url);
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@", self.username, self.password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    
    NSString *response = [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil] encoding:NSUTF8StringEncoding];
    NSLog(@"Response: %@", response);
    
    NSError *error = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:  [response dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
        return NO;
    }
    
    NSArray* errors = [jsonArray objectForKey:@"errors"];
    if(errors) {
        
        NSLog(@"Errors %@", errors);
        return NO;
        
    } else {
        
        BetAccount *betAccount = [[BetAccount alloc] initWithJSON:response];
        
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDel.userAccount = betAccount;
        NSLog(@"From appdel: %@", [[appDel userAccount] apiToken] );
        return YES;
        
    }
    
    
    
    
    
    
    
}


@end