//
//  TwoViewController.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "TwoViewController.h"


#import "CGXNavigationBarOC.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bgColor];
 __weak typeof(self) weakSelf = self;
  [self bgColor];
//    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
    
    NSArray *arr = @[@"哈1"];
    NSMutableArray *itemArr  =[NSMutableArray array];
    for (int i = 0; i<arr.count; i++) {
        CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
        model.itemNormalTitle = arr[i];
        [itemArr addObject:model];
    }
    [self addBarLeftMorelWithArr:itemArr Target:^(UIButton *btn, CGXNavigationBarItemModel *item) {
        NSLog(@"%ld--%@", btn.tag,item.itemNormalTitle);

    }];


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


    // 设置导航栏颜色
    [self gx_setNavBarBarTintColor:[UIColor orangeColor]];
    // 设置初始导航栏透明度
    [self gx_setNavBarBackgroundAlpha:1];
        // 设置导航栏按钮和标题颜色
    [self gx_setNavBarTintColor:[UIColor whiteColor]];

    [self gx_setNavBarTitleColor:[UIColor whiteColor]];
    
    
    [self gx_setStatusBarStyle:UIStatusBarStyleDefault];
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
}
- (void)setupNavBar
{

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

