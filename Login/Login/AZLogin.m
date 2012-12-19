//
//  AZLogin.m
//  CloudPDF
//
//  Created by Paolo Rossignoli on 14/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import "AZLogin.h"
#import "SVProgressHUD.h"
#import "AZAuthAPIClient.h"

@implementation AZLogin

#pragma mark LOGIN
- (void) loginWithUser:(NSString*)username andPassword:(NSString*)password {
    
    NSDictionary *params =[NSDictionary dictionaryWithObjectsAndKeys:
                               username, @"email", password, @"pwd", nil];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    [[AZAuthAPIClient sharedClient] getPath:kBaseLoginPath
                                   parameters:params
                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                          NSLog(@"success: %@", operation.responseString);
                                          
                                          if ([[operation responseString] isEqualToString:@"Login fallito 0"]) {
                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                              [self.delegate authorized:FALSE];
                                              [SVProgressHUD showErrorWithStatus:@"Username or password are wrong"];
                                          } else {
                                              [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"username_id"];
                                              [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password_id"];
                                              [[NSUserDefaults standardUserDefaults] synchronize];
                                              [self.delegate authorized:TRUE];
                                              [SVProgressHUD dismiss];
                                          }
                                                                                    
                                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                           NSLog(@"error %@", operation.responseString);
                                          //[SVProgressHUD dismiss];
                                          [SVProgressHUD showErrorWithStatus:operation.responseString];
                                      } ];

}


#pragma mark LOGOUT
- (void) logout:(id)sender {
    NSDictionary *params =[NSDictionary dictionaryWithObjectsAndKeys:
                           @"1", @"logout", nil];
    [[AZAuthAPIClient sharedClient] getPath:kBaseLoginPath
                                 parameters:params
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"success: %@", operation.responseString);
                                        [SVProgressHUD showSuccessWithStatus:@"Logout"];
                                        [self.delegate authorized:FALSE];                                       
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"error %@", operation.responseString);
                                        
                                    } ];
}


#pragma mark RECOVER PASSWORD
- (void) recoverPasswordWithUser:(NSString*)username andAnsware:(NSString*)answare {
    
    NSDictionary *params =[NSDictionary dictionaryWithObjectsAndKeys:
                           username, @"username", answare, @"answare", nil];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];

    [[AZAuthAPIClient sharedClient] getPath:kBaseLoginPath
                                 parameters:params
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"success: %@", operation.responseString);
                                        
                                        if ([[operation responseString] isEqualToString:@"Login fallito 0"]) {
                                           
                                        } else {
                                           
                                        }
                                        [SVProgressHUD dismiss];
                                        
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"error %@", operation.responseString);
                                        [SVProgressHUD dismiss];
                                    } ];
    
}

#pragma mark CHANGE PASSWORD
- (void) changePasswordWithPassword:(NSString*)oldPassword toPassword:(NSString*)newPassword {
    NSDictionary *params =[NSDictionary dictionaryWithObjectsAndKeys:
                           oldPassword, @"oldPassword", newPassword, @"newPassword", nil];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
    
    [[AZAuthAPIClient sharedClient] getPath:kBaseLoginPath
                                 parameters:params
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        NSLog(@"success: %@", operation.responseString);
                                        
                                        if ([[operation responseString] isEqualToString:@"Login fallito 0"]) {
                                            
                                        } else {
                                            
                                        }
                                        [SVProgressHUD dismiss];
                                        
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"error %@", operation.responseString);
                                        [SVProgressHUD dismiss];
                                    } ];

}

@end
