//
//  NSObject+CGXNavigationBarFixSpace.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "NSObject+CGXNavigationBarFixSpace.h"

#import <objc/runtime.h>

void gx_swizzle11(Class oldClass, NSString *oldSelector, Class newClass) {
    NSString *newSelector = [NSString stringWithFormat:@"gx_%@", oldSelector];
    Method old = class_getInstanceMethod(oldClass, NSSelectorFromString(oldSelector));
    Method new = class_getInstanceMethod(newClass, NSSelectorFromString(newSelector));
    method_exchangeImplementations(old, new);
}

@implementation NSObject (CGXNavigationBarFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {
            NSDictionary <NSString *, NSString *>*oriSels = @{@"_UINavigationBarContentView": @"layoutSubviews",
                                                              @"_UINavigationBarContentViewLayout": @"_updateMarginConstraints"};
            [oriSels enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull cls, NSString * _Nonnull oriSel, BOOL * _Nonnull stop) {
                gx_swizzle11(NSClassFromString(cls), oriSel, NSObject.class);
            }];
        }
    });
}

- (void)gx_layoutSubviews {
    [self gx_layoutSubviews];
    if (CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace) return;
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentView")]) return;
    id layout = [self valueForKey:@"_layout"];
    if (!layout) return;
    SEL selector = NSSelectorFromString(@"_updateMarginConstraints");
    IMP imp = [layout methodForSelector:selector];
    void (*func)(id, SEL) = (void *)imp;
    func(layout, selector);
}

- (void)gx__updateMarginConstraints {
    [self gx__updateMarginConstraints];
    if (CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace) return;
    if (![self isMemberOfClass:NSClassFromString(@"_UINavigationBarContentViewLayout")]) return;
    [self gx_adjustLeadingBarConstraints];
    [self gx_adjustTrailingBarConstraints];
}

- (void)gx_adjustLeadingBarConstraints {
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

- (void)gx_adjustTrailingBarConstraints {
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
