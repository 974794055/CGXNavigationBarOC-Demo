//
//  UIBarButtonItem+CGXNavigationBar.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXNavigationBarItemModel.h"

NS_ASSUME_NONNULL_BEGIN

//点击按钮事件
typedef void(^CGXBarButtonItemSelectBlock)(UIButton *btn,CGXNavigationBarItemModel *item);

@interface UIBarButtonItem (CGXNavigationBar)

+(UIBarButtonItem *)itemWithTitle:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor
                           Target:(CGXBarButtonItemSelectBlock)selectBlock;

+(UIBarButtonItem *)itemWithImage:(UIImage *)image
                           Target:(CGXBarButtonItemSelectBlock)selectBlock;


+(UIBarButtonItem *)itemWithImage:(UIImage *)image
                            Title:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor
                           Target:(CGXBarButtonItemSelectBlock)selectBlock;

+(UIBarButtonItem *)itemWithImage:(UIImage *)image
                            Title:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor
                            Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                           Target:(CGXBarButtonItemSelectBlock)selectBlock;


+(UIBarButtonItem *)itemWithModel:(CGXNavigationBarItemModel *)model
                           Target:(CGXBarButtonItemSelectBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
