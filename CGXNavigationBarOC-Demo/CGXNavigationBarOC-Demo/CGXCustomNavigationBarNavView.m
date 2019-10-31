//
//  CGXCustomNavigationBarNavView.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXCustomNavigationBarNavView.h"
#import "sys/utsname.h"
#import <objc/runtime.h>
#import "UIButton+CGXBarButtonBlock.h"
#import "UIViewController+CGXNavigationBarView.h"
#import "UIButton+CGXBarButtonImageTitleSpace.h"
#import "UIViewController+CGXNavigationBarViewPush.h"
#define GXDefaultTitleSize 18
#define GXDefaultTitleColor [UIColor blackColor]
#define GXDefaultBackgroundColor [UIColor whiteColor]
#define GXScreenWidth [UIScreen mainScreen].bounds.size.width

#define GXCustomNavigationBarNavButtonHeight    44

@interface CGXCustomNavigationBarNavView ()
@property (nonatomic, strong) UILabel     *titleLable;
@property (nonatomic, strong) UIView      *leftView;
@property (nonatomic, strong) UIView      *rightView;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIView      *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@end

@implementation CGXCustomNavigationBarNavView

+ (instancetype)customNavigationBar {
    CGXCustomNavigationBarNavView *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, GXScreenWidth, [CGXCustomNavigationBarNavView navBarBottom])];
    return navigationBar;
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.titleLable];
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self bringSubviewToFront:self.leftView];
    [self bringSubviewToFront:self.rightView];
    
    [self addSubview:self.bottomLine];


    [self updateFrame];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = GXDefaultBackgroundColor;
}

// TODO:这边结合 GXCellView 会不会更好呢？
-(void)updateFrame {
    NSInteger top = ([CGXCustomNavigationBarNavView isIphoneX]) ? 44 : 20;
    NSInteger titleLabelHeight = 44;
    NSInteger titleLabelWidth = 180;

    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
    self.titleLable.frame = CGRectMake((GXScreenWidth - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    self.bottomLine.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), GXScreenWidth, 0.5);
    
    self.leftView.frame = CGRectMake(0, top, (GXScreenWidth-titleLabelWidth)/2, titleLabelHeight);
    self.rightView.frame = CGRectMake(0, top, (GXScreenWidth-titleLabelWidth)/2, titleLabelHeight);
}

#pragma mark - 导航栏左右按钮事件
-(void)clickBack {
    if (self.onClickLeftButton) {
        self.onClickLeftButton();
    } else {
        UIViewController *currentVC = [UIViewController gx_currentViewController];
        [currentVC gx_toLastViewController];
    }
}
-(void)clickRight {
    if (self.onClickRightButton) {
        self.onClickRightButton();
    }
}

- (void)gx_setBottomLineHidden:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}

- (void)gx_setBackgroundAlpha:(CGFloat)alpha {
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)gx_setTintColor:(UIColor *)color {
    [self.titleLable setTextColor:color];
}

#pragma mark - setter
-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLable.hidden = NO;
    self.titleLable.text = _title;
}
- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    self.titleLable.textColor = _titleLabelColor;
}
- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    self.titleLable.font = _titleLabelFont;
}
-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    self.backgroundImageView.hidden = YES;
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = _barBackgroundColor;
}
- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {
    self.backgroundView.hidden = YES;
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = _barBackgroundImage;
}
- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return _leftView;
}
- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
         _rightView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }
    return _rightView;
}
-(UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textColor = GXDefaultTitleColor;
        _titleLable.font = [UIFont systemFontOfSize:GXDefaultTitleSize];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.hidden = YES;
    }
    return _titleLable;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:(CGFloat)(218.0/255.0) green:(CGFloat)(218.0/255.0) blue:(CGFloat)(218.0/255.0) alpha:1.0];
    }
    return _bottomLine;
}
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}
-(UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

+ (int)navBarBottom {
    return 44 + CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
}
+ (BOOL)isIphoneX {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }
    return iPhoneXSeries;
}
-(void)leftWithTitle:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.style = ItemModelStyleTitle;
    [self addBarLeftWithModel:model Target:selectBlock];
}
-(void)leftWithImage:(UIImage *)image
              Target:(NavViewSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalImage = image;
    model.style = ItemModelStyleImage;
    [self addBarLeftWithModel:model Target:selectBlock];
}
-(void)leftWithImage:(UIImage *)image
               Title:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.itemNormalImage = image;
    model.style = ItemModelStyleAll;
    [self addBarLeftWithModel:model Target:selectBlock];
}

-(void)addBarLeftWithModel:(CGXNavigationBarItemModel *)model
                     Target:(NavViewSelectBlock)selectBlock
{
    [self addBarLeftMorelWithArr:@[model] Target:selectBlock];
}

