//
//  CGXNavigationBarItemModel.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CGXNavigationBarItemModelStyle)
{
    ItemModelStyleTitle,
    ItemModelStyleImage,
   ItemModelStyleAll
};

typedef NS_ENUM(NSUInteger, CGXNavigationBarItemModelEdgeInsetsStyle)
{
    EdgeInsetsStyleTop,// image在上，label在下
    EdgeInsetsStyleLeft,// image在左，label在右
   EdgeInsetsStyleBottom, // image在下，label在上
    EdgeInsetsStyleRight // image在右，label在左
};

@interface CGXNavigationBarItemModel : NSObject
/*   默认相同 */
@property (nonatomic , strong) NSString *itemNormalTitle;

/*   默认相同 */
@property (nonatomic , strong) UIImage *itemNormalImage;

/*   默认黑色 [UIColor blackColor] */
@property (nonatomic , strong) UIColor *itemNormalColor;

/*   默认14 [UIFont systemFontOfSize:14] */
@property (nonatomic , strong) UIFont *itemNormalFont;

@property (nonatomic , assign) NSInteger itemTag; // 默认10000

/*   默认10 默认延展两边间距 */
@property (nonatomic , assign) CGFloat itemSpace;

@property (nonatomic , assign) CGXNavigationBarItemModelStyle style;
@property (nonatomic , assign) CGXNavigationBarItemModelEdgeInsetsStyle edgeInsetsStyle;

@end

NS_ASSUME_NONNULL_END
