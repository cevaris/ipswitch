//
//  BetDecisionRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/11/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetDecisionRequest : NSObject


@property (strong, nonatomic) NSString *api_token;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *winner;


- (BOOL) sendRequest;

@end
