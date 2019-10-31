//
//  CGXNavigationBarTools.m
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/31.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXNavigationBarTools.h"
#import <objc/runtime.h>
#import "sys/utsname.h"
@implementation CGXNavigationBarTools

+ (BOOL)isIphoneX {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
+ (CGFloat)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
