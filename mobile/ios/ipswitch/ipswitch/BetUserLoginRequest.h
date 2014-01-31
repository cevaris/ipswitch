//
//  BetUserLoginRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/1/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetUserLoginRequest : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

- (BOOL) sendRequest;

@end
