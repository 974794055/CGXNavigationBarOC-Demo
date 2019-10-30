//
//  WRCustomNavigationBarNavView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

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













