//
//  UIViewController+CGXNavigationBar.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIViewController+CGXNavigationBar.h"
#import <objc/runtime.h>
#import "UIButton+CGXBarButtonBlock.h"



@implementation UIViewController (CGXNavigationBar)

- (UIColor *)barTitltColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(barTitltColor));
    return color?color:[UIColor blackColor];
}
- (void)setBarTitltColor:(UIColor *)barTitltColor
{
    objc_setAssociatedObject(self, @selector(barTitltColor), barTitltColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIFont *)barTitltFont
{
    UIFont *font = objc_getAssociatedObject(self, @selector(barTitltFont));
    return font?font:[UIFont systemFontOfSize:14];
}
- (void)setBarTitltFont:(UIFont *)barTitltFont
{
    objc_setAssociatedObject(self, @selector(barTitltFont), barTitltFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)barNavBackArrow
{
    UIImage *arrow = objc_getAssociatedObject(self, @selector(barNavBackArrow));
    
    NSString *strPath = [[NSBundle mainBundle] pathForResource:@"CGXNavigationBarOCBundle" ofType:@"bundle"];
    //找到对应images夹下的图片
    NSString *strImage = [[NSBundle bundleWithPath:strPath] pathForResource:@"CGXNavigationBarOCLeftBlockArrow" ofType:@"png" inDirectory:@"Images"];
    UIImage *ima = [UIImage imageWithContentsOfFile:strImage];
    
    return arrow?arrow:ima;
}
- (void)setBarNavBackArrow:(UIImage *)barNavBackArrow
{
    objc_setAssociatedObject(self, @selector(barNavBackArrow), barNavBackArrow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)backColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(backColor));
    return color?color:[UIColor colorWithWhite:0.93 alpha:1];
}
- (void)setBackColor:(UIColor *)backColor
{
    objc_setAssociatedObject(self, @selector(backColor), backColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
 默认[UIColor colorWithWhite:0.93 alpha:1];
 */
- (void)bgColor
{
    [self bgColor:self.backColor];
}
- (void)bgColor:(UIColor *)color
{
    if (color) {
        self.view.backgroundColor = color;
    } else{
        self.view.backgroundColor = self.backColor;
    }
}
/**
 导航条标题设置
 */
- (void)setNavTitle:(NSString *)title
{
    [self setNavTitle:title withColor:[self barTitltColor] Font:[UIFont systemFontOfSize:18]];
}
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color
{
    [self setNavTitle:title withColor:color Font:[UIFont systemFontOfSize:18]];
}
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color Font:(UIFont *)font
{
    [self setNavTitle:title withColor:color Font:font Block:nil];
}
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color Font:(UIFont *)font Block:(void (^)(UIButton *btn))block
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:color
                          range:NSMakeRange(0, title.length)];
    [attributedStr addAttribute:NSFontAttributeName
                          value:font
                          range:NSMakeRange(0, title.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paragraphStyle
                          range:NSMakeRange(0, title.length)];
    [self setNavAttributedString:attributedStr Block:block];
}
- (void)setNavAttributedString:(NSMutableAttributedString *)attrited
{
    [self setNavAttributedString:attrited Block:nil];
}
- (void)setNavAttributedString:(NSMutableAttributedString *)attrited Block:(void (^)(UIButton *btn))block
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setAttributedTitle:attrited forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.numberOfLines = 0;
    [btn sizeToFit];
    [btn addTapBlock:^(UIButton * _Nonnull btn) {
        if (block) {
            block(btn);
        }
    }];
    self.navigationItem.titleView = btn;
}
- (void)addNavBack
{
    [self addNavBackWithImage:self.barNavBackArrow];
}
- (void)addNavBackWithImage:(UIImage *)image
{
    [self addNavBackWithImage:image BackBlock:nil];
}
- (void)addNavBackWithImage:(UIImage *)image BackBlock:(void (^)(UIViewController *vc))block
{
    __weak typeof(self) weakNavBackSelf = self;
    UIBarButtonItem *item =  [UIBarButtonItem itemWithImage:image Target:^(UIButton * _Nonnull sender, CGXNavigationBarItemModel * _Nonnull item) {
        if (block) {
            block(weakNavBackSelf);
        } else{
            if (self.navigationController) {
                if (self.navigationController.viewControllers.count == 1) {
                    if (self.presentingViewController) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } else if(self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        }
    }];
    self.navigationItem.leftBarButtonItems = @[item];
}

#pragma mark -- 左侧按钮
-(void)addBarLeftWithTitle:(NSString *)title
                Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = self.barTitltFont;
    model.itemNormalColor = self.barTitltColor;
    model.style = ItemModelStyleTitle;
    [self addBarLeftWithModel:model Target:selectBlock];
}

-(void)addBarLeftWithImage:(UIImage *)image
                           Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalImage = image;
    model.style = ItemModelStyleImage;
    [self addBarLeftWithModel:model Target:selectBlock];
}

-(void)addBarLeftWithTitle:(NSString *)title
                            Image:(UIImage *)image
                            Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                           Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = self.barTitltFont;
    model.itemNormalColor = self.barTitltColor;
     model.itemNormalImage = image;
    model.style = ItemModelStyleAll;
    model.edgeInsetsStyle = style;
    [self addBarLeftWithModel:model Target:selectBlock];
}
-(void)addBarLeftWithModel:(CGXNavigationBarItemModel *)model
                    Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarLeftMorelWithArr:@[model] Target:selectBlock];
}
-(void)addBarLeftMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                       Target:(UIViewControllerItemSelectBlock)selectBlock
{
   
    NSMutableArray *itemArr  =[NSMutableArray array];
    for (CGXNavigationBarItemModel *model in array) {
        UIBarButtonItem *item = [UIBarButtonItem itemWithModel:model Target:^(UIButton * _Nonnull sender, CGXNavigationBarItemModel * _Nonnull item) {
            if (selectBlock) {
                selectBlock(sender,item);
            };
        }];
        [itemArr addObject:item];
    }
    self.navigationItem.leftBarButtonItems = itemArr;
}
#pragma mark -- 右侧按钮
-(void)addBarRightWithTitle:(NSString *)title
                Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = self.barTitltFont;
    model.itemNormalColor = self.barTitltColor;
    model.style = ItemModelStyleTitle;
    [self addBarRightWithModel:model Target:selectBlock];
}

