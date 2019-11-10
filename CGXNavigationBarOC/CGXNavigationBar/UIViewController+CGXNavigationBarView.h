//
//  UIViewController+CGXNavigationBarView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXNavigationBarNavView.h"

@class CGXNavigationBarNavView;
NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGXNavigationBarView)

/** record current ViewController navigationBar image */
- (void)gx_setNavBarBackgroundImage:(UIImage *)image;
/** record current ViewController navigationBar barTintColor */
- (void)gx_setNavBarBarTintColor:(UIColor *)color;
/** record current ViewController navigationBar backgroundAlpha */
- (void)gx_setNavBarBackgroundAlpha:(CGFloat)alpha;
/** record current ViewController navigationBar tintColor */
- (void)gx_setNavBarTintColor:(UIColor *)color;
/** record current ViewController titleColor */
- (void)gx_setNavBarTitleColor:(UIColor *)color;
/** record current ViewController statusBarStyle */
- (void)gx_setStatusBarStyle:(UIStatusBarStyle)style;
/** record current ViewController navigationBar shadowImage hidden */
- (void)gx_setNavBarShadowImageHidden:(BOOL)hidden;

/**
    内部使用
*/
- (UIImage *)gx_navBarBackgroundImage;
- (UIColor *)gx_navBarBarTintColor;
- (CGFloat)gx_navBarBackgroundAlpha;
- (UIColor *)gx_navBarTintColor;
- (UIColor *)gx_navBarTitleColor;
- (UIStatusBarStyle)gx_statusBarStyle;
- (BOOL)gx_navBarShadowImageHidden;

@end

NS_ASSUME_NONNULL_END
