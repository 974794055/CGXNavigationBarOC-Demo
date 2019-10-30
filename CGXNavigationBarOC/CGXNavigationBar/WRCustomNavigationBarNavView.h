//
//  WRCustomNavigationBar.h
//  CodeDemo
//
//  Created by wangrui on 2017/10/22.
//  Copyright © 2017年 wangrui. All rights reserved.
//
//  Github地址：https://github.com/wangrui460/CGXNavigationBarNavView

#import <UIKit/UIKit.h>
#import "UIViewController+CGXNavigationBarView.h"
@interface WRCustomNavigationBarNavView : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)gx_setBottomLineHidden:(BOOL)hidden;
- (void)gx_setBackgroundAlpha:(CGFloat)alpha;
- (void)gx_setTintColor:(UIColor *)color;

// 默认返回事件
- (void)gx_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)gx_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)gx_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)gx_setLeftButtonWithImage:(UIImage *)image;
- (void)gx_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)gx_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)gx_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)gx_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)gx_setRightButtonWithImage:(UIImage *)image;
- (void)gx_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;



@end













