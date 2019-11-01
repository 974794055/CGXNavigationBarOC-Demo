//
//  UINavigationItem+CGXBarFixSpace.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UINavigationItem+CGXNavigationBarFixSpace.h"
#import "NSObject+CGXNavigationBarFixSpace.h"
#import "CGXNavigationBarNavConfig.h"
#import "CGXNavigationBarItemView.h"
#ifndef CGXBar_deviceVersion
#define CGXBar_deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

@implementation UINavigationItem (CGXNavigationBarFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
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
    });
    
}



-(void)gxBar_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
    [self gxBar_setLeftBarButtonItem:leftBarButtonItem animated:NO];
}
-(void)gxBar_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated {
//    [self gxBar_setLeftBarButtonItems:@[leftBarButtonItem] animated:animated];
    
        if (leftBarButtonItem.customView) {
            if (CGXBar_deviceVersion >= 11) {
                UIView *barView = [self barItemViewButtonItem:leftBarButtonItem IsLeft:YES];
                [self gxBar_setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
            }else {
                [self gxBar_setLeftBarButtonItem:nil];
                [self setLeftBarButtonItems:@[[self fixedSpaceWithWidth:-[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth], leftBarButtonItem]];
            }
        }else {
                if (CGXBar_deviceVersion >= 11) {
                    [self gxBar_setLeftBarButtonItem:leftBarButtonItem];
                } else {
                    if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && leftBarButtonItem) {//存在按钮且需要调节
                        [self setLeftBarButtonItems:@[leftBarButtonItem]];
                    } else {//不存在按钮,或者不需要调节
                        [self gxBar_setLeftBarButtonItem:leftBarButtonItem];
                    }
                }
        }
}
-(void)gxBar_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems {
    [self gxBar_setLeftBarButtonItems:leftBarButtonItems animated:NO];
}
-(void)gxBar_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems animated:(BOOL)animated {
    [self barItemWithBarButtonItems:leftBarButtonItems animated:animated IsLeft:YES];
}

-(void)gxBar_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    [self gxBar_setRightBarButtonItem:rightBarButtonItem animated:NO];
}
- (void)gxBar_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated {
//    [self  gxBar_setRightBarButtonItems:@[rightBarButtonItem] animated:animated];
    
        if (rightBarButtonItem.customView) {
            if (CGXBar_deviceVersion >= 11) {
                 UIView *barView = [self barItemViewButtonItem:rightBarButtonItem IsLeft:NO];
                [self gxBar_setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
            } else {
                [self gxBar_setRightBarButtonItem:nil];
                [self setRightBarButtonItems:@[[self fixedSpaceWithWidth:-[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth], rightBarButtonItem]];
            }
        }else {
            if (CGXBar_deviceVersion >= 11) {
                [self gxBar_setRightBarButtonItem:rightBarButtonItem];
            } else {
                if (![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调节
                    [self setRightBarButtonItems:@[rightBarButtonItem]];
                } else {//不存在按钮,或者不需要调节
                    [self gxBar_setRightBarButtonItem:rightBarButtonItem];
                }
            }
        }
}
-(void)gxBar_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems{
    [self gxBar_setRightBarButtonItems:rightBarButtonItems animated:NO];
}
- (void)gxBar_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems animated:(BOOL)animated {
     [self barItemWithBarButtonItems:rightBarButtonItems animated:animated IsLeft:NO];
}



- (void)barItemWithBarButtonItems:(NSArray<UIBarButtonItem *> *)barButtonItems animated:(BOOL)animated IsLeft:(BOOL)isleft
{
    if (isleft) {
         if (CGXBar_deviceVersion >= 11) {
             
//             UIView *barView = [self barItemViewButtonItem:leftBarButtonItem IsLeft:YES];
//                            [self gxBar_setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
//
                [self gxBar_setLeftBarButtonItems:barButtonItems animated:animated];
            } else {
                if (barButtonItems.count) {
                    UIBarButtonItem *firstItem = barButtonItems.firstObject;
                    if (firstItem != nil
                        && firstItem.image == nil
                        && firstItem.title == nil
                        && firstItem.customView == nil)  {
                        // 第一个item 为spcae
                        [self gxBar_setLeftBarButtonItems:barButtonItems animated:animated];
                        return;
                    }
                    NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth]];//可修正iOS11之前的偏移
                    [items addObjectsFromArray:barButtonItems];
                    [self gxBar_setLeftBarButtonItems:items animated:animated];
                } else {
                    [self gxBar_setLeftBarButtonItems:barButtonItems animated:animated];
                }
            }

            
    } else{
            if (CGXBar_deviceVersion >= 11) {
                [self gxBar_setRightBarButtonItems:barButtonItems animated:animated];
            } else {
                if (barButtonItems.count) {
                    UIBarButtonItem *firstItem = barButtonItems.firstObject;
                    if (firstItem != nil
                        && firstItem.image == nil
                        && firstItem.title == nil
                        && firstItem.customView == nil)  {
                        // 第一个item 为spcae
                        [self gxBar_setRightBarButtonItems:barButtonItems animated:animated];
                        return;
                    }
                    NSMutableArray *items = [NSMutableArray arrayWithObject:[self fixedSpaceWithWidth:[CGXNavigationBarNavConfig shared].gxBar_fixedSpaceWidth]];//可修正iOS11之前的偏移
                    [items addObjectsFromArray:barButtonItems];
                    [self gxBar_setRightBarButtonItems:items animated:animated];
                } else {
                    [self gxBar_setRightBarButtonItems:barButtonItems animated:animated];
                }
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

- (UIView *)barItemViewButtonItem:(UIBarButtonItem *)barButtonItem IsLeft:(BOOL)isleft
{
    UIView *customView = barButtonItem.customView;
    CGXNavigationBarItemView *barView = [[CGXNavigationBarItemView alloc]initWithFrame:customView.bounds];
    [barView addSubview:customView];
    customView.center = barView.center;
    if (isleft) {
        [barView setPosition:SXBarViewPositionLeft];
    } else{
        [barView setPosition:SXBarViewPositionRight];
    }
    [self setLeftBarButtonItems:nil];
    return customView;
}

@end
