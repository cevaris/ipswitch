//
//  ActiveBetsRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/8/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveBetsRequest : NSObject

- (BOOL) requestActiveBets: (NSString*) apiToken: (NSString*) userSlug;

@end
