//
//  UINavigationItem+CGXBarFixSpace.m
//  UINavigation-CGXBarFixSpace
//
//  Created by 曹贵鑫 on 2017/11/13.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "UINavigationItem+CGXNavigationBarFixSpace.h"
#import "NSObject+CGXNavigationBarFixSpace.h"
#import "CGXNavigationBarNavConfig.h"

#ifndef CGXBar_deviceVersion
#define CGXBar_deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

@implementation UINavigationItem (CGXNavigationBarFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
                                     swizzledSel:@selector(CGXBar_setLeftBarButtonItem:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:)
                                     swizzledSel:@selector(CGXBar_setLeftBarButtonItems:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:animated:)
                                     swizzledSel:@selector(CGXBar_setLeftBarButtonItem:animated:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItems:animated:)
                                     swizzledSel:@selector(CGXBar_setLeftBarButtonItems:animated:)];

        [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
                                     swizzledSel:@selector(CGXBar_setRightBarButtonItem:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:)
                                     swizzledSel:@selector(CGXBar_setRightBarButtonItems:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:animated:)
                                     swizzledSel:@selector(CGXBar_setRightBarButtonItem:animated:)];
        
        [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItems:animated:)
                                     swizzledSel:@selector(CGXBar_setRightBarButtonItems:animated:)];

    });
    
}

-(void)CGXBar_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setLeftBarButtonItem:leftBarButtonItem];
    } else {
        if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && leftBarButtonItem) {//存在按钮且需要调节
            [self setLeftBarButtonItems:@[leftBarButtonItem]];
        } else {//不存在按钮,或者不需要调节
            [self CGXBar_setLeftBarButtonItem:leftBarButtonItem];
        }
    }
}

-(void)CGXBar_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setLeftBarButtonItems:leftBarButtonItems];
    } else {
        if (leftBarButtonItems.count) {
            
            UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
            if (firstItem != nil
                && firstItem.image == nil
                && firstItem.title == nil
                && firstItem.customView == nil)  {
                // 第一个item 为spcae
                [self CGXBar_setLeftBarButtonItems:leftBarButtonItems];
                return;
            }
            
            NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth]];//可修正iOS11之前的偏移
            [items addObjectsFromArray:leftBarButtonItems];
            [self CGXBar_setLeftBarButtonItems:items];
        } else {
            [self CGXBar_setLeftBarButtonItems:leftBarButtonItems];
        }
    }
}

-(void)CGXBar_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated {
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setLeftBarButtonItem:leftBarButtonItem animated:animated];
    } else {
        if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && leftBarButtonItem) {//存在按钮且需要调节
            [self setLeftBarButtonItems:@[leftBarButtonItem] animated:animated];
        } else {//不存在按钮,或者不需要调节
            [self CGXBar_setLeftBarButtonItem:leftBarButtonItem animated:animated];
        }
    }
}

-(void)CGXBar_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems animated:(BOOL)animated {
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setLeftBarButtonItems:leftBarButtonItems animated:animated];
    } else {
        if (leftBarButtonItems.count) {
            UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
            if (firstItem != nil
                && firstItem.image == nil
                && firstItem.title == nil
                && firstItem.customView == nil)  {
                // 第一个item 为spcae
                [self CGXBar_setLeftBarButtonItems:leftBarButtonItems animated:animated];
                return;
            }
            NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth]];//可修正iOS11之前的偏移
            [items addObjectsFromArray:leftBarButtonItems];
            [self CGXBar_setLeftBarButtonItems:items animated:animated];
        } else {
            [self CGXBar_setLeftBarButtonItems:leftBarButtonItems animated:animated];
        }
    }
}

-(void)CGXBar_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setRightBarButtonItem:rightBarButtonItem];
    } else {
        if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调节
            [self setRightBarButtonItems:@[rightBarButtonItem]];
        } else {//不存在按钮,或者不需要调节
            [self CGXBar_setRightBarButtonItem:rightBarButtonItem];
        }
    }
}

-(void)CGXBar_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setRightBarButtonItems:rightBarButtonItems];
    } else {
        if (rightBarButtonItems.count) {
            UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
            if (firstItem != nil
                && firstItem.image == nil
                && firstItem.title == nil
                && firstItem.customView == nil)  {
                // 第一个item 为spcae
                [self CGXBar_setRightBarButtonItems:rightBarButtonItems];
                return;
            }
            NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth]];//可修正iOS11之前的偏移
            [items addObjectsFromArray:rightBarButtonItems];
            [self CGXBar_setRightBarButtonItems:items];
        } else {
            [self CGXBar_setRightBarButtonItems:rightBarButtonItems];
        }
    }
}

- (void)CGXBar_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated {
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setRightBarButtonItem:rightBarButtonItem animated:animated];
    } else {
        if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调节
            [self setRightBarButtonItems:@[rightBarButtonItem] animated:animated];
        } else {//不存在按钮,或者不需要调节
            [self CGXBar_setRightBarButtonItem:rightBarButtonItem animated:animated];
        }
    }
}

- (void)CGXBar_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems animated:(BOOL)animated {
    if (CGXBar_deviceVersion >= 11) {
        [self CGXBar_setRightBarButtonItems:rightBarButtonItems animated:animated];
    } else {
        if (rightBarButtonItems.count) {
            UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
            if (firstItem != nil
                && firstItem.image == nil
                && firstItem.title == nil
                && firstItem.customView == nil)  {
                // 第一个item 为spcae
                [self CGXBar_setRightBarButtonItems:rightBarButtonItems animated:animated];
                return;
            }
            NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth]];//可修正iOS11之前的偏移
            [items addObjectsFromArray:rightBarButtonItems];
            [self CGXBar_setRightBarButtonItems:items animated:animated];
        } else {
            [self CGXBar_setRightBarButtonItems:rightBarButtonItems animated:animated];
        }
    }
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
