//
//  UIViewController+CGXNavigationBar.h
//  CGXConfigBarButton
//
//  Created by CGX on 2017/11/13.
//  Copyright © 2017年 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+CGXNavigationBar.h"

//点击按钮事件
typedef void(^UIViewControllerItemSelectBlock)(UIButton *btn,CGXNavigationBarItemModel *item);

@interface UIViewController (CGXNavigationBar)

/**
 默认黑色
 */
@property (nonatomic, strong) UIColor *barTitltColor;
/**
 默认14
 */
@property (nonatomic, assign) UIFont *barTitltFont;

@property (nonatomic, strong) UIImage *barNavBackArrow;

/**
 默认[UIColor colorWithWhite:0.93 alpha:1];
 */
@property (nonatomic, strong) UIColor *backColor;

/**
 默认[UIColor colorWithWhite:0.93 alpha:1];
*/
- (void)bgColor;
- (void)bgColor:(UIColor *)color;


/**
 导航条标题设置 font： 18    color： [UIColor blackColor]
*/
- (void)setNavTitle:(NSString *)title;
- (void)setNavTitle:(NSString *)title
          withColor:(UIColor *)color;
- (void)setNavTitle:(NSString *)title
          withColor:(UIColor *)color
               Font:(UIFont *)font;
- (void)setNavTitle:(NSString *)title
          withColor:(UIColor *)color
               Font:(UIFont *)font
              Block:(void (^)(UIButton *btn))block;
- (void)setNavAttributedString:(NSMutableAttributedString *)attrited;
- (void)setNavAttributedString:(NSMutableAttributedString *)attrited
                         Block:(void (^)(UIButton *btn))block;


#pragma mark -- 返回按钮
- (void)addNavBack;
- (void)addNavBackWithImage:(UIImage *)image;
- (void)addNavBackWithImage:(UIImage *)image BackBlock:(void (^)(UIViewController *vc))block;

#pragma mark -- 左侧按钮
-(void)addBarLeftWithTitle:(NSString *)title
                    Target:(CGXBarButtonItemSelectBlock)selectBlock;

-(void)addBarLeftWithImage:(UIImage *)image
                    Target:(UIViewControllerItemSelectBlock)selectBlock;

-(void)addBarLeftWithTitle:(NSString *)title
                     Image:(UIImage *)image
                     Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                    Target:(UIViewControllerItemSelectBlock)selectBlock;

-(void)addBarLeftWithModel:(CGXNavigationBarItemModel *)model
                    Target:(UIViewControllerItemSelectBlock)selectBlock;

-(void)addBarLeftMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                       Target:(UIViewControllerItemSelectBlock)selectBlock;

#pragma mark -- 右侧按钮
-(void)addBarRightWithTitle:(NSString *)title
                     Target:(CGXBarButtonItemSelectBlock)selectBlock;

-(void)addBarRightWithImage:(UIImage *)image
                     Target:(UIViewControllerItemSelectBlock)selectBlock;

-(void)addBarRightWithTitle:(NSString *)title
                      Image:(UIImage *)image
                      Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                     Target:(UIViewControllerItemSelectBlock)selectBlock;

-(void)addBarRightWithModel:(CGXNavigationBarItemModel *)model
                     Target:(UIViewControllerItemSelectBlock)selectBlock;

-(void)addBarRightMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                        Target:(UIViewControllerItemSelectBlock)selectBlock;

@end
