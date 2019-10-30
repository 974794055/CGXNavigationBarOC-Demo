//
//  AppDelegate.m
//  CGXNavigationBarOC-Demo
//
//  Created by CGX on 2019/10/23.
//  Copyright © 2019 CGX. All rights reserved.
//

#import "AppDelegate.h"
#import "CGXNavigationBarNavView.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    
    [self setNavBarAppearence];
    return YES;
}

- (void)setNavBarAppearence
{
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
//    [UINavigationBar appearance].tintColor = [UIColor yellowColor];
//    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UIApplication sharedApplication].statusBarHidden = NO;

    // 设置是 广泛使用CGXNavigationBarNavView，还是局部使用CGXNavigationBarNavView，目前默认是广泛使用
    [CGXNavigationBarNavView gx_widely];
//    [CGXNavigationBarNavView gx_setBlacklist:@[@"SpecialController",
//                                       @"TZPhotoPickerController",
//                                       @"TZGifPhotoPreviewController",
//                                       @"TZAlbumPickerController",
//                                       @"TZPhotoPreviewController",
//                                       @"TZVideoPlayerController"]];
    
    // 设置导航栏默认的背景颜色
    [CGXNavigationBarNavView gx_setDefaultNavBarBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
    // 设置导航栏所有按钮的默认颜色
    [CGXNavigationBarNavView gx_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [CGXNavigationBarNavView gx_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    // 统一设置状态栏样式
    [CGXNavigationBarNavView gx_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [CGXNavigationBarNavView gx_setDefaultNavBarShadowImageHidden:YES];
}



@end
