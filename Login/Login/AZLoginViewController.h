//
//  AZLoginViewController-iPad.h
//  CloudPDF
//
//  Created by Paolo Rossignoli on 19/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AZLoginView.h"
#import "AZLoginForgetPasswordView.h"
#import "AZLoginChangePasswordView.h"
#import "TPKeyboardAvoidingScrollView.h"

@protocol AZLoginViewControllerDelegate <NSObject>

- (void) dismissLogin:(id)sender;

@end

@interface AZLoginViewController : UIViewController

@property (nonatomic, assign) id<AZLoginViewControllerDelegate>delegate;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *scrollView;

@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, strong) IBOutlet AZLoginView*loginView;
@property (nonatomic, strong) IBOutlet AZLoginForgetPasswordView*loginForgetView;
@property (nonatomic, strong) IBOutlet AZLoginChangePasswordView*loginChangeView;

@end
