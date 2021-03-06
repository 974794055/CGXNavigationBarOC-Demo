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

- (UIColor *)barNavTitltColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(barNavTitltColor));
    return color?color:[UIColor orangeColor];
}
- (void)setBarNavTitltColor:(UIColor *)barNavTitltColor
{
    objc_setAssociatedObject(self, @selector(barNavTitltColor), barNavTitltColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)barNavTitltFont
{
    UIFont *font = objc_getAssociatedObject(self, @selector(barNavTitltFont));
    return font?font:[UIFont systemFontOfSize:17];
}
- (void)setBarNavTitltFont:(UIFont *)barNavTitltFont
{
    objc_setAssociatedObject(self, @selector(barNavTitltFont), barNavTitltFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)barTitltColor
{
    UIColor *color = objc_getAssociatedObject(self, @selector(barTitltColor));
    return color?color:[UIColor orangeColor];
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
    [self setNavTitle:title withColor:[self barNavTitltColor] Font:[self barNavTitltFont]];
}
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color
{
    [self setNavTitle:title withColor:color Font:[self barNavTitltFont]];
}
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color Font:(UIFont *)font
{
    [self setNavTitle:title withColor:color Font:font Block:nil];
}
- (void)setNavTitle:(NSString *)title withColor:(UIColor *)color Font:(UIFont *)font Block:(void (^)(UIButton *btn))block
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:color ? color :[self barNavTitltColor]
                          range:NSMakeRange(0, title.length)];
    [attributedStr addAttribute:NSFontAttributeName
                          value:font ? font :[self barNavTitltFont]
                          range:NSMakeRange(0, title.length)];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = 1;
    paraStyle.paragraphSpacing  = 1;
    [attributedStr addAttribute:NSParagraphStyleAttributeName
                          value:paraStyle
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
    btn.bounds = CGRectMake(0, 0, btn.frame.size.width+20, btn.frame.size.height);
//      btn.backgroundColor = [UIColor orangeColor];
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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [button setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
//    button.backgroundColor = [UIColor orangeColor];
    [button addTapBlock:^(UIButton * _Nonnull btn) {
        if (block) {
            block(weakNavBackSelf);
        } else{
            if (weakNavBackSelf.navigationController) {
                if (weakNavBackSelf.navigationController.viewControllers.count == 1) {
                    if (weakNavBackSelf.presentingViewController) {
                        [weakNavBackSelf dismissViewControllerAnimated:YES completion:nil];
                    }
                } else {
                    [weakNavBackSelf.navigationController popViewControllerAnimated:YES];
                }
            } else if(weakNavBackSelf.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        
        }
    }];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark -- 左侧按钮
-(void)addBarLeftWithTitle:(NSString *)title
                    Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarLeftWithTitle:title Image:nil Style:EdgeInsetsStyleTop Target:selectBlock];
}

-(void)addBarLeftWithImage:(UIImage *)image
                    Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarLeftWithTitle:nil Image:image Style:EdgeInsetsStyleTop Target:selectBlock];
}

-(void)addBarLeftWithTitle:(NSString *)title
                     Image:(UIImage *)image
                     Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                    Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self itemBarWithTitle:title Image:image Style:style IsLeft:NO Target:selectBlock];
}
-(void)addBarLeftWithModel:(CGXNavigationBarItemModel *)model
                    Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarLeftMorelWithArr:@[model] Target:selectBlock];
}
-(void)addBarLeftMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                       Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self itemBarMorelWithArr:array IsLeft:YES Target:selectBlock];
}
#pragma mark -- 右侧按钮
-(void)addBarRightWithTitle:(NSString *)title
                     Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarRightWithTitle:title Image:nil Style:EdgeInsetsStyleTop Target:selectBlock];
}

-(void)addBarRightWithImage:(UIImage *)image
                     Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarRightWithTitle:nil Image:image Style:EdgeInsetsStyleTop Target:selectBlock];
}

-(void)addBarRightWithTitle:(NSString *)title
                      Image:(UIImage *)image
                      Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                     Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self itemBarWithTitle:title Image:image Style:style IsLeft:NO Target:selectBlock];
}
-(void)addBarRightWithModel:(CGXNavigationBarItemModel *)model
                     Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self addBarRightMorelWithArr:@[model] Target:selectBlock];
}
-(void)addBarRightMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                        Target:(UIViewControllerItemSelectBlock)selectBlock
{
    [self itemBarMorelWithArr:array IsLeft:NO Target:selectBlock];
}



-(void)itemBarWithTitle:(NSString *)title
                  Image:(UIImage *)image
                  Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                 IsLeft:(BOOL)isLeft
                 Target:(UIViewControllerItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    if (title) {
        model.itemNormalTitle = title;
        model.itemNormalFont = self.barTitltFont;
        model.itemNormalColor = self.barTitltColor;
    }
    if (image) {
        model.itemNormalImage = image;
    }
    
    if (title) {
        if (image) {
            model.style = ItemModelStyleAll;
        } else{
            model.style = ItemModelStyleTitle;
        }
    } else{
        model.style = ItemModelStyleImage;
    }
    model.edgeInsetsStyle = style;
    
    if (title || image) {
        if (isLeft) {
            [self addBarLeftWithModel:model Target:selectBlock];
        } else{
            [self addBarRightWithModel:model Target:selectBlock];
        }
    }
}


-(void)itemBarMorelWithArr:(NSArray<CGXNavigationBarItemModel *> *)array
                    IsLeft:(BOOL)isLeft
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
    if (itemArr.count>0) {
        if (isLeft) {
            self.navigationItem.leftBarButtonItems = itemArr;
        } else{
            self.navigationItem.rightBarButtonItems = itemArr;
        }
    }
}


@end

