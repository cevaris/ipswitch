//
//  BetCreateRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/6/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetCreateRequest : NSObject

- (BOOL) createBet: (NSString*) title: (NSNumber*) wager: (NSString*) description: (NSString*) inviteFriend;

@end
