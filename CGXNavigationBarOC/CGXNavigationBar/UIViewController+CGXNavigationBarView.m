//
//  UIViewController+CGXNavigationBarView.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIViewController+CGXNavigationBarView.h"
#import <objc/runtime.h>
#import "sys/utsname.h"


@implementation UIViewController (CGXNavigationBarView)

static char kWRPushToCurrentVCFinishedKey;
static char kWRPushToNextVCFinishedKey;
static char kWRNavBarBackgroundImageKey;
static char kWRNavBarBarTintColorKey;
static char kWRNavBarBackgroundAlphaKey;
static char kWRNavBarTintColorKey;
static char kWRNavBarTitleColorKey;
static char kWRStatusBarStyleKey;
static char kWRNavBarShadowImageHiddenKey;
static char kWRCustomNavBarKey;
static char kWRSystemNavBarBarTintColorKey;
static char kWRSystemNavBarTintColorKey;
static char kWRSystemNavBarTitleColorKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)gx_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWRNavBarBackgroundImageKey);
    image = (image == nil) ? [CGXNavigationBarNavView defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)gx_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self gx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self gx_customNavBar];
    //  [navBar gx_setBackgroundImage:image];
    } else {
        objc_setAssociatedObject(self, &kWRNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar systemBarTintColor
- (UIColor *)gx_systemNavBarBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarBarTintColorKey);
}
- (void)gx_setSystemNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)gx_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarBarTintColorKey);
    if (![CGXNavigationBarNavView needUpdateNavigationBar:self]) {
        if ([self gx_systemNavBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        } else {
            barTintColor = [self gx_systemNavBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [CGXNavigationBarNavView defaultNavBarBarTintColor];
}
- (void)gx_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self gx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self gx_customNavBar];
    //  [navBar gx_setBackgroundColor:color];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)gx_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kWRNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [self defaultNavBarBackgroundAlpha];
}
- (void)gx_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kWRNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self gx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self gx_customNavBar];
    //  [navBar gx_setBackgroundAlpha:alpha];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar systemTintColor
- (UIColor *)gx_systemNavBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTintColorKey);
}
- (void)gx_setSystemNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)gx_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTintColorKey);
    if (![CGXNavigationBarNavView needUpdateNavigationBar:self]) {
        if ([self gx_systemNavBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        } else {
            tintColor = [self gx_systemNavBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [CGXNavigationBarNavView defaultNavBarTintColor];
}
- (void)gx_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self gx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self gx_customNavBar];
    //  navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar systemTitleColor
- (UIColor *)gx_systemNavBarTitleColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTitleColorKey);
}
- (void)gx_setSystemNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarTitleColor
- (UIColor *)gx_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTitleColorKey);
    if (![CGXNavigationBarNavView needUpdateNavigationBar:self]) {
        if ([self gx_systemNavBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        } else {
            titleColor = [self gx_systemNavBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [CGXNavigationBarNavView defaultNavBarTitleColor];
}
- (void)gx_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self gx_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self gx_customNavBar];
    //  navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)gx_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kWRStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [CGXNavigationBarNavView defaultStatusBarStyle];
}
- (void)gx_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kWRStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)gx_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kWRNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}
- (BOOL)gx_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kWRNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [CGXNavigationBarNavView defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)gx_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &kWRCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)gx_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &kWRCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       SEL needSwizzleSelectors[4] = {
           @selector(viewWillAppear:),
           @selector(viewWillDisappear:),
           @selector(viewDidAppear:),
           @selector(viewDidDisappear:)
       };
        
       for (int i = 0; i < 4;  i++) {
           SEL selector = needSwizzleSelectors[i];
           NSString *newSelectorStr = [NSString stringWithFormat:@"gx_%@", NSStringFromSelector(selector)];
           Method originMethod = class_getInstanceMethod(self, selector);
           Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
           method_exchangeImplementations(originMethod, swizzledMethod);
       }
    });
}

- (void)gx_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        if (![CGXNavigationBarNavView needUpdateNavigationBar:self]) {
            if ([self gx_systemNavBarBarTintColor] == nil) {
                [self gx_setSystemNavBarBarTintColor:[self gx_navBarBarTintColor]];
            }
            if ([self gx_systemNavBarTintColor] == nil) {
                [self gx_setSystemNavBarTintColor:[self gx_navBarTintColor]];
            }
            if ([self gx_systemNavBarTitleColor] == nil) {
                [self gx_setSystemNavBarTitleColor:[self gx_navBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self gx_navBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self gx_navBarTitleColor]];
    }
    [self gx_viewWillAppear:animated];
}

- (void)gx_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self gx_viewWillDisappear:animated];
}

- (void)gx_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self gx_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            if ([CGXNavigationBarNavView needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self gx_navBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self gx_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self gx_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self gx_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self gx_navBarShadowImageHidden]];
    }
    [self gx_viewDidAppear:animated];
}

- (void)gx_viewDidDisappear:(BOOL)animated {
    if (![CGXNavigationBarNavView needUpdateNavigationBar:self] && !self.navigationController) {
        [self gx_setSystemNavBarBarTintColor:nil];
        [self gx_setSystemNavBarTintColor:nil];
        [self gx_setSystemNavBarTitleColor:nil];
    }
    [self gx_viewDidDisappear:animated];
}

- (BOOL)canUpdateNavigationBar {
    return [self.navigationController.viewControllers containsObject:self];
}

- (BOOL)isRootViewController
{
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}

- (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
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
