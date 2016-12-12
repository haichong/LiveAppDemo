//
//  FHLiveViewController.m
//  LiveAppDemo
//
//  Created by FuHang on 16/9/30.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHLiveViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <UIImageView+WebCache.h>

// ijk下载地址： https://pan.baidu.com/s/1c2p9D0s

@interface FHLiveViewController ()
// 播放器
@property (nonatomic, strong) IJKFFMoviePlayerController *playerVC;

@end

@implementation FHLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏导航栏
    [self.navigationController.navigationBar setHidden:YES];
    // 设置背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 拉流地址
    NSURL *url = [NSURL URLWithString:self.liveUrl];
    // 实例化播放器，传入拉流地址即可
    _playerVC = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    // 准备播放 准备好了自动播放
    [_playerVC prepareToPlay];
    // 设置播放器尺寸
    _playerVC.view.frame = [[UIScreen mainScreen] bounds];
    [self.view addSubview:_playerVC.view];
    // 设置填充模式:铺满
    [_playerVC setScalingMode:IJKMPMovieScalingModeAspectFill];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 关闭播放时，要停止播放器，否则会崩溃
    [_playerVC pause];
    [_playerVC stop];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
