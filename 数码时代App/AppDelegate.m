//
//  AppDelegate.m
//  数码时代App
//
//  Created by dlios on 14-12-30.
//  Copyright (c) 2014年  All rights reserved.
//

#import "AppDelegate.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "ProductViewController.h"
#import "NewsViewController.h"
//#import "ShareSDK/ShareSDK.h"
//#import "WeiboSDK.h"
#import "KJAnimationViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [_window makeKeyAndVisible];
    KJAnimationViewController *kj = [[KJAnimationViewController alloc] init];
    [_window setRootViewController:kj];
#pragma _mark
#pragma 允许重力感应
    application.applicationSupportsShakeToEdit = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerAction:) userInfo:nil repeats:NO];
    [kj release];

        return YES;
}
- (void)timerAction:(id)sender
{
    NewsViewController *fir = [[NewsViewController alloc] init];
    ProductViewController *sec = [[ProductViewController alloc] init];
    ThreeViewController *three = [[ThreeViewController alloc] init];
    FourViewController *four = [[FourViewController alloc] init];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:fir];
    [nav1.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlePic.png"] forBarMetrics: UIBarMetricsDefault];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:sec];
    [nav2.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlePic.png"] forBarMetrics: UIBarMetricsDefault];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:three];
    [nav3.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlePic.png"] forBarMetrics: UIBarMetricsDefault];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:four];
    [nav4.navigationBar setBackgroundImage:[UIImage imageNamed:@"titlePic.png"] forBarMetrics: UIBarMetricsDefault];
    [nav1.navigationBar setTranslucent:NO];
    [nav2.navigationBar setTranslucent:NO];
    [nav3.navigationBar setTranslucent:NO];
    [nav4.navigationBar setTranslucent:NO];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:nav1,nav2,nav3,nav4,nil];
    UITabBarController *tab = [[UITabBarController alloc] init];
    [_window setRootViewController:tab];
    [tab setViewControllers:array animated:YES];
    [tab.tabBar setTintColor:[UIColor redColor]];
    [tab.tabBar setTranslucent:NO];
    [tab.tabBar setBackgroundColor:[UIColor whiteColor]];
//#pragma mark-
//#pragma mark 设置ShareSDK
//    [ShareSDK registerApp:@"51f238f47e92"];
//    
//    [ShareSDK connectSinaWeiboWithAppKey:@"3803060838"
//                               appSecret:@"e1acbe3a6feb9be2ad1053c7ffc755fd"
//                             redirectUri:@"http://my.csdn.net/my/mycsdn"];
//    
//    [ShareSDK  connectSinaWeiboWithAppKey:@"3803060838"
//                                appSecret:@"e1acbe3a6feb9be2ad1053c7ffc755fd"
//                              redirectUri:@"http://my.csdn.net/my/mycsdn"
//                              weiboSDKCls:[WeiboSDK class]];
//    
#pragma mark-
#pragma mark 设置tabBarItem的图片
    
    //加载tabBarItem图片
    UIImage *image = [UIImage imageNamed:@"资讯.png"];
    UIImage *select = [UIImage imageNamed:@"zixun.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    select = [select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fir.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"资讯" image:image selectedImage:select];
    image = [UIImage imageNamed:@"找产品.png"];
    select = [UIImage imageNamed:@"zhaocanpin.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    select = [select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    sec.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"找产品" image:image selectedImage:select];
    image = [UIImage imageNamed:@"图赏.png"];
    select = [UIImage imageNamed:@"tushang.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    select = [select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    three.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"图赏" image:image selectedImage:select];
    image = [UIImage imageNamed:@"论坛.png"];
    select = [UIImage imageNamed:@"luntan.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    select = [select imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    four.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"论坛" image:image selectedImage:select];
    
    [fir release];
    [sec release];
    [three release];
    [four release];
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
