//
//  BetAccountRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/11/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetAccountRequest.h"
#import "BetAccount.h"
#import "AppDelegate.h"

@implementation BetAccountRequest

- (id) sendRequest {
    
    
    assert(self.username != nil);
    assert(self.api_token != nil);
    assert(self.slug != nil);
    
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/account/mobile/bet/" ];
    NSLog(@"%@", url);
    
    NSString *post = [NSString stringWithFormat:@"api_token=%@&slug=%@&username=%@", self.api_token, self.slug, self.username];
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
        return errors;
        
    } else {
        
        BetAccount *betAccount = [[BetAccount alloc] initWithJSON:response];
        
//        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        appDel.userAccount = betAccount;
//        NSLog(@"From appdel: %@", [[appDel userAccount] apiToken] );

        if(!betAccount){
            return [[NSArray alloc]initWithObjects:@"Could not parse Bet Account", nil];
        }
        
        return betAccount;
        
    }
    
    
    
    
    
    
    
}

@end
