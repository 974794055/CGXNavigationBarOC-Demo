//
//  UIButton+CGXTableViewGeneralBtnBlock.m
//  CGXTableViewGeneralView
//
//  Created by 曹贵鑫 on 2018/12/28.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import "UIButton+CGXBarButtonBlock.h"
#import <objc/runtime.h>

@implementation UIButton (CGXBarButtonBlock)

-(void)setBlock:(void(^)(UIButton*))block{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}
-(void(^)(UIButton*))block{
    return objc_getAssociatedObject(self,@selector(block));
    
}
-(void)addTapBlock:(void(^)(UIButton*))block{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click:(UIButton*)btn{
    if(self.block){
        self.block(btn);
    }
}



@end
