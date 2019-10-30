//
//  UIViewController+CGXNavigationBarView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXNavigationBarNavView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGXNavigationBarView)
/** record current ViewController navigationBar backgroundImage */
/** warning: gx_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)gx_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)gx_navBarBackgroundImage;
- (void)gx_setNavBarBackgroundImage:(UIImage *)image;

/** record current ViewController navigationBar barTintColor */
- (void)gx_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)gx_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)gx_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)gx_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)gx_setNavBarTintColor:(UIColor *)color;
- (UIColor *)gx_navBarTintColor;

/** record current ViewController titleColor */
- (void)gx_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)gx_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)gx_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)gx_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)gx_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)gx_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
/** warning: gx_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)gx_setCustomNavBar:(WRCustomNavigationBar *)navBar;

- (void)setPushToCurrentVCFinished:(BOOL)isFinished;

- (void)gx_toLastViewController;

+ (UIViewController*)gx_currentViewController;

+ (UIViewController*)gx_currentViewControllerFrom:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
