//
//  UIViewController+CGXNavigationBarViewPush.m
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/31.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIViewController+CGXNavigationBarViewPush.h"
#import <objc/runtime.h>
#import "sys/utsname.h"

@implementation UIViewController (CGXNavigationBarViewPush)

static char GXPushToCurrentVCFinishedKey;
static char GXPushToNextVCFinishedKey;


// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &GXPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &GXPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &GXPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &GXPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)gx_toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (UIViewController*)gx_currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self gx_currentViewControllerFrom:rootViewController];
}

+ (UIViewController*)gx_currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self gx_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self gx_currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self gx_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
}

@end
