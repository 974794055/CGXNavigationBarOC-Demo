//
//  CGXNavigationBarItemModel.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/1.
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
        self.itemSpace = 0;
        
    }
    return self;
}
@end
