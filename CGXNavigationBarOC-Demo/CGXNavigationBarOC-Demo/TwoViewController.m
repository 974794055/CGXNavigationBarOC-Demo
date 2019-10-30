//
//  TwoViewController.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/30.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "TwoViewController.h"

#import "CGXNavigationBarNavView.h"

@interface TwoViewController ()

@property (nonatomic, strong) CGXNavigationBarNavView *customNavBar;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self bgColor];
 __weak typeof(self) weakSelf = self;
 
    
    
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
}

- (void)setupNavBar
{
     self.customNavBar = [CGXNavigationBarNavView CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    self.customNavBar.backColor = [UIColor orangeColor];
    // 设置自定义导航栏背景图片
//    self.customNavBar.backImage = [UIImage imageNamed:@"millcolorGrad"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"Arrow"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.titleLabel.numberOfLines = 0;
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 44, 60, 44);
    btn.userInteractionEnabled = YES;
    [self.customNavBar addSubview:btn];
}

- (void)back
{
//    [self.navigationController popViewControllerAnimated:YES];
      [self wr_toLastViewController];
}

- (void)wr_toLastViewController
{
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIViewController*)wr_currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self wr_currentViewControllerFrom:rootViewController];
}

- (UIViewController*)wr_currentViewControllerFrom:(UIViewController*)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self wr_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    }
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self wr_currentViewControllerFrom:tabBarController.selectedViewController];
    }
    else if (viewController.presentedViewController != nil) {
        return [self wr_currentViewControllerFrom:viewController.presentedViewController];
    }
    else {
        return viewController;
    }
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

