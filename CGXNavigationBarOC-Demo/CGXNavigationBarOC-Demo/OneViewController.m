//
//  OneViewController.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "OneViewController.h"
#import "CGXNavigationBarNavView.h"

@interface OneViewController ()

@property (nonatomic, strong) CGXNavigationBarNavView *customNavBar;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bgColor];
 __weak typeof(self) weakSelf = self;
    
    NSArray *arr = @[@"哈1",@"哈2",@"哈3"];
    NSMutableArray *itemArr  =[NSMutableArray array];
    for (int i = 0; i<arr.count; i++) {
        CGXNavigationBarItemModel *model = [[CGXNavigationBarItemModel alloc] init];
        model.itemNormalTitle = arr[i];
        [itemArr addObject:model];
    }
    [self addBarLeftMorelWithArr:itemArr Target:^(UIButton *btn, CGXNavigationBarItemModel *item) {
        NSLog(@"%ld--%@", btn.tag,item.itemNormalTitle);
        
    }];
    
    [self addBarRightMorelWithArr:itemArr Target:^(UIButton *btn, CGXNavigationBarItemModel *item) {
        NSLog(@"%ld--%@", btn.tag,item.itemNormalTitle);
    }];
    
      [self addNavBack];
    
    
   
//    [self addBarLeftWithTitle:@"试试" Target:^(UIButton * _Nonnull btn, CGXNavigationBarItemModel * _Nonnull item) {
//        [weakSelf.navigationController popViewControllerAnimated:YES];
//    }];
    
//    self.navigationController.navigationBar.hidden = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    [self setupNavBar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar navBarBackGroundColor:[UIColor orangeColor] isOpaque:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar navBarBackGroundColor:[UIColor colorWithWhite:0.93 alpha:1] isOpaque:YES];
    
}
- (void)setupNavBar
{
//     self.customNavBar = [CGXNavigationBarNavView CustomNavigationBar];
//    [self.view addSubview:self.customNavBar];
//    self.customNavBar.backColor = [UIColor orangeColor];
    // 设置自定义导航栏背景图片
//    self.customNavBar.backImage = [UIImage imageNamed:@"millcolorGrad"];

    // 设置自定义导航栏标题颜色
//    self.customNavBar.titleLabelColor = [UIColor whiteColor];

//    if (self.navigationController.childViewControllers.count != 1) {
////        [self.customNavBar wr_setLeftButtonWithTitle:@"<<" titleColor:[UIColor whiteColor]];
//    }
}
//
//- (CGXNavigationBarNavView *)customNavBar
//{
//    if (_customNavBar == nil) {
//        _customNavBar = [CGXNavigationBarNavView CustomNavigationBar];
//    }
//    return _customNavBar;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
