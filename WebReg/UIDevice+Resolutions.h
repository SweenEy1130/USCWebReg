//
//  UIDevice+Resolutions.h
//  USCholar
//
//  Created by Pablo Ochoa on 2/25/15.
//  Copyright (c) 2015 TFBoys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIDevicePhone,
    UIDevicePhone4,
    UIDevicePhone5,
    UIDevicePhone6,
    UIDevicePhone6Plus,
    UIDeviceIpad
} DeviceType;

@interface UIDevice (Resolutions)

+ (DeviceType)deviceType;
+ (BOOL)isPhone5;
+ (BOOL)isPhone6;

@end
