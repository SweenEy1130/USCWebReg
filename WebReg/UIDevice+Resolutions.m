//
//  UIDevice+Resolutions.m
//  USCholar
//
//  Created by Pablo Ochoa on 2/25/15.
//  Copyright (c) 2015 TFBoys. All rights reserved.
//

#import "UIDevice+Resolutions.h"



@implementation UIDevice (Resolutions)


+ (DeviceType)deviceType {
    DeviceType type = UIDevicePhone;
    
    if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ){
        
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        if( screenHeight < screenWidth ){
            screenHeight = screenWidth;
        }
        
        if( screenHeight > 480 && screenHeight < 667 ){
            type = UIDevicePhone5;
        } else if ( screenHeight > 480 && screenHeight < 736 ){
            type = UIDevicePhone6;
        } else if ( screenHeight > 480 ){
            type = UIDevicePhone6Plus;
        } else {
            type = UIDevicePhone4;
        }
    }
    return type;
}

+ (BOOL)isPhone5 {
    return [self deviceType] == UIDevicePhone5;
}
+ (BOOL)isPhone6 {
    return [self deviceType] == UIDevicePhone6;
}

@end
