//
//  UIImage+CGXNavigationBar.h
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXNavigationBar)
-(UIImage *)updateImageWithTintColor:(UIColor*)color;
-(UIImage *)updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha;
-(UIImage *)updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect;
-(UIImage *)updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets;
-(UIImage *)updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets;
-(UIImage *)updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
