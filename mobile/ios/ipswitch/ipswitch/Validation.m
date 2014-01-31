//
//  Validation.m
//  ipswitch
//
//  Created by Andrew Miller on 12/1/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "Validation.h"

@implementation Validation

+(BOOL) isPasswordValid:(NSString *)pwd {
    if ( [pwd length]<4 || [pwd length]>32 ) return NO;  // too long or too short
    NSRange rang;
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    if ( !rang.length ) return NO;  // no letter
    rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
    if ( !rang.length )  return NO;  // no number;
    return YES;
}

@end
