//
//  AZLoginChangePasswordView.h
//  CloudPDF
//
//  Created by Paolo Rossignoli on 10/12/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZLoginChangePasswordViewDelegate <NSObject>

- (void) dismissView:(id)sender;

@end

@interface AZLoginChangePasswordView : UIView

@property (nonatomic, assign) id<AZLoginChangePasswordViewDelegate>delegate;

- (void) configureLoginView;

@end
