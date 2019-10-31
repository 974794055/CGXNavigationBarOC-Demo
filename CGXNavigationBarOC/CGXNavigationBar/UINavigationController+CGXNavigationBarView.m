//
//  UINavigationController+CGXNavigationBarView.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UINavigationController+CGXNavigationBarView.h"

#import <objc/runtime.h>
#import "sys/utsname.h"
#import "UIColor+CGXNavigationBar.h"
#import "UIViewController+CGXNavigationBarViewPush.h"
@implementation UINavigationController (CGXNavigationBarView)

static CGFloat gxPopDuration = 0.12;
static int gxPopDisplayCount = 0;
- (CGFloat)gxPopProgress {
    CGFloat all = 60 * gxPopDuration;
    int current = MIN(all, gxPopDisplayCount);
    return current / all;
}

static CGFloat gxPushDuration = 0.10;
static int gxPushDisplayCount = 0;
- (CGFloat)gxPushProgress {
    CGFloat all = 60 * gxPushDuration;
    int current = MIN(all, gxPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController gx_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar gx_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar gx_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar gx_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC gx_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC gx_navBarBarTintColor];
    UIColor *newBarTintColor =  [UIColor middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    
//    [CGXNavigationBarNavView middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([CGXNavigationBarNavView needUpdateNavigationBar:fromVC] || [CGXNavigationBarNavView needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC gx_navBarTintColor];
    UIColor *toTintColor = [toVC gx_navBarTintColor];
    UIColor *newTintColor = [UIColor middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([CGXNavigationBarNavView needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }

    // change navBarTitleColor（在gx_popToViewController:animated:方法中直接改变标题颜色）
    UIColor *fromTitleColor = [fromVC gx_navBarTitleColor];
    UIColor *toTitleColor = [toVC gx_navBarTitleColor];
    UIColor *newTitleColor = [UIColor middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC gx_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC gx_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [self middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}
- (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}
#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:)
        };
      
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"gx_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)gx_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // pop 的时候直接改变 barTintColor、tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController gx_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController gx_navBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        gxPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:gxPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self gx_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)gx_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        gxPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:gxPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self gx_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        gxPopDisplayCount += 1;
        CGFloat popProgress = [self gxPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)gx_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        gxPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:gxPushDuration];
    [CATransaction begin];
    [self gx_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        gxPushDisplayCount += 1;
        CGFloat pushProgress = [self gxPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc gx_navBarBarTintColor];
        CGFloat curAlpha = [vc gx_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)gx_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self gx_updateInteractiveTransition:percentComplete];
}

@end
