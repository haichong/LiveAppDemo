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

    // 创建视屏源
    GPUImageVideoCamera *videoCamera  = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    _videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    captureVideoPreview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:captureVideoPreview atIndex:0];
    _captureVideoPreview = captureVideoPreview;
    
    // 设置处理链
    [_videoCamera addTarget:captureVideoPreview];
    // 必须调用startCameraCapture,底层才会把采集到的视屏源，渲染到GPUImageView中，就显示了
    // 开始采集视屏
    [videoCamera startCameraCapture];
    
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
