//
//  FHFuncationListTableViewController.m
//  LiveAppDemo
//
//  Created by FuHang on 2016/12/13.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHFuncationListTableViewController.h"
#import "AppDelegate.h"
#import "FHNavigationController.h"
#import "FHLiveListViewController.h"
#import "FHCameraViewController.h"
#import "FHUImageFilterViewController.h"
#import "FHBeautyViewController.h"

@interface FHFuncationListTableViewController ()

@property (nonatomic, strong) NSArray *functionArr;

@end

@implementation FHFuncationListTableViewController

- (NSArray *)functionArr {
    if (!_functionArr) {
     
        _functionArr = [NSArray arrayWithObjects:@"直播",@"采集",@"滤镜",@"美颜",nil];
    }
    return _functionArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"功能列表";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.functionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = self.functionArr[indexPath.row];
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self setupLiveListVCToRootVC];
            break;
        case 1:
            [self setupCameraVCToRootVC];
            break;
        case 2:
            [self setupFilterVCToRootVC];
            break;
        default:
            [self setupBeautyVCToRootVC];
            break;
    }
}
- (UIWindow *)getAppDelegate {
    
    return [(AppDelegate *)[UIApplication sharedApplication].delegate window];
}
// 直播:播放
- (void)setupLiveListVCToRootVC {
    
    FHLiveListViewController *vc = [[FHLiveListViewController alloc] init];
    FHNavigationController *nav = [[FHNavigationController alloc] initWithRootViewController:vc];
    [[self getAppDelegate] setRootViewController:nav];
}
// 采集
- (void)setupCameraVCToRootVC {
    
    FHCameraViewController *cameraVC = [FHCameraViewController new];
    FHNavigationController *cameraNav =[[FHNavigationController alloc] initWithRootViewController:cameraVC];
    [[self getAppDelegate] setRootViewController:cameraNav];
}
// 滤镜
- (void)setupFilterVCToRootVC {
    
    FHUImageFilterViewController *filterVC = [FHUImageFilterViewController new];
    FHNavigationController *filterNav = [[FHNavigationController alloc] initWithRootViewController:filterVC];
    [[self getAppDelegate] setRootViewController:filterNav];
}
// 美颜
- (void)setupBeautyVCToRootVC{
    
    FHBeautyViewController *beautyVC = [FHBeautyViewController new];
    FHNavigationController *beautyNav = [[FHNavigationController alloc] initWithRootViewController:beautyVC];
    [[self getAppDelegate] setRootViewController:beautyNav];
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
