//
//  CGXNavigationBarNavConfig.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXNavigationBarNavConfig.h"
#import <objc/runtime.h>



@implementation CGXNavigationBarNavConfig

+ (instancetype)shared {
    static CGXNavigationBarNavConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

-(instancetype)init {
    if (self = [super init]) {
        self.gxBar_disableFixSpace = NO;
        self.gxBar_defaultFixSpace = 10;
        self.gxBar_fixedSpaceWidth = self.sx_systemSpace;
    }
    return self;
}

- (CGFloat)sx_systemSpace {
    
    //        if ([[[UIDevice currentDevice] systemVersion] floatValue]>11) {
    //            self.gxBar_fixedSpaceWidth = 10;
    //        }else{
    //            self.gxBar_fixedSpaceWidth = 10;
    //        }
    
    return MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) > 375 ? 20 : 16;
}

@end
