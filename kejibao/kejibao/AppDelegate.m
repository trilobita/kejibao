//
//  AppDelegate.m
//  kejibao
//
//  Created by Trilobita on 16/2/22.
//  Copyright © 2016年 Trilobita. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MenuViewController.h"
#import "YRSideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)createrootView {
    ViewController *vc = [[ViewController alloc] init];
    
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    UIViewController *leftViewController = [[MenuViewController alloc] init];
    
    YRSideViewController *windowView = [[YRSideViewController alloc] init];
    windowView.leftViewController = leftViewController;
    windowView.rootViewController = rootViewController;
    
    windowView.leftViewShowWidth = WIDTH*LEFTVIEWSCALE;
    [windowView setRootViewMoveBlock:^(UIView *rootView, CGRect orginFrame, CGFloat xoffset) {
        
        rootView.frame = CGRectMake(xoffset, 0, WIDTH, HEIGHT);
        
    }];
    
    
    vc.showMenu = ^(){
        [windowView showLeftViewController:YES];
    };
    
    self.window.rootViewController = windowView;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:0.50];
    
    //创建一个窗口,并初始化大小为设备大小
    self.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //设置窗口背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    
    //给窗口添加一个根视图
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    
//    nc.navigationBar.backgroundColor = [UIColor blueColor];
//    nc.navigationBar.translucent = YES;
    
//    self.window.rootViewController = nc;
    [self createrootView];
    
    //设置窗口可见
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
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
