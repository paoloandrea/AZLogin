//
//  AZAuthAPIClient.m
//  CloudPDF
//
//  Created by Paolo Rossignoli on 14/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AZAuthAPIClient.h"

@implementation AZAuthAPIClient
+ (id)sharedClient {
    static AZAuthAPIClient *__instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:kBaseURL];
        __instance = [[AZAuthAPIClient alloc] initWithBaseURL:url];
    });
    return __instance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];

       //[self setDefaultHeader:@"Accept" value:@"application/json"];
       self.parameterEncoding = AFJSONParameterEncoding;
    }
    return self;
}
@end
