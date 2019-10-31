//
//  CGXCustomNavigationBarNavView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXNavigationBarItemModel.h"
//点击按钮事件
typedef void(^NavViewSelectBlock)(UIButton *btn,CGXNavigationBarItemModel *item);

typedef void(^NavViewUpdateModelBlock)(CGXNavigationBarItemModel *item);

@interface CGXCustomNavigationBarNavView : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)customNavigationBar;

- (void)gx_setBottomLineHidden:(BOOL)hidden;
- (void)gx_setBackgroundAlpha:(CGFloat)alpha;
- (void)gx_setTintColor:(UIColor *)color;


-(void)leftWithTitle:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock;

-(void)leftWithImage:(UIImage *)image
              Target:(NavViewSelectBlock)selectBlock;


-(void)leftWithImage:(UIImage *)image
               Title:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock;

-(void)addBarLeftWithModel:(CGXNavigationBarItemModel *)model
                     Target:(NavViewSelectBlock)selectBlock;

-(void)addBarLeftMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                        Target:(NavViewSelectBlock)selectBlock;



-(void)rightWithTitle:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock;

-(void)rightWithImage:(UIImage *)image
              Target:(NavViewSelectBlock)selectBlock;


-(void)rightWithImage:(UIImage *)image
               Title:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock;

-(void)addBarRightWithModel:(CGXNavigationBarItemModel *)model
                     Target:(NavViewSelectBlock)selectBlock;

-(void)addBarRightMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                        Target:(NavViewSelectBlock)selectBlock;


@end













