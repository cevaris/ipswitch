//
//  Bet.h
//  ipswitch
//
//  Created by Cevaris on 12/8/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bet : NSObject

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *friend;
@property (strong, nonatomic) NSString *creator;
@property (strong, nonatomic) NSString *winner;
@property (strong, nonatomic) NSString *loser;
@property (strong, nonatomic) NSString *state;

@property (strong, nonatomic) NSNumber *wager;

@property (strong, nonatomic) NSDate *created;



+ (NSArray*) toObjects: (NSString*) jsonDocument;
@end
