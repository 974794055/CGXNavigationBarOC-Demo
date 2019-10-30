//
//  UINavigationBar+CGXNav.h
//  CGXCategoryView-OC
//
//  Created by 曹贵鑫 on 2019/10/19.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXNavigationBarNavView.h"
NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (CGXNavigationBar)

/**
 更改导航栏颜色和图片
 @param color 颜色
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarBackGroundColor:(UIColor *_Nullable)color isOpaque:(BOOL)opaque;
/**
 更改导航栏颜色和图片
 @param barImage 图片
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarBackGroundImage:(UIImage *_Nullable)barImage isOpaque:(BOOL)opaque;

/**
 更改透明度

 @param alpha 导航栏透明度
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarAlpha:(CGFloat)alpha isOpaque:(BOOL)opaque;

/**
 导航栏背景高度
 注意*这里并没有改导航栏高度，只是改了自定义背景高度

 @param height 高度
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarMyLayerHeight:(CGFloat)height isOpaque:(BOOL)opaque;

/**
 隐藏底线
 */
- (void)navBarBottomLineHidden:(BOOL)hidden;

//还原回系统导航栏
- (void)navBarToBeSystem;

@end


NS_ASSUME_NONNULL_END
