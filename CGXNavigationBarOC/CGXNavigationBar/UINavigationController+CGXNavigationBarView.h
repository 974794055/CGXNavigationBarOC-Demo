//
//  UINavigationController+CGXNavigationBarView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CGXNavigationBarNavView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (CGXNavigationBarView)
- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage;
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor;
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha;
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor;
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden;
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor;

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress;

- (NSArray<UIViewController *> *)gx_popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (NSArray<UIViewController *> *)gx_popToRootViewControllerAnimated:(BOOL)animated ;

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay;
- (void)gx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay;

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item ;

- (void)gx_updateInteractiveTransition:(CGFloat)percentComplete;

@end

NS_ASSUME_NONNULL_END
