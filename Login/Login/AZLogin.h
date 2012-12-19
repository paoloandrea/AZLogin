//
//  AZLogin.h
//  CloudPDF
//
//  Created by Paolo Rossignoli on 14/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AFNetworking.h"


@protocol AZLoginDelegate <NSObject>

- (void) authorized:(BOOL)value;

@end


@interface AZLogin : AFHTTPClient

@property (nonatomic, assign) id<AZLoginDelegate>delegate;

- (void) loginWithUser:(NSString*)username andPassword:(NSString*)password;
- (void) logout:(id)sender;

@end
