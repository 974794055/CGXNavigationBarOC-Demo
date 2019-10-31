//
//  UIViewController+CGXNavigationBarViewPush.h
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/31.
//  Copyright © 2019 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGXNavigationBarViewPush)

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished;
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished;
- (void)setPushToNextVCFinished:(BOOL)isFinished;

- (void)gx_toLastViewController;

+ (UIViewController*)gx_currentViewController;

+ (UIViewController*)gx_currentViewControllerFrom:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
