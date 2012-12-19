//
//  AZLoginView.m
//  CloudPDF
//
//  Created by Paolo Rossignoli on 19/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AZLoginView.h"

@interface AZLoginView ()

@property (nonatomic, strong) IBOutlet UIImageView *backgroundView;

@end


@implementation AZLoginView

@synthesize delegate = _delegate;
@synthesize loginIdTextField = _loginIdTextField;
@synthesize passwordTextField = _passwordTextField;
@synthesize backgroundView = _backgroundView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configureLoginView];
    }
    return self;
}

- (void) configureLoginView {
    _login = [[AZLogin alloc] init];
    [_login setDelegate:self];
    
    [_backgroundView setImage:[UIImage imageNamed:@"loginImages.bundle/loginBackground.png"]];
    
    [self configureForgotPasswordLabel];
    
    [_loginButton setBackgroundColor:[UIColor clearColor]];
    [_loginButton setTintColor:[UIColor redColor]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(initLogin:) forControlEvents:UIControlEventTouchUpInside];
#ifdef DEBUG
    [_loginIdTextField setText:@"YOUR EMAIL"];
    [_passwordTextField setText:@"PASSWORD"];
#else

#endif
    
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"username_id"]){
        _loginIdTextField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username_id"];
    }
    /*
     if([[NSUserDefaults standardUserDefaults] valueForKey:@"username_id"] ||
     [[NSUserDefaults standardUserDefaults] valueForKey:@"password_id"])
     {
     
     //_passwordTextField.text = [[NSUserDefaults standardUserDefaults]  valueForKey:@"password_id"];
     }
     */
    
   
}

- (void) configureForgotPasswordLabel {
    NSString *clickHere = NSLocalizedString(@"clickHere", @"clickHere");
    NSString *forgetPasswordText = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"forgetPassword", @"forgetPassword"),clickHere];
    
    _forgotPasswordLabel.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    _forgotPasswordLabel.highlightedTextColor = [UIColor whiteColor];
    [_forgotPasswordLabel setText:forgetPasswordText afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange linkRange = [[mutableAttributedString string] rangeOfString:clickHere options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor grayColor] CGColor] range:linkRange];
        
        return mutableAttributedString;
    }];
    _forgotPasswordLabel.delegate = self;
    NSRange rangeForget = [_forgotPasswordLabel.text rangeOfString:clickHere];
    [_forgotPasswordLabel addLinkToURL:[NSURL URLWithString:@"AZForgetPassword"] withRange:rangeForget];
    
    
     NSString *changePasswordText = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"changePassword", @"changePassword"),clickHere];
    _changePasswordLabel.linkAttributes = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    _changePasswordLabel.highlightedTextColor = [UIColor whiteColor];
    [_changePasswordLabel setText:changePasswordText afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange linkRange = [[mutableAttributedString string] rangeOfString:clickHere options:NSCaseInsensitiveSearch];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:(id)[[UIColor grayColor] CGColor] range:linkRange];
        
        return mutableAttributedString;
    }];
    _changePasswordLabel.delegate = self;
    NSRange rangeChange = [_changePasswordLabel.text rangeOfString:clickHere];
    [_changePasswordLabel addLinkToURL:[NSURL URLWithString:@"AZChangePassword"] withRange:rangeChange];
}

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    NSString *pathString =[NSString stringWithFormat:@"%@",url];
    NSLog(@"pathString %@",pathString);
    if ([pathString isEqualToString:@"AZChangePassword"]) {
        [self.delegate loadView:@"AZLoginChangePasswordView"];
    } else {
        [self.delegate loadView:@"AZLoginForgetPasswordView"];
    }
}



#pragma mark -
#pragma mark LOGIN
- (void) initLogin:(id)sender {
    NSLog(@"username_id:-%@-",[[NSUserDefaults standardUserDefaults] valueForKey:@"username_id"]);
    NSLog(@"password_id:-%@-",[[NSUserDefaults standardUserDefaults] valueForKey:@"password_id"]);
       
    [_login loginWithUser:_loginIdTextField.text andPassword:_passwordTextField.text];
}

- (void) authorized:(BOOL)isAuthorized {
    
    [self.delegate authorized:isAuthorized];
    [[NSUserDefaults standardUserDefaults] setValue:_loginIdTextField.text forKey:@"username_id"];
    [[NSUserDefaults standardUserDefaults] setValue:_passwordTextField.text forKey:@"password_id"];
    
    if(isAuthorized){
        
    } else {
        
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
