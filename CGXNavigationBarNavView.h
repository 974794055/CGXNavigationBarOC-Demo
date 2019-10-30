//
//  CGXNavigationBarNavView.h
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/23.
//  Copyright © 2019 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+CGXNavigationBar.h"
#import "UIViewController+CGXNavigationBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXNavigationBarNavView : UIView

+ (instancetype)CustomNavigationBar;

@property (nonatomic, assign) CGFloat   alpha;
@property (nonatomic, assign) BOOL      hiddenBottomLine;
@property (nonatomic, strong) UIColor   * _Nullable backColor;
@property (nonatomic, strong) UIImage   * _Nullable backImage;


+ (BOOL)isIphoneX;
+ (CGFloat)navBarBottom;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
