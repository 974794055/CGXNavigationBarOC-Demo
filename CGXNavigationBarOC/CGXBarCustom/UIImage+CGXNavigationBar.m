//
//  UIImage+CGXNav.m
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIImage+CGXNavigationBar.h"

@implementation UIImage (CGXNavigationBar)

-(UIImage *)updateImageWithTintColor:(UIColor*)color
{
    return [self updateImageWithTintColor:color alpha:1.0f];
}
-(UIImage *)updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha
{
    CGRect rect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    return [self updateImageWithTintColor:color alpha:alpha rect:rect];
}
-(UIImage *)updateImageWithTintColor:(UIColor*)color rect:(CGRect)rect
{
    return [self updateImageWithTintColor:color alpha:1.0f rect:rect];
}
-(UIImage *)updateImageWithTintColor:(UIColor*)color insets:(UIEdgeInsets)insets
{
    return [self updateImageWithTintColor:color alpha:1.0f insets:insets];
}
-(UIImage *)updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha insets:(UIEdgeInsets)insets
{
    CGRect originRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    CGRect tintImageRect = UIEdgeInsetsInsetRect(originRect, insets);
    return [self updateImageWithTintColor:color alpha:alpha rect:tintImageRect];
}

#pragma mark - 全能初始化方法
-(UIImage *)updateImageWithTintColor:(UIColor*)color alpha:(CGFloat)alpha rect:(CGRect)rect
{
    CGRect imageRect = CGRectMake(.0f, .0f, self.size.width, self.size.height);
    
    // 启动图形上下文
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    // 获取图片上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    // 利用drawInRect方法绘制图片到layer, 是通过拉伸原有图片
    [self drawInRect:imageRect];
    // 设置图形上下文的填充颜色
    CGContextSetFillColorWithColor(contextRef, [color CGColor]);
    // 设置图形上下文的透明度
    CGContextSetAlpha(contextRef, alpha);
    // 设置混合模式
    CGContextSetBlendMode(contextRef, kCGBlendModeSourceAtop);
    // 填充当前rect
    CGContextFillRect(contextRef, rect);
    
    // 根据位图上下文创建一个CGImage图片，并转换成UIImage
    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *tintedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    // 释放 imageRef，否则内存泄漏
    CGImageRelease(imageRef);
    // 从堆栈的顶部移除图形上下文
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
