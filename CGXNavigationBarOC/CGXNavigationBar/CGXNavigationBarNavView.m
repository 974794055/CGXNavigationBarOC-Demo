//
//  CGXNavigationBarNavView.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXNavigationBarNavView.h"
#import <objc/runtime.h>
#import "sys/utsname.h"
#import "UIColor+CGXNavigationBar.h"
#import "UINavigationController+CGXNavigationBarView.h"
static char GXIsLocalUsedKey;
static char GXWhiteistKey;
static char GXBlacklistKey;

static char GXDefaultNavBarBarTintColorKey;
static char GXDefaultNavBarBackgroundImageKey;
static char GXDefaultNavBarTintColorKey;
static char GXDefaultNavBarTitleColorKey;
static char GXDefaultStatusBarStyleKey;
static char GXDefaultNavBarShadowImageHiddenKey;

@implementation CGXNavigationBarNavView

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

+ (BOOL)isLocalUsed {
    id isLocal = objc_getAssociatedObject(self, &GXIsLocalUsedKey);
    return (isLocal != nil) ? [isLocal boolValue] : NO;
}
+ (void)gx_local {
    objc_setAssociatedObject(self, &GXIsLocalUsedKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)gx_widely {
    objc_setAssociatedObject(self, &GXIsLocalUsedKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSArray<NSString *> *)whitelist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &GXWhiteistKey);
    return (list != nil) ? list : nil;
}
+ (void)gx_setWhitelist:(NSArray<NSString *> *)list {
    NSAssert([self isLocalUsed], @"白名单是在设置 局部使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &GXWhiteistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (NSArray<NSString *> *)blacklist {
    NSArray<NSString *> *list = (NSArray<NSString *> *)objc_getAssociatedObject(self, &GXBlacklistKey);
    return (list != nil) ? list : nil;
}
+ (void)gx_setBlacklist:(NSArray<NSString *> *)list {
    NSAssert(list, @"list 不能设置为nil");
    NSAssert(![self isLocalUsed], @"黑名单是在设置 广泛使用 该库的情况下使用的");
    objc_setAssociatedObject(self, &GXBlacklistKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc {
    NSString *vcStr = NSStringFromClass(vc.class);
    if ([self isLocalUsed]) {
        return [[self whitelist] containsObject:vcStr]; // 当白名单里 有 表示需要更新
    } else {
        return ![[self blacklist] containsObject:vcStr];// 当黑名单里 没有 表示需要更新
    }
}

+ (UIColor *)defaultNavBarBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &GXDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)gx_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &GXDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &GXDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)gx_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &GXDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &GXDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)gx_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &GXDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &GXDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)gx_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &GXDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle {
    id style = objc_getAssociatedObject(self, &GXDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)gx_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &GXDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &GXDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)gx_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &GXDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