-(void)addBarRightWithImage:(UIImage *)image
                           Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalImage = image;
    model.style = ItemModelStyleImage;
    [self addBarRightWithModel:model Target:selectBlock];
}

-(void)addBarRightWithTitle:(NSString *)title
                            Image:(UIImage *)image
                            Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                           Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = self.barTitltFont;
    model.itemNormalColor = self.barTitltColor;
     model.itemNormalImage = image;
    model.style = ItemModelStyleAll;
    model.edgeInsetsStyle = style;
    [self addBarRightWithModel:model Target:selectBlock];
}
-(void)addBarRightWithModel:(CGXNavigationBarItemModel *)model
                    Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarRightMorelWithArr:@[model] Target:selectBlock];
}
-(void)addBarRightMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                       Target:(UIViewControllerItemSelectBlock)selectBlock
{
   
    NSMutableArray *itemArr  =[NSMutableArray array];
    for (CGXNavigationBarItemModel *model in array) {
        UIBarButtonItem *item = [UIBarButtonItem itemWithModel:model Target:^(UIButton * _Nonnull sender, CGXNavigationBarItemModel * _Nonnull item) {
            if (selectBlock) {
                selectBlock(sender,item);
            };
        }];
        [itemArr addObject:item];
    }
    self.navigationItem.rightBarButtonItems = itemArr;
}

@end

