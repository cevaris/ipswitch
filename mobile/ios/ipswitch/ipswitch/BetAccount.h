//
//  BetAccount.h
//  ipswitch
//
//  Created by Cevaris on 12/4/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetAccount : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *apiToken;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) UIImage *profileImage;

@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSNumber *monies;
@property (strong, nonatomic) NSNumber *wins;
@property (strong, nonatomic) NSNumber *losses;

@property (strong, nonatomic) NSDate *joinDate;

@property (strong, nonatomic) NSMutableArray* friends;
@property (strong, nonatomic) NSMutableArray* friendInvites;


- (id) initWithJSON: (NSString*) document;

@end
