//
//  UIButton+CGXImageAndTitle.h
//  CGXTableViewGeneralView
//
//  Created by 曹贵鑫 on 2018/7/10.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CGXBarButtonImageTitleSpace)

typedef NS_ENUM(NSUInteger, CGXBarButtonEdgeInsetsStyle)
{
    CGXBarButtonEdgeInsetsStyleTop,// image在上，label在下
    CGXBarButtonEdgeInsetsStyleLeft,// image在左，label在右
    CGXBarButtonEdgeInsetsStyleBottom, // image在下，label在上
    CGXBarButtonEdgeInsetsStyleRight // image在右，label在左
    
};
/** * 设置button的titleLabel和imageView的布局样式，及间距 * * @param style titleLabel和imageView的布局样式 * @param space titleLabel和imageView的间距 */
- (void)layoutButtonWithEdgeInsetsStyle:(CGXBarButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;




   
@end
