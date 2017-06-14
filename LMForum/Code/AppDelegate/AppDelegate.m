//
//  AppDelegate.m
//  LMForum
//
//  Created by 梁海军 on 2016/12/7.
//  Copyright © 2016年 lhj. All rights reserved.
//

#import "AppDelegate.h"
#import "LNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self showMainTab];
    //设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = RGB(234, 235, 236, 1);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}

//--------------------------------------------method----------------------------------------------//
///显示主界面
-(void)showMainTab{
    self.mainController = [[MainTabBarController alloc] init];
    RTRootNavigationController *nc = [[RTRootNavigationController alloc] initWithRootViewController:self.mainController];
    self.window.rootViewController = nc;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



@end
