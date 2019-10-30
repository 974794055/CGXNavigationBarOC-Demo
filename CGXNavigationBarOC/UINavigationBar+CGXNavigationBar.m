//
//  UINavigationBar+CGXNav.m
//  CGXCategoryView-OC
//
//  Created by 曹贵鑫 on 2019/10/19.
//  Copyright © 2019 曹贵鑫. All rights reserved.
//

#import "UINavigationBar+CGXNavigationBar.h"

#import <objc/runtime.h>
#import <objc/runtime.h>

@interface UINavigationBar()
@property (nonatomic, strong) UIImage       *backClearImage;
@property (nonatomic, strong) UIImage       *lineClearImage;
@property (nonatomic, strong) CGXNavigationBarNavView     *myNavView; //自定义插入层，自定义操作都要在这一层上进行
@property (nonatomic, assign) BOOL          hiddenBottom;
@end

static char backClear_key, lineClear_key, myNavView_key, hiddenBottom_key;

@implementation UINavigationBar (CGXNavigationBar)
#pragma mark -- runtime:get/set
- (void)setBackClearImage:(UIImage *)backClearImage {
    objc_setAssociatedObject(self, &backClear_key, backClearImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backClearImage {
    return objc_getAssociatedObject(self, &backClear_key);
}

- (void)setLineClearImage:(UIImage *)lineClearImage {
    objc_setAssociatedObject(self, &lineClear_key, lineClearImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)lineClearImage {
    return objc_getAssociatedObject(self, &lineClear_key);
}

- (void)setMyNavView:(CGXNavigationBarNavView *)myNavView {
    objc_setAssociatedObject(self, &myNavView_key, myNavView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGXNavigationBarNavView *)myNavView {
    return objc_getAssociatedObject(self, &myNavView_key);
}

- (void)setHiddenBottom:(BOOL)hiddenBottom {
    objc_setAssociatedObject(self, &hiddenBottom_key, @(hiddenBottom), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hiddenBottom {
    return [objc_getAssociatedObject(self, &hiddenBottom_key) boolValue];
}

#pragma mark -- function
- (void)navBarAlpha:(CGFloat)alpha isOpaque:(BOOL)opaque {
    [self clearSystemLayerIsOpaque:opaque];
    if (!self.myNavView) {
        self.myNavView = [CGXNavigationBarNavView CustomNavigationBar];
        [self navBarBottomLineHidden:self.hiddenBottom];
    }
    
    self.myNavView.alpha = alpha;
    
    //通过kvc找到系统导航栏背景层，把自定义层添加到背景层
    /* 系统背景层无法改变其属性 所以通过添加自定义层，改变自定义层去实现效果*/
    [[self valueForKey:@"backgroundView"] addSubview:self.myNavView];
}
/**
 更改导航栏颜色和图片
 @param color 颜色
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarBackGroundColor:(UIColor *_Nullable)color isOpaque:(BOOL)opaque
{
    [self navBarBackGroundColor:color image:nil isOpaque:opaque];
}
/**
 更改导航栏颜色和图片
 @param barImage 图片
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)navBarBackGroundImage:(UIImage *_Nullable)barImage isOpaque:(BOOL)opaque
{
     [self navBarBackGroundColor:nil image:barImage isOpaque:opaque];
}
- (void)navBarBackGroundColor:(UIColor *)color image:(UIImage *)barImage isOpaque:(BOOL)opaque {
    [self clearSystemLayerIsOpaque:opaque];
    if (!self.myNavView) {
        self.myNavView = [CGXNavigationBarNavView CustomNavigationBar];
        [self navBarBottomLineHidden:self.hiddenBottom];
    }
    
    if (color) {
        self.myNavView.backColor = color;
    }
    
    if (barImage) {
        self.myNavView.backImage = barImage;
    }
    
    //通过kvc找到系统导航栏背景层，把自定义层添加到背景层
    /*系统背景层无法改变其属性 所以通过添加自定义层，改变自定义层上的属性去实现效果*/
    [[self valueForKey:@"backgroundView"] addSubview:self.myNavView];
}

- (void)navBarMyLayerHeight:(CGFloat)height isOpaque:(BOOL)opaque {
    height = height < 0 ? 0 : height;
    
    [self clearSystemLayerIsOpaque:opaque];
    
    if (!self.myNavView) {
        self.myNavView = [CGXNavigationBarNavView CustomNavigationBar];
        [self navBarBottomLineHidden:self.hiddenBottom];
    }
    [self.myNavView setFrame:CGRectMake(0, 0, self.bounds.size.width, height)];

    //通过kvc找到系统导航栏背景层，把自定义层添加到背景层
    /* 亲测，系统背景层无法改变其属性 所以通过添加自定义层，改变自定义层上的属性去实现效果*/
    [[self valueForKey:@"backgroundView"] addSubview:self.myNavView];
}

- (void)navBarBottomLineHidden:(BOOL)hidden {
    self.hiddenBottom = hidden;
    //如果是自定义图层
    if (self.myNavView && self.myNavView.hiddenBottomLine != hidden) {
        self.myNavView.hiddenBottomLine = hidden;
        
    } else {
        //如果是系统层
        if (hidden) {
            if (!self.lineClearImage) {
                self.lineClearImage = [[UIImage alloc]init];
                [self setShadowImage:self.lineClearImage];
            }
        } else {
            if (self.lineClearImage) {
                self.lineClearImage = nil;
                [self setShadowImage:self.lineClearImage];
            }
        }
    }
}

//还原到系统初始状态
- (void)navBarToBeSystem {
    if (self.myNavView) {
        [self.myNavView removeFromSuperview];
        self.myNavView = nil;
    }
    if (self.lineClearImage) {
        self.lineClearImage = nil;
    }
    if (self.backClearImage) {
        self.backClearImage = nil;
    }
    [self setBackgroundImage:nil
               forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    self.barStyle = UIBarStyleDefault;
}

//去掉系统导航栏特征
- (void)clearSystemLayerIsOpaque:(BOOL)opaque{
    //通过插入空image把背景变透明
    if (!self.backClearImage) {
        self.backClearImage = [[UIImage alloc]init];
        [self setBackgroundImage:self.backClearImage
                   forBarMetrics:UIBarMetricsDefault];
    }
    
    UIBarStyle barStyle = UIBarStyleDefault;
    if (@available(iOS 13.0, *)) {
        barStyle = UIBarStyleBlackOpaque;
    } else{
        barStyle = UIBarStyleBlack;
    }
    self.barStyle = opaque ? barStyle : UIBarStyleDefault;
    //去掉系统底线，使用自定义底线
    if (!self.lineClearImage) {
        self.lineClearImage = [[UIImage alloc]init];
        [self setShadowImage:self.lineClearImage];
    }
}

@end

