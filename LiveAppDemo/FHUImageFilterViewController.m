//
//  FHUImageFilterViewController.m
//  LiveAppDemo
//
//  Created by FuHang on 2016/11/3.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHUImageFilterViewController.h"
#import <GPUImage/GPUImage.h>

@interface FHUImageFilterViewController ()

// 视屏源
@property (nonatomic, strong)GPUImageVideoCamera *videoCamera;
// 磨皮滤镜
@property (nonatomic, weak)GPUImageBilateralFilter *bilateralFilter;
// 美白滤镜
@property (nonatomic, weak)GPUImageBrightnessFilter *brightnessFilter;
@end

@implementation FHUImageFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建视屏源
    /*
     * sessionPreset : 屏幕分辨率
     * cameraPosition： 摄像头位置
     **/
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    // 设置输出图像方向
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = videoCamera;
    
    // 创建最终预览View
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    captureVideoPreview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view insertSubview:captureVideoPreview atIndex:0];
    
    // 创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];
   
    // 磨皮滤镜
    GPUImageBilateralFilter *bilateraFilter = [[GPUImageBilateralFilter alloc] init];
    [groupFilter addTarget:bilateraFilter];
    _bilateralFilter = bilateraFilter;
    
    // 美白滤镜
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [groupFilter addTarget:brightnessFilter];
    _brightnessFilter = brightnessFilter;
    
    // 设置滤镜组链
    [bilateraFilter addTarget:brightnessFilter];
    [groupFilter setInitialFilters:@[bilateraFilter]];
    groupFilter.terminalFilter = brightnessFilter;
    
    // 设置GPUImage的响应链， 从数据源 ==> 滤镜 ==> 最终界面效果
    [videoCamera addTarget:groupFilter];
    [groupFilter addTarget:captureVideoPreview];
    
    // 必须采用startCameraCapture, 底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    [videoCamera startCameraCapture];
}
- (IBAction)brightnessFiller:(id)sender {
    UISlider *slider = (UISlider *)sender;
    // (亮度)brightness取值范围[-1,1],0为正常状态
    _brightnessFilter.brightness = slider.value;
}
- (IBAction)bilateralFilter:(id)sender {
    UISlider *slider = (UISlider *)sender;
    CGFloat maxValue = 100;
    //平滑因子(distanceNormalizationFactor)值越小，磨皮效果越好，但是必须大于1.
    _bilateralFilter.distanceNormalizationFactor = maxValue - slider.value;
    NSLog(@"distanceNormalizationFactor=%f",_bilateralFilter.distanceNormalizationFactor);
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
