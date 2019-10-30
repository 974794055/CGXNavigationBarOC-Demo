//
//  CGXNavigationBarNavView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+CGXNavigationBarView.h"
#import "UIViewController+CGXNavigationBarView.h"
#import "UINavigationController+CGXNavigationBarView.h"
@class WRCustomNavigationBar;

@interface CGXNavigationBarNavView : UIView
+ (BOOL)isIphoneX;
+ (CGFloat)navBarBottom;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;


/// 局部使用该库       待开发
//+ (void)gx_local;
/// 广泛使用该库       default 暂时是默认， gx_local 完成后，gx_local就会变成默认
+ (void)gx_widely;

/// 局部使用该库时，设置需要用到的控制器      待开发
//+ (void)gx_setWhitelist:(NSArray<NSString *> *)list;
/// 广泛使用该库时，设置需要屏蔽的控制器
+ (void)gx_setBlacklist:(NSArray<NSString *> *)list;

/** set default barTintColor of UINavigationBar */
+ (void)gx_setDefaultNavBarBarTintColor:(UIColor *)color;
+ (UIColor *)defaultNavBarBarTintColor;

/** set default barBackgroundImage of UINavigationBar */
/** warning: gx_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
+ (void)gx_setDefaultNavBarBackgroundImage:(UIImage *)image;
+ (UIImage *)defaultNavBarBackgroundImage;

/** set default tintColor of UINavigationBar */
+ (void)gx_setDefaultNavBarTintColor:(UIColor *)color;
+ (UIColor *)defaultNavBarTintColor;

/** set default titleColor of UINavigationBar */
+ (void)gx_setDefaultNavBarTitleColor:(UIColor *)color;
+ (UIColor *)defaultNavBarTitleColor;

/** set default statusBarStyle of UIStatusBar */
+ (void)gx_setDefaultStatusBarStyle:(UIStatusBarStyle)style;
+ (UIStatusBarStyle)defaultStatusBarStyle;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)gx_setDefaultNavBarShadowImageHidden:(BOOL)hidden;
+ (BOOL)defaultNavBarShadowImageHidden;


+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc;


@end

