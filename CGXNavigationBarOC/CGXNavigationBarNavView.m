//
//  CGXNavigationBarNavView.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/23.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXNavigationBarNavView.h"

#import <objc/runtime.h>
#import "sys/utsname.h"

//判断是否是ipad
#define IS_IPHONE_iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)

#define IS_IPHONE_11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)
#define IS_IPHONE_11_Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)
#define IS_IPHONE_11_Pro_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPHONE_iPad : NO)

#pragma mark -- 自定义导航栏层
@interface CGXNavigationBarNavView()
@property (nonatomic, strong) UIImageView * _Nullable backImageView;
@property (nonatomic, strong) UIView * _Nullable bottomLine;
@end
@implementation CGXNavigationBarNavView


+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        if (IS_IPHONE_X==YES || IS_IPHONE_Xr==YES || IS_IPHONE_Xs==YES || IS_IPHONE_Xs_Max==YES || IS_IPHONE_11==YES || IS_IPHONE_11_Pro==YES || IS_IPHONE_11_Pro_Max==YES) {
             return YES;
        } else{
            return NO;
        }
    }
    if (IS_IPHONE_X==YES || IS_IPHONE_Xr==YES || IS_IPHONE_Xs==YES || IS_IPHONE_Xs_Max==YES || IS_IPHONE_11==YES || IS_IPHONE_11_Pro==YES || IS_IPHONE_11_Pro_Max==YES) {
         return YES;
    } else{
        return NO;
    }
//    BOOL iPhoneXSeries = NO;
//    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
//        return iPhoneXSeries;
//    }
//    if (@available(iOS 11.0, *)) {
//        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
//        if (mainWindow.safeAreaInsets.bottom > 0.0) {
//            iPhoneXSeries = YES;
//        }
//    }
//
//    return iPhoneXSeries;
}

+ (CGFloat)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}
+ (instancetype)CustomNavigationBar {
    CGXNavigationBarNavView *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, [CGXNavigationBarNavView screenWidth], [CGXNavigationBarNavView navBarBottom])];
    return navigationBar;
}
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
         [self creatMainUIByFrame:frame];
    }
    return self;
}
- (void)creatMainUIByFrame:(CGRect)frame {
    CGFloat height = frame.size.height;
    CGFloat width = frame.size.width;
    [self.backImageView setFrame:CGRectMake(0, 0, width, height)];
    [self addSubview:self.backImageView];
    [self sendSubviewToBack:self.backImageView];
    
    [self.bottomLine setFrame:CGRectMake(0, height-0.5, width, 0.5)];
    [self addSubview:self.bottomLine];
    [self bringSubviewToFront:self.bottomLine];
}

//底层背景层永远透明
- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:[UIColor clearColor]];
}

//设置图片背景颜色
- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.backImageView.backgroundColor = backColor;
}

//设置图片背景透明度
- (void)setAlpha:(CGFloat)alpha {
    _alpha = alpha;
    self.backImageView.alpha = alpha;
}

//设置图片
- (void)setBackImage:(UIImage *)backImage {
    _backImage = backImage;
    self.backImageView.image = backImage;
}

- (void)setHiddenBottomLine:(BOOL)hiddenBottomLine {
    _hiddenBottomLine = hiddenBottomLine;
    self.bottomLine.hidden = hiddenBottomLine;
}

#pragma mark -- 懒加载视图
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [UIImageView new];
        _backImageView.clipsToBounds = YES;
        _backImageView.contentMode = UIViewContentModeTop;
    }
    return _backImageView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        [_bottomLine setBackgroundColor:[UIColor grayColor]];
    }
    return _bottomLine;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
