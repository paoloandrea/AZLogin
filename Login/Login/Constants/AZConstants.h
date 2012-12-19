//
//  AZConstants.h
//  Login
//
//  Created by Paolo Rossignoli on 19/11/12.
//  Copyright (c) 2012 Azero. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "AZCustomMacro.h"

#ifdef DEBUG
    #define kBaseURL            @"http://192.168.0.123/"
#else
    #define kBaseURL            @"http://myproductionserver.com/"
#endif

#define kBaseLoginPath          @"api/login.php"



//DELEGATI
#define SharedAppDelegate       ((AZAppDelegate*)[[UIApplication sharedApplication] delegate])
//SCREEN
#define SCREEN_BOUNDS           [UIScreen mainScreen].bounds
#define SCREEN_APPFRAME         [UIScreen mainScreen].applicationFrame




//COLORS
#define RGB(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a)        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HTML(rgb)               RGB((double)(rgb >> 16 & 0xff), (double)(rgb >> 8 & 0xff), (double)(rgb & 0xff))

// Dimensioni item
#define     LOGIN_VIEW_SIZE     CGSizeMake (320,450)