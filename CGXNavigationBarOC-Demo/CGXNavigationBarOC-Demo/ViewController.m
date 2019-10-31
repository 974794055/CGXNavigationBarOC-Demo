//
//  ViewController.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/23.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "ViewController.h"
#import "CGXNavigationBarNavView.h"
#import "CGXNavigationBarOC.h"
#import "OneViewController.h"
#import "TwoViewController.h"

#import "CustomUINavigationBar.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *item1 =  [UIBarButtonItem itemWithTitle:@"哈哈哈" font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor] Target:^(UIButton * _Nonnull btn, CGXNavigationBarItemModel * _Nonnull item) {
        NSLog(@"%ld--%ld" , btn.tag,item.style);
    }];
    UIBarButtonItem *item2 =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"Arrow"] Target:^(UIButton * _Nonnull btn, CGXNavigationBarItemModel * _Nonnull item) {
         NSLog(@"%ld--%ld" , btn.tag,item.style);
    }];
    UIBarButtonItem *item3 =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"shaixuan"] Title:@"筛选"  font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor]  Target:^(UIButton * _Nonnull btn, CGXNavigationBarItemModel * _Nonnull item) {
         NSLog(@"%ld--%ld" , btn.tag,item.style);
    }];
    UIBarButtonItem *item4 =  [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"shaixuan"] Title:@"筛选"  font:[UIFont systemFontOfSize:14] titleColor:[UIColor blackColor] Style:EdgeInsetsStyleBottom Target:^(UIButton * _Nonnull btn, CGXNavigationBarItemModel * _Nonnull item) {
         NSLog(@"%ld--%ld" , btn.tag,item.style);
    }];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];

            spaceItem.width = 1;
    
    self.navigationItem.leftBarButtonItems = @[item1,spaceItem,item2];
    self.navigationItem.rightBarButtonItems = @[item3,spaceItem,item4];
    [self bgColor:[UIColor whiteColor]];
    
    [self setNavTitle:@"哈哈"];
    
    [self setNavTitle:@"我我" withColor:[UIColor redColor] Font:[UIFont systemFontOfSize:18] Block:^(UIButton *btn) {
        NSLog(@"我我-%ld" , btn.tag);
         [weakSelf pushVC];
    }];
    
    CustomUINavigationBar *navbar = (CustomUINavigationBar *)self.navigationController.navigationBar;
    navbar.leftValue = 0;
    [navbar setItemsSpace:10];
  
}

- (void)pushVC
{
    OneViewController *vc = [[OneViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
