//
//  BetDecisionRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/11/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetDecisionRequest.h"
#import "AppDelegate.h"

@implementation BetDecisionRequest

- (BOOL) sendRequest {
    
    assert(self.api_token != nil);
    assert(self.slug != nil);
    assert(self.winner != nil);
    
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/bet/mobile/decision/" ];
    NSLog(@"%@", url);
    
    NSString *post = [NSString stringWithFormat:
                      @"api_token=%@&slug=%@&winner=%@",
                      self.api_token, self.slug, self.winner];
    
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
        
//        BetAccount *betAccount = [[BetAccount alloc] initWithJSON:response];
//        
//        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        appDel.userAccount = betAccount;
//        NSLog(@"From appdel: %@", [[appDel userAccount] apiToken] );
        return YES;
        
    }
    
}


@end
