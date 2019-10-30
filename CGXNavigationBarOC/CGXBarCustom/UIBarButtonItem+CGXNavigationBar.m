//
//  UIBarButtonItem+CGXNavigationBar.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "UIBarButtonItem+CGXNavigationBar.h"
#import <objc/runtime.h>
#import "UIButton+CGXBarButtonImageTitleSpace.h"
#import "UIButton+CGXBarButtonBlock.h"
@interface UIBarButtonItem()

@property (nonatomic , copy) CGXBarButtonItemSelectBlock selectBlock;

@end

@implementation UIBarButtonItem (CGXNavigationBar)

+(UIBarButtonItem *)itemWithTitle:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor
                           Target:(CGXBarButtonItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.style = ItemModelStyleTitle;
    return [UIBarButtonItem itemWithModel:model Target:selectBlock];
}
+(UIBarButtonItem *)itemWithImage:(UIImage *)image
                           Target:(CGXBarButtonItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalImage = image;
    model.style = ItemModelStyleImage;
    return [UIBarButtonItem itemWithModel:model Target:selectBlock];
}
+(UIBarButtonItem *)itemWithImage:(UIImage *)image
                            Title:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor
                           Target:(CGXBarButtonItemSelectBlock)selectBlock
{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.itemNormalImage = image;
    model.style = ItemModelStyleAll;
    return [UIBarButtonItem itemWithImage:image Title:title font:font titleColor:titleColor Style:EdgeInsetsStyleTop Target:selectBlock];
}
+(UIBarButtonItem *)itemWithImage:(UIImage *)image
                            Title:(NSString *)title
                             font:(UIFont *)font
                       titleColor:(UIColor *)titleColor
                            Style:(CGXNavigationBarItemModelEdgeInsetsStyle)style
                           Target:(CGXBarButtonItemSelectBlock)selectBlock;

{
    CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
    model.itemNormalTitle = title;
    model.itemNormalFont = font;
    model.itemNormalColor = titleColor;
    model.itemNormalImage = image;
    model.style = ItemModelStyleAll;
    model.edgeInsetsStyle = style;
    return [UIBarButtonItem itemWithModel:model Target:selectBlock];
}
+(UIBarButtonItem *)itemWithModel:(CGXNavigationBarItemModel *)model
                           Target:(CGXBarButtonItemSelectBlock)selectBlock
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
        button.bounds = CGRectMake(0, 0, 40+model.itemSpace, 44);
    } else{
        button.bounds = CGRectMake(0, 0, button.frame.size.width+model.itemSpace, 44);
    }
    __weak typeof(button) weakBtn = button;
//    __weak typeof(model) weakModel = model;
    [button addTapBlock:^(UIButton * _Nonnull btn) {
        if (selectBlock) {
            selectBlock(weakBtn,model);
        }
    }];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
