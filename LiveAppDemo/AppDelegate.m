//
//  AppDelegate.m
//  LiveAppDemo
//
//  Created by FuHang on 16/9/30.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "AppDelegate.h"
#import "FHNavigationController.h"
#import "FHListViewController.h"
#import "FHCameraViewController.h"
#import "FHUImageFilterViewController.h"
#import "FHBeautyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    // 直播:播放
    FHListViewController *vc = [[FHListViewController alloc] init];
    FHNavigationController *nav = [[FHNavigationController alloc] initWithRootViewController:vc];

    /*
    FHCameraViewController *cameraVC = [FHCameraViewController new];
    FHUImageFilterViewController *filterVC = [FHUImageFilterViewController new];
    FHBeautyViewController *beautyVC = [FHBeautyViewController new];
   
    FHNavigationController *cameraNaC =[[FHNavigationController alloc] initWithRootViewController:cameraVC];
    FHNavigationController *filterNav = [[FHNavigationController alloc] initWithRootViewController:filterVC];
    FHNavigationController *beautyNav = [[FHNavigationController alloc] initWithRootViewController:beautyVC];
   */
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
