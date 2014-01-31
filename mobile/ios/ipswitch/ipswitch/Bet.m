//
//  Bet.m
//  ipswitch
//
//  Created by Cevaris on 12/8/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "Bet.h"

@implementation Bet



- (id)initWithJSON: (NSString*) document {
    self = [super init];
    if (self) {
        self = [self toObject:document];
    }
    return self;
}


- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (Bet*) toObject: (NSString*) jsonDocument {
    
    
    NSError *error = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:  [jsonDocument dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }
    
    
    NSDictionary* bet = [jsonArray objectForKey:@"bet"];

    self.id = [bet objectForKey:@"id"];
    NSLog(@"%@", self.id);

    self.slug = [bet objectForKey:@"slug"];
    NSLog(@"%@", self.slug);
    
    self.title = [bet objectForKey:@"title"];
    NSLog(@"%@", self.title);
    
    self.description = [bet objectForKey:@"description"];
    NSLog(@"%@", self.description);
    
    self.wager = [bet objectForKey:@"wager"];
    NSLog(@"%@", self.wager);
    
    self.state = [bet objectForKey:@"state"];
    NSLog(@"%@", self.state);
    
    self.friend = [bet objectForKey:@"friend"];
    NSLog(@"%@", self.friend);
    
    self.creator = [bet objectForKey:@"creator"];
    NSLog(@"%@", self.creator);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
                                                    //2012-12-08T20:20:38
//    self.joinDate = [dateFormatter dateFromString:@"2011-04-05T16:28:22-0700"];
    self.created = [dateFormatter dateFromString:[bet objectForKey:@"created"]];
   
    NSLog(@"Created: %@", self.created);
 
    
//    self.friendInvites = [bet_account objectForKey:@"friend_invites"];
//    if(self.friendInvites){
//        for(NSArray* invite in self.friendInvites){
//            NSLog(@"%@, %@", invite[0], invite[1]);
//        }
//    }
//    
    return self;
    
}



+ (NSArray*) toObjects: (NSString*) jsonDocument {
    
    NSMutableArray *bets = [[NSMutableArray alloc] init];
    
    NSError *error = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:  [jsonDocument dataUsingEncoding:NSUTF8StringEncoding] options: NSJSONReadingMutableContainers error: &error];
    
    if (!jsonArray) {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }

    
    NSArray* jsonBets = [jsonArray objectForKey:@"active_bets"];
    
    for (NSDictionary *jsonBet in jsonBets) {
        Bet *bet = [[Bet alloc] init];
        
        bet.id = [jsonBet objectForKey:@"id"];
        NSLog(@"%@", bet.id);
        
        bet.slug = [jsonBet objectForKey:@"slug"];
        NSLog(@"%@", bet.slug);
        
        bet.title = [jsonBet objectForKey:@"title"];
        NSLog(@"%@", bet.title);
        
        bet.description = [jsonBet objectForKey:@"description"];
        NSLog(@"%@", bet.description);
        
        bet.wager = [jsonBet objectForKey:@"wager"];
        NSLog(@"%@", bet.wager);
        
        bet.state = [jsonBet objectForKey:@"state"];
        NSLog(@"%@", bet.state);
        
        bet.friend = [jsonBet objectForKey:@"friend"];
        NSLog(@"%@", bet.friend);
        
        bet.creator = [jsonBet objectForKey:@"creator"];
        NSLog(@"%@", bet.creator);
        
        bet.winner = [jsonBet objectForKey:@"winner"];
        NSLog(@"%@", bet.winner);

        bet.loser = [jsonBet objectForKey:@"loser"];
        NSLog(@"%@", bet.loser);

        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
        bet.created = [dateFormatter dateFromString:[jsonBet objectForKey:@"created"]];        
        NSLog(@"Created: %@", bet.created);
        
        
        //    self.friendInvites = [bet_account objectForKey:@"friend_invites"];
        //    if(self.friendInvites){
        //        for(NSArray* invite in self.friendInvites){
        //            NSLog(@"%@, %@", invite[0], invite[1]);
        //        }
        //    }
        //
        
        [bets addObject:bet];
        
    }
    return bets;
    
}


@end
