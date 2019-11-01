//
//  NSObject+SXFixSpace.m
//  UINavigation-SXFixSpace
//
//  Created by MacMini-1 on 2019/11/1.
//  Copyright © 2019 None. All rights reserved.
//

#import "NSObject+SXFixSpace.h"

#import <objc/runtime.h>

void sx_swizzle11(Class oldClass, NSString *oldSelector, Class newClass) {
    NSString *newSelector = [NSString stringWithFormat:@"sx_%@", oldSelector];
    Method old = class_getInstanceMethod(oldClass, NSSelectorFromString(oldSelector));
    Method new = class_getInstanceMethod(newClass, NSSelectorFromString(newSelector));
    method_exchangeImplementations(old, new);
}

@implementation NSObject (SXFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            NSDictionary <NSString *, NSString *>*oriSels = @{@"_UINavigationBarContentView": @"layoutSubviews",
                                                              @"_UINavigationBarContentViewLayout": @"_updateMarginConstraints"};
            [oriSels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull cls, NSString * _Nonnull oriSel, BOOL * _Nonnull stop) {
                sx_swizzle11(NSClassFromString(cls), oriSel, NSObject.class);
            }];
        }
    });
}

- (void)sx_layoutSubviews {
    [self sx_layoutSubviews];
    if (CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace) return;
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")]) return;
    id layout = [self valueForKey:@"_layout"];
    if (!layout) return;
    SEL selector = NSSelectorFromString(@"_updateMarginConstraints");
    IMP imp = [layout methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(layout, selector);
}

- (void)sx__updateMarginConstraints {
    [self sx__updateMarginConstraints];
    if (CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace) return;
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentViewLayout")]) return;
    [self sx_adjustLeadingBarConstraints];
    [self sx_adjustTrailingBarConstraints];
}

- (void)sx_adjustLeadingBarConstraints {
    if (CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace) return;
    NSArray<NSLayoutConstraint *> *leadingBarConstraints = [self valueForKey:@"_leadingBarConstraints"];
    if (!leadingBarConstraints) return;
    CGFloat constant = CGXNavigationBarNavConfig.shared.gxBar_defaultFixSpace - CGXNavigationBarNavConfig.shared.gxBar_fixedSpaceWidth;
    for (NSLayoutConstraint *constraint in leadingBarConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeLeading &&
            constraint.secondAttribute == NSLayoutAttributeLeading) {
            constraint.constant = constant;
        }
    }
}

- (void)sx_adjustTrailingBarConstraints {
    if (CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace) return;
    NSArray<NSLayoutConstraint *> *trailingBarConstraints = [self valueForKey:@"_trailingBarConstraints"];
    if (!trailingBarConstraints) return;
    CGFloat constant = CGXNavigationBarNavConfig.shared.gxBar_fixedSpaceWidth - CGXNavigationBarNavConfig.shared.gxBar_defaultFixSpace;
    for (NSLayoutConstraint *constraint in trailingBarConstraints) {
        if (constraint.firstAttribute == NSLayoutAttributeTrailing &&
            constraint.secondAttribute == NSLayoutAttributeTrailing) {
            constraint.constant = constant;
        }
    }
}

@end
