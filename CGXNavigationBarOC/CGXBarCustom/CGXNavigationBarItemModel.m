//
//  CGXNavigationBarItemModel.m
//  CGXNavigationBarOC-Demo
//
//  Created by MacMini-1 on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "CGXNavigationBarItemModel.h"

@implementation CGXNavigationBarItemModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.style = ItemModelStyleTitle;
        self.edgeInsetsStyle = EdgeInsetsStyleTop;
        self.itemNormalColor = [UIColor blackColor];
        self.itemNormalFont = [UIFont systemFontOfSize:14];
        self.itemTag = 10000;
        self.itemSpace = 5;
        
    }
    return self;
}
@end