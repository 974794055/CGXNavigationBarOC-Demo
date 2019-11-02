//
//  UINavigationItem+CGXNavigationBarFixSpace.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UINavigationItem+CGXNavigationBarFixSpace.h"
#import <objc/runtime.h>
#import "NSObject+CGXNavigationBarRuntime.h"

@implementation UINavigationItem (CGXNavigationBarFixSpace)
+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 11.0, *)) {} else {

            [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
                                         swizzledSel:@selector(gxBar_setLeftBarButtonItem:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:)
                                         swizzledSel:@selector(gxBar_setLeftBarButtonItems:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:animated:)
                                         swizzledSel:@selector(gxBar_setLeftBarButtonItem:animated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:animated:)
                                         swizzledSel:@selector(gxBar_setLeftBarButtonItems:animated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
                                         swizzledSel:@selector(gxBar_setRightBarButtonItem:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:)
                                         swizzledSel:@selector(gxBar_setRightBarButtonItems:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:animated:)
                                         swizzledSel:@selector(gxBar_setRightBarButtonItem:animated:)];
            
            [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:animated:)
                                         swizzledSel:@selector(gxBar_setRightBarButtonItems:animated:)];
        }
    });
}

-(void)gxBar_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    [self setLeftBarButtonItem:leftBarButtonItem animated:NO];
}

-(void)gxBar_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated {
    if (!CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace && leftBarButtonItem) {//存在按钮且需要调节
        [self setLeftBarButtonItems:@[leftBarButtonItem] animated:animated];
    } else {//不存在按钮,或者不需要调节
        [self gxBar_setLeftBarButtonItem:leftBarButtonItem animated:animated];
    }
}


-(void)gxBar_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    [self setLeftBarButtonItems:leftBarButtonItems animated:NO];
}

-(void)gxBar_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems animated:(BOOL)animated {
    if (!CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace && leftBarButtonItems.count) {//存在按钮且需要调节
        UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
        CGFloat width = CGXNavigationBarNavConfig.shared.gxBar_defaultFixSpace - CGXNavigationBarNavConfig.shared.gxBar_fixedSpaceWidth;
        if (firstItem.width == width) {//已经存在space
            [self gxBar_setLeftBarButtonItems:leftBarButtonItems animated:animated];
        } else {
            NSMutableArray *items = [NSMutableArray arrayWithArray:leftBarButtonItems];
            [items insertObject:[self fixedSpaceWithWidth:width] atIndex:0];
            [self gxBar_setLeftBarButtonItems:items animated:animated];
        }
    } else {//不存在按钮,或者不需要调节
        [self gxBar_setLeftBarButtonItems:leftBarButtonItems animated:animated];
    }
}

-(void)gxBar_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    [self setRightBarButtonItem:rightBarButtonItem animated:NO];
}

- (void)gxBar_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated {
    if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调节
        [self setRightBarButtonItems:@[rightBarButtonItem] animated:animated];
    } else {//不存在按钮,或者不需要调节
        [self gxBar_setRightBarButtonItem:rightBarButtonItem animated:animated];
    }
}

-(void)gxBar_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    [self setRightBarButtonItems:rightBarButtonItems animated:NO];
}

- (void)gxBar_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems animated:(BOOL)animated {
    if (!CGXNavigationBarNavConfig.shared.gxBar_disableFixSpace && rightBarButtonItems.count) {//存在按钮且需要调节
        UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
        CGFloat width = CGXNavigationBarNavConfig.shared.gxBar_defaultFixSpace - CGXNavigationBarNavConfig.shared.gxBar_fixedSpaceWidth;
        if (firstItem.width == width) {//已经存在space
            [self gxBar_setRightBarButtonItems:rightBarButtonItems animated:animated];
        } else {
            NSMutableArray *items = [NSMutableArray arrayWithArray:rightBarButtonItems];
            [items insertObject:[self fixedSpaceWithWidth:width] atIndex:0];
            [self gxBar_setRightBarButtonItems:items animated:animated];
        }
    } else {//不存在按钮,或者不需要调节
        [self gxBar_setRightBarButtonItems:rightBarButtonItems animated:animated];
    }
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}
@end
