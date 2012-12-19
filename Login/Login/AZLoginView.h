//
//  AZLoginView.h
//  CloudPDF
//
//  Created by Paolo Rossignoli on 19/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZLogin.h"
#import "UIGlossyButton.h"
#import "TTTAttributedLabel.h"

@protocol AZLoginViewDelegate <NSObject>

- (void) authorized:(BOOL)value;
- (void) loadView:(NSString*)className;

@end

@interface AZLoginView : UIView <AZLoginDelegate, TTTAttributedLabelDelegate>

@property (nonatomic, assign) id<AZLoginViewDelegate>delegate;
@property (nonatomic, strong) AZLogin *login;
@property (nonatomic, weak) IBOutlet UILabel *loginIdLabel;
@property (nonatomic, weak) IBOutlet UITextField *loginIdTextField;
@property (nonatomic, weak) IBOutlet UILabel *passwordLabel;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIGlossyButton *loginButton;

@property (nonatomic, weak) IBOutlet TTTAttributedLabel* forgotPasswordLabel;
@property (nonatomic, weak) IBOutlet TTTAttributedLabel* changePasswordLabel;

- (void) configureLoginView;

@end
