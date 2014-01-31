//
//  BetAccount.m
//  ipswitch
//
//  Created by Cevaris on 12/4/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "BetAccount.h"

@implementation BetAccount



- (id)initWithJSON: (NSString*) document {
    self = [super init];
    if (self) {
    }
    return [self toObject:document];
}


- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (id) toObject: (NSString*) jsonDocument {
    
    NSError *error = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:  [jsonDocument dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }

    NSDictionary* bet_account = [jsonArray objectForKey:@"bet_account"];
    
    self.id = [bet_account objectForKey:@"id"];
    NSLog(@"%@", self.id);

    
    self.username = [bet_account objectForKey:@"username"];
    NSLog(@"%@", self.username);
    self.apiToken = [bet_account objectForKey:@"api_token"];
    NSLog(@"%@", self.apiToken);
    self.slug = [bet_account objectForKey:@"slug"];
    NSLog(@"%@", self.slug);
    self.monies = [bet_account objectForKey:@"monies"];
    NSLog(@"%@", self.monies);

    self.wins = [bet_account objectForKey:@"wins"];
    NSLog(@"Wins: %@", self.wins);
    self.losses = [bet_account objectForKey:@"losses"];
    NSLog(@"Losses: %@", self.losses);
    
//    NSURL *imageURL = [NSURL URLWithString:[bet_account objectForKey:@"profile_image_url"]];
//    
//    
//    if (imageURL){
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // Update the UI
//                self.profileImage = [UIImage imageWithData:imageData];
//                NSLog(@"Got image");
//            });
//        });
//    }
    
    NSString* profileImageUrl = [bet_account objectForKey:@"profile_image_url"];
    if(profileImageUrl){
        NSURL *imageURL = [NSURL URLWithString:profileImageUrl];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        self.profileImage = [UIImage imageWithData:imageData];
    }

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    self.joinDate = [dateFormatter dateFromString:[bet_account objectForKey:@"date_joined"]];
    
    //self.joinDate = [bet_account objectForKey:@"join_date"];
    NSLog(@"Join Date: %@", self.joinDate);
    
    
    self.friends = [bet_account objectForKey:@"friends"];
    if(self.friends){
        for(NSString* friend in self.friends){
            NSLog(@"%@", friend);
        }
    }
    
    self.friendInvites = [bet_account objectForKey:@"friend_invites"];
    if(self.friendInvites){
        for(NSArray* invite in self.friendInvites){
            NSLog(@"%@, %@", invite[0], invite[1]);
        }
    }
    
    return self;
}
- (NSString*) toJson{
    
    return @"Not implemented";
    
}


@end
