//
//  BarView.h
//  UINavigationItem-SXFixSpace
//
//  Created by MacMini-1 on 2019/11/1.
//  Copyright © 2019 None. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, SXBarViewPosition) {
    SXBarViewPositionLeft,
    SXBarViewPositionRight
};

@interface CGXNavigationBarItemView : UIView
@property (nonatomic, assign) SXBarViewPosition position;
@property (nonatomic, assign) BOOL applied;
@end

NS_ASSUME_NONNULL_END
