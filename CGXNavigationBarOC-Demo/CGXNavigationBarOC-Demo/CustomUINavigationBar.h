//
//  CustomUINavigationBar.h
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/31.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomUINavigationBar : UINavigationBar
@property (nonatomic,assign) CGFloat leftValue;
- (void)setItemsSpace:(CGFloat)space;
@end

NS_ASSUME_NONNULL_END
