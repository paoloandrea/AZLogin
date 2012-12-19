//
//  AZLoginForgetPasswordView.h
//  CloudPDF
//
//  Created by Paolo Rossignoli on 06/12/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"
#import "SBTableAlert.h"

@protocol AZLoginForgetPasswordViewDelegate <NSObject>

- (void) dismissView:(id)sender;

@end

@interface AZLoginForgetPasswordView : UIView <SBTableAlertDelegate, SBTableAlertDataSource>

@property (nonatomic, assign) id <AZLoginForgetPasswordViewDelegate> delegate;

- (void) configureLoginView;

@end
