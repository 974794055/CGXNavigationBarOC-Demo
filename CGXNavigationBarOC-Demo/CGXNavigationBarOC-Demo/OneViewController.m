//
//  OneViewController.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "OneViewController.h"
#import "CGXNavigationBarNavView.h"
#import "CGXNavigationBarOC.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bgColor];
     [self addNavBack];
    
    __weak typeof(self) weakSelf = self;

    NSArray *arr1 = @[@"哈1",@"哈2",@"哈3"];
    NSMutableArray *itemArr1  =[NSMutableArray array];
    for (int i = 0; i<arr1.count; i++) {
        CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
        model.itemNormalTitle = arr1[i];
        [itemArr1 addObject:model];
    }
    [self addBarRightMorelWithArr:itemArr1 Target:^(UIButton *btn, CGXNavigationBarItemModel *item) {
        NSLog(@"%ld--%@", btn.tag,item.itemNormalTitle);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
