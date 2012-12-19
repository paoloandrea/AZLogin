//
//  AZAuthAPIClient.h
//  CloudPDF
//
//  Created by Paolo Rossignoli on 14/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AFNetworking.h"

@interface AZAuthAPIClient : AFHTTPClient

+ (id)sharedClient;

@end
