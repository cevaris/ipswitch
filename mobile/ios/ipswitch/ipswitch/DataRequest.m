//
//  DataRequest.m
//  ipswitch
//
//  Created by Cevaris on 12/4/12.
//  Copyright (c) 2012 Cevaris. All rights reserved.
//

#import "DataRequest.h"

@protocol DataRequest <NSObject>



@required
-(id) doRequest;
-(id) handleResponse;
@end



