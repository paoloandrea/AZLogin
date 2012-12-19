//
//  AZLoginViewController-iPad.m
//  CloudPDF
//
//  Created by Paolo Rossignoli on 19/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AZLoginViewController.h"

@interface AZLoginViewController () <AZLoginForgetPasswordViewDelegate, AZLoginViewDelegate, AZLoginChangePasswordViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView* currentView;

@end

@implementation AZLoginViewController

@synthesize scrollView = _scrollView;
@synthesize delegate = _delegate;
@synthesize loginView = _loginView;
@synthesize loginForgetView = _loginForgetView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.view setFrame:SCREEN_BOUNDS];
        [self createBackgroundView];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self createBackgroundView];
    }
    return self;
}

//
- (void) createBackgroundView {
    self.backgroundView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
    UIImage *backgroundImage;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if (SCREEN_BOUNDS.size.height > 480.0f) {
            /*Do iPhone 5 stuff here.*/
            backgroundImage = nil;
        } else {
            /*Do iPhone Classic stuff here.*/
            backgroundImage = nil;
        }
        [self.backgroundView setImage:backgroundImage];
    } else {
        
        [self setImageToInterfaceOrientation:0];
        [self.backgroundView setAlpha:0.6];
        [self.view insertSubview:self.backgroundView belowSubview:_scrollView];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
        
    _scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:SCREEN_BOUNDS];
    //

    //[_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [self.view addSubview:_scrollView];
    
   CGRect loginFrame;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        loginFrame = SCREEN_BOUNDS;
    } else {
        [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin];
        loginFrame = CGRectMake(SCREEN_BOUNDS.size.width/2-LOGIN_VIEW_SIZE.width/2,
                                SCREEN_BOUNDS.size.height/2-LOGIN_VIEW_SIZE.height/2,
                                LOGIN_VIEW_SIZE.width,
                                LOGIN_VIEW_SIZE.height);
        [_loginView.layer setCornerRadius:9.f];
        [_loginView setAutoresizesSubviews:NO];
        
        [_loginForgetView.layer setCornerRadius:9.f];
        [_loginForgetView setAutoresizesSubviews:NO];
        
        [_loginChangeView.layer setCornerRadius:9.f];
        [_loginChangeView setAutoresizesSubviews:NO];
    }
    
    [_loginView setBackgroundColor:[UIColor colorWithRed:0.235 green:0.314 blue:0.365 alpha:1.000]];
    [_loginView setFrame:loginFrame];
    [_loginView setDelegate:self];
    [_loginView configureLoginView];
    
    _currentView = _loginView;
    
    [_scrollView addSubview:_currentView];
    
    
    [_loginForgetView setBackgroundColor:[UIColor colorWithRed:0.235 green:0.314 blue:0.365 alpha:1.000]];
    [_loginForgetView setFrame:loginFrame];
    [_loginForgetView setDelegate:self];
    [_loginForgetView configureLoginView];
    
    [_loginChangeView setBackgroundColor:[UIColor colorWithRed:0.235 green:0.314 blue:0.365 alpha:1.000]];
    [_loginChangeView setFrame:loginFrame];
    [_loginChangeView setDelegate:self];
    [_loginChangeView configureLoginView];

}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    [self setImageToInterfaceOrientation:[UIDevice currentDevice].orientation];

}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DELEGATE LOGIN
- (void) authorized:(BOOL)isAuthorized {
    if(isAuthorized){
        NSLog(@"OK");
        [self.delegate dismissLogin:self];
    } else {
         NSLog(@"NO");
    }
}

- (void) loadView:(NSString *)className {
    if ([className isEqualToString:@"AZLoginForgetPasswordView"]) {
        [UIView transitionFromView:_currentView
                            toView:_loginForgetView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromBottom
                        completion:^(BOOL finished) {
                            _currentView = _loginForgetView;
        }];
    } else if ([className isEqualToString:@"AZLoginChangePasswordView"]) {
        [UIView transitionFromView:_currentView
                            toView:_loginChangeView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromBottom
                        completion:^(BOOL finished) {
                            _currentView = _loginChangeView;
                        }];
    }
}

- (void) dismissView:(id)sender {
    [UIView transitionFromView:_currentView
                        toView:_loginView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    completion:^(BOOL finished) {
                        _currentView = _loginView;
                    }];
}

#pragma mark ---
#pragma mark - Text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [_scrollView adjustOffsetToIdealIfNeeded];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _loginView.loginIdTextField) {
        [_loginView.loginIdTextField becomeFirstResponder];
    } else if (textField == _loginView.passwordTextField) {
        [_loginView.passwordTextField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark --
#pragma mark RUOTA INTERFACCIA
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         return NO;
     } else {
         return YES;
     }
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self setImageToInterfaceOrientation:toInterfaceOrientation];
    
}

- (BOOL)shouldAutorotate {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark --
#pragma mark Gestisco background alla rotazione dell'iPad
- (void) setImageToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    
    if (!toInterfaceOrientation) {
        toInterfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    }
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            [_backgroundView setImage:[UIImage imageNamed:@"Default-Portrait~ipad.png"]];
            
            break;
        case UIInterfaceOrientationPortrait:
            [_backgroundView setImage:[UIImage imageNamed:@"Default-Portrait~ipad.png"]];
           
            break;
        default:
            [_backgroundView setImage:[UIImage imageNamed:@"Default-Landscape~ipad.png"]];
            /*[_currentView setFrame:CGRectMake(SCREEN_BOUNDS.size.height/2-LOGIN_VIEW_SIZE.width/2,
                                              SCREEN_BOUNDS.size.width/2-LOGIN_VIEW_SIZE.height/2,
                                              LOGIN_VIEW_SIZE.width,LOGIN_VIEW_SIZE.height
                                              )];*/

            break;
    }
    [_loginView setFrame:_currentView.frame];
    [_loginForgetView setFrame:_currentView.frame];
    [_loginChangeView setFrame:_currentView.frame];
    [_backgroundView sizeToFit];
}

@end
