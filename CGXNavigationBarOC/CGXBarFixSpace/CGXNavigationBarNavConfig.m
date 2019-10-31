//
//  CGXNavigationBarNavConfig.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXNavigationBarNavConfig.h"

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
    self = [super init];
    if (self) {
        [self configBase];
    }
    return self;
}

-(void)configBase {
    self.gxBar_defaultFixSpace = 10;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>11) {
        self.gxBar_fixedSpaceWidth = -20;
    }else{
        self.gxBar_fixedSpaceWidth = -10;
    }
     self.gxBar_fixedSpaceWidth = 0;
    self.gxBar_disableFixSpace = NO;
}

@end
