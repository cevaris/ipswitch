//
//  BetUserCreateRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/1/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetUserCreateRequest.h"
#import "BetAccount.h"
#import "AppDelegate.h"

@implementation BetUserCreateRequest


- (BOOL) sendRequest {
    
    assert(self.username != nil);
    assert(self.email != nil);
    assert(self.password != nil);
    
    NSString * base = BASE_URL;
    NSString * url = [NSString stringWithFormat:@"%@%@", base, @"/account/mobile/create/" ];
    NSLog(@"%@", url);
    
    NSString *post = [NSString stringWithFormat:@"username=%@&email=%@&password=%@", self.username, self.email, self.password];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSString *response = [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil] encoding:NSUTF8StringEncoding];
    
    NSLog(@"\nResponse: %@",response);
    
    
    
    return YES;
}



@end
