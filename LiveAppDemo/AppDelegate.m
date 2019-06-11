//
//  AppDelegate.m
//  LiveAppDemo
//
//  Created by FuHang on 16/9/30.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "AppDelegate.h"
#import "FHNavigationController.h"
#import "FHFuncationListTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
   
    FHFuncationListTableViewController *funcationVC = [FHFuncationListTableViewController new];
    FHNavigationController *funcationNaV = [[FHNavigationController alloc] initWithRootViewController:funcationVC];
    self.window.rootViewController = funcationNaV;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
