//
//  BetCreateRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/6/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetCreateRequest.h"
#import "Bet.h"
#import "BetAccount.h"
#import "AppDelegate.h"

@implementation BetCreateRequest


- (BOOL) createBet: (NSString*) title: (NSNumber*) wager: (NSString*) description: (NSString*) inviteFriend {
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/bet/mobile/create/" ];
    NSLog(@"%@", url);
    
    NSString *post = [NSString stringWithFormat:
                      @"title=%@&wager=%@&description=%@&invite_friend=%@",
                      title, wager, description, inviteFriend];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSLog(@"%@",post);
    
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
                
//        Bet *bet = [[Bet alloc] initWithJSON:response];
        
//        AppDelegate *appDel = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//        NSLog(@"From appdel: %@", [[appDel userAccount] apiToken] );
//        NSLog(@"No Errors, parsed fine: %@",jsonArray);
        NSLog(@"Successfull Bet Creation");
        return YES;
        
    }
}

@end