-(void)addBarLeftMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                        Target:(NavViewSelectBlock)selectBlock
{
    [self.leftView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    for (int i = 0; i<array.count; i++) {
        CGXNavigationBarItemModel *model = array[i];
        UIButton *btn = [CGXCustomNavigationBarNavView itemWithModel:model Target:selectBlock];
        btn.frame = CGRectMake(btn.frame.size.width * i, 0, btn.frame.size.width, btn.frame.size.height);
        [self.leftView addSubview:btn];
    }
}


-(void)rightWithTitle:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.style = ItemModelStyleTitle;
    [self addBarRightWithModel:model Target:selectBlock];
}

-(void)rightWithImage:(UIImage *)image
              Target:(NavViewSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalImage = image;
    model.style = ItemModelStyleImage;
    [self addBarRightWithModel:model Target:selectBlock];
}


-(void)rightWithImage:(UIImage *)image
               Title:(NSString *)title
                font:(UIFont *)font
          titleColor:(UIColor *)titleColor
              Target:(NavViewSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.itemNormalImage = image;
    model.style = ItemModelStyleAll;
    [self addBarRightWithModel:model Target:selectBlock];
}

-(void)addBarRightWithModel:(CGXNavigationBarItemModel *)model
                     Target:(NavViewSelectBlock)selectBlock
{
    [self addBarRightMorelWithArr:@[model] Target:selectBlock];
}

-(void)addBarRightMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                        Target:(NavViewSelectBlock)selectBlock
{
    [self.rightView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    for (int i = 0; i<array.count; i++) {
        CGXNavigationBarItemModel *model = array[i];
        UIButton *btn = [CGXCustomNavigationBarNavView itemWithModel:model Target:selectBlock];
        btn.frame = CGRectMake(btn.frame.size.width * i, 0, btn.frame.size.width, btn.frame.size.height);
        [self.rightView addSubview:btn];
    }
}



+ (UIButton *)itemWithModel:(CGXNavigationBarItemModel *)model
                     Target:(NavViewSelectBlock)selectBlock;
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag = model.itemTag;
    button.bounds = CGRectMake(0, 0, 44, 44);
    switch (model.style) {
        case ItemModelStyleTitle:
        {
            [button setTitle:model.itemNormalTitle forState:UIControlStateNormal];
            [button setTitle:model.itemNormalTitle forState:UIControlStateSelected];
            [button setTitle:model.itemNormalTitle forState:UIControlStateHighlighted];
            
            button.titleLabel.font = model.itemNormalFont ? model.itemNormalFont:nil;
            [button setTitleColor:model.itemNormalColor?model.itemNormalColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:model.itemNormalColor?model.itemNormalColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        }
            break;
        case ItemModelStyleImage:
        {
            [button setImage:[model.itemNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [button setImage:[model.itemNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        }
            break;
        case ItemModelStyleAll:
        {
            [button setTitle:model.itemNormalTitle forState:UIControlStateNormal];
            button.titleLabel.font = model.itemNormalFont?model.itemNormalFont:nil;
            [button setTitleColor:model.itemNormalColor?model.itemNormalColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:model.itemNormalColor?model.itemNormalColor:[UIColor blackColor] forState:UIControlStateHighlighted];
            
            [button setImage:[model.itemNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            [button setImage:[model.itemNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
            
            if (model.edgeInsetsStyle == EdgeInsetsStyleTop) {
                [button layoutButtonWithEdgeInsetsStyle:CGXBarButtonEdgeInsetsStyleTop imageTitleSpace:5];
            }
            if (model.edgeInsetsStyle == EdgeInsetsStyleBottom) {
                [button layoutButtonWithEdgeInsetsStyle:CGXBarButtonEdgeInsetsStyleBottom imageTitleSpace:5];
            }
            if (model.edgeInsetsStyle == EdgeInsetsStyleLeft) {
                [button layoutButtonWithEdgeInsetsStyle:CGXBarButtonEdgeInsetsStyleLeft imageTitleSpace:5];
            }
            if (model.edgeInsetsStyle == EdgeInsetsStyleRight) {
                [button layoutButtonWithEdgeInsetsStyle:CGXBarButtonEdgeInsetsStyleRight imageTitleSpace:5];
            }
        }
            break;
        default:
            break;
    }
    [button sizeToFit];
    button.backgroundColor = [UIColor orangeColor];
    if (button.frame.size.width<40) {
        button.bounds = CGRectMake(0, 0, 40+model.itemSpace, GXCustomNavigationBarNavButtonHeight);
    } else{
        button.bounds = CGRectMake(0, 0, button.frame.size.width+model.itemSpace, GXCustomNavigationBarNavButtonHeight);
    }
    __weak typeof(button) weakBtn = button;
    [button addTapBlock:^(UIButton * _Nonnull btn) {
        if (selectBlock) {
            selectBlock(weakBtn,model);
        }
    }];
    return button;
}

@end


















