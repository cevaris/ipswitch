//
//  BetHistoryRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/12/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetHistoryRequest.h"
#import "AppDelegate.h"
#import "Bet.h"

@implementation BetHistoryRequest


- (BOOL) sendRequest {
    
    assert(self.api_token != nil);
    assert(self.slug != nil);
    
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/bet/mobile/history" ];
    NSLog(@"%@", url);
    
    NSString *post = [NSString stringWithFormat:@"api_token=%@&slug=%@", self.api_token, self.slug];
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
        
        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        appDel.betHistory = [Bet toObjects:response];
        
        for( Bet *aBet in [appDel betHistory]){
            NSLog(@"id %@", [aBet id]);
            NSLog(@"state %@", [aBet state]);
            NSLog(@"title %@", [aBet title]);
            NSLog(@"wager %@", [aBet wager]);
            NSLog(@"creator %@", [aBet creator]);
            NSLog(@"friend %@", [aBet friend]);
            NSLog(@"description %@", [aBet description]);
            NSLog(@"slug %@", [aBet slug]);
            NSLog(@"created %@", [aBet created]);
            NSLog(@"\n");
            
        }
        return YES;
    
    }
    
}

@end
