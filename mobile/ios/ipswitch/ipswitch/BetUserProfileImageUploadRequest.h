//
//  BetUserProfileImageUploadRequest.h
//  ipswitch
//
//  Created by Cevaris on 12/12/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BetUserProfileImageUploadRequest : NSObject

@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSString *apiToken;

@property (strong, nonatomic) UIImage *profileImage;

- (BOOL) sendRequest;


@end
