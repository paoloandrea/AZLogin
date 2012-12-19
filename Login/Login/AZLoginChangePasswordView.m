//
//  AZLoginChangePasswordView.m
//  CloudPDF
//
//  Created by Paolo Rossignoli on 10/12/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AZLoginChangePasswordView.h"
#import "UIGlossyButton.h"
#import "TTTAttributedLabel.h"

@interface AZLoginChangePasswordView ()

@property (nonatomic, strong) IBOutlet UIButton *closeButton;
@property (nonatomic, strong) IBOutlet UITextField *oldPasswordTextField;
@property (nonatomic, strong) IBOutlet UITextField *currentPasswordTextField;
@property (nonatomic, strong) IBOutlet UITextField *confirmNewPasswordTextField;
@property (nonatomic, strong) IBOutlet UIGlossyButton *sendButton;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundView;

@end

@implementation AZLoginChangePasswordView

@synthesize backgroundView = _backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureLoginView];
    }
    return self;
}

- (void) configureLoginView {
    
    [_backgroundView setImage:[UIImage imageNamed:@"loginImages.bundle/loginBackground-change.png"]];
    
    [_oldPasswordTextField setPlaceholder:NSLocalizedString(@"oldPasswordPlaceholder", "placeholder")];
    [_currentPasswordTextField setPlaceholder:NSLocalizedString(@"newPasswordPlaceholder", "placeholder")];
    [_confirmNewPasswordTextField setPlaceholder:NSLocalizedString(@"confirmNewPasswordPlaceholder", "placeholder")];
    
    TTTAttributedLabel *titleLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 0, 260, 60)];
    [titleLabel setFont:[UIFont fontWithName:@"Aller" size:23.f]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setText:NSLocalizedString(@"titleChangePassword", @"title")];
    [self addSubview:titleLabel];
    
    [_sendButton setBackgroundColor:[UIColor clearColor]];
    [_sendButton setTintColor:[UIColor redColor]];
    [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_closeButton setImage:[UIImage imageNamed:@"loginImages.bundle/login_closeButton-nr.png"] forState:UIControlStateNormal];
    [_closeButton setImage:[UIImage imageNamed:@"loginImages.bundle/login_closeButton-hi.png"] forState:UIControlStateHighlighted];
    [_closeButton addTarget:_delegate action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
}

@end
