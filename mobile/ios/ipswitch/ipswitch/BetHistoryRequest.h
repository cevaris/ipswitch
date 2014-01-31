//
//  BetHistoryRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/12/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetHistoryRequest : NSObject

@property (strong, nonatomic) NSString *api_token;
@property (strong, nonatomic) NSString *slug;


- (BOOL) sendRequest;


@end
