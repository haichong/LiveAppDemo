//
//  FHBeautyViewController.m
//  LiveAppDemo
//
//  Created by FuHang on 2016/11/7.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHBeautyViewController.h"
#import "GPUImageBeautifyFilter.h"
#import <GPUImage/GPUImage.h>

@interface FHBeautyViewController ()

@property(nonatomic,strong) GPUImageVideoCamera *videoCamera;
@property(nonatomic,strong) GPUImageView *captureVideoPreview;

@end

@implementation FHBeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建视频源
    _videoCamera  = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    _videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    
    // 创建最终预览View
   _captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    _captureVideoPreview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:_captureVideoPreview atIndex:0];
    
    [_videoCamera addTarget:_captureVideoPreview];
    // 开始采集视屏
    [_videoCamera startCameraCapture];
    
}
- (IBAction)isOnBeautyAction:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    // 切换美颜效果原理：移除之前所有处理链，重新设置处理链
    if (mySwitch.isOn) {
        // 移除之前所有处理链
        [_videoCamera removeAllTargets];
        // 创建美颜滤镜
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        // 设置GPUImage处理链，从数据源 => 滤镜 => 最终界面效果
        [_videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:_captureVideoPreview];
       
    }else {
        // 关闭美颜
        [_videoCamera removeAllTargets];
        [_videoCamera addTarget:_captureVideoPreview];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
