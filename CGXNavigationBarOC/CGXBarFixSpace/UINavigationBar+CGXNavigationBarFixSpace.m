//
//  UIViewController+CGXBarButtonBase.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//


#import "UINavigationBar+CGXNavigationBarFixSpace.h"
#import "CGXNavigationBarNavConfig.h"
#import "NSObject+CGXNavigationBarFixSpace.h"

#ifndef CGXBar_deviceVersion
#define CGXBar_deviceVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

@implementation UINavigationBar (CGXNavigationBarFixSpace)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethodWithOriginSel:@selector(layoutSubviews)
                                     swizzledSel:@selector(CGXBar_layoutSubviews)];
    });
}

-(void)CGXBar_layoutSubviews{
    [self CGXBar_layoutSubviews];
    if (CGXBar_deviceVersion >= 11 && ![CGXNavigationBarNavConfig shared].gxBar_disableFixSpace) {//需要调节
        CGFloat space = [CGXNavigationBarNavConfig shared].gxBar_defaultFixSpace;
        for (UIView *subview in self.subviews) {
            if ([NSStringFromClass(subview.class) containsString:@"ContentView"]) {
                if (CGXBar_deviceVersion >= 13.0) {
                    [UIView animateWithDuration:0 animations:^{
                        UIEdgeInsets margins = subview.layoutMargins;
                        margins = UIEdgeInsetsMake(margins.top, margins.left - space, margins.bottom, margins.right - space);//可修正iOS11之后的偏移
                        subview.frame = CGRectMake(-margins.left, -margins.top, margins.left + margins.right + subview.frame.size.width, margins.top + margins.bottom + subview.frame.size.height);
                    }];
                } else {
                    subview.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);//可修正iOS11之后的偏移
                }
                break;
            }
        }
    }
}

@end
