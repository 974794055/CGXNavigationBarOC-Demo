//
//  UIButton+CGXTableViewGeneralBtnBlock.h
//  CGXTableViewGeneralView
//
//  Created by 曹贵鑫 on 2018/12/28.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (CGXBarButtonBlock)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addTapBlock:(void(^)(UIButton*btn))block;

@end

NS_ASSUME_NONNULL_END
