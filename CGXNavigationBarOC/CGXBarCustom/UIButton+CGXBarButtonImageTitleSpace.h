//
//  UIButton+CGXImageAndTitle.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
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
