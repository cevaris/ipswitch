//
//  BetAccountRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/11/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetAccountRequest : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *api_token;
@property (strong, nonatomic) NSString *slug;



- (id) sendRequest;

@end
