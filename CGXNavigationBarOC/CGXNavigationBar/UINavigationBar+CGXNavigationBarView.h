//
//  UINavigationBar+CGXNavigationBarView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (CGXNavigationBarView)<UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)gx_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)gx_setTranslationY:(CGFloat)translationY;

// set navigationBar backgroundImage
- (void)gx_setBackgroundImage:(UIImage *)image;

- (void)gx_setBackgroundColor:(UIColor *)color;

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)gx_setBackgroundAlpha:(CGFloat)alpha;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)gx_getTranslationY;



@end

NS_ASSUME_NONNULL_END
