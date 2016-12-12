//
//  FHCameraViewController.m
//  LiveAppDemo
//
//  Created by FuHang on 2016/11/2.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHCameraViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "FHUImageFilterViewController.h"
#import "FHCameraView.h"

@interface FHCameraViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate>
{
    AVCaptureSession *_captureSession;
    AVCaptureDeviceInput *_currentVideoDeviceInput;
    AVCaptureConnection *_videoConnection;
    AVCaptureVideoPreviewLayer *_previewdLayer;
}
@property (nonatomic, strong)UIImageView *focusCursorImageView;

@end

@implementation FHCameraViewController

- (UIImageView *)focusCursorImageView {
    if (!_focusCursorImageView) {
        _focusCursorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"focus"]];
        [self.view addSubview:_focusCursorImageView];
    }
    return _focusCursorImageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCaputureVideo];
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
// 捕获音视频
- (void)setupCaputureVideo {
    // 1.创建捕获对话，必须要强引用，否则会释放
    _captureSession = [[AVCaptureSession alloc] init];
    // 2.捕获摄像头设备，默认前置摄像头
    AVCaptureDevice *videoDevice = [self getVideoDevice:AVCaptureDevicePositionFront];
    // 3.获取声音设备
    AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    // 4.创建对应视屏设备输入对象
    _currentVideoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
    // 5.创建对应音频设备输入对象
     AVCaptureDeviceInput *audioDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];
    // 6.添加到会话中 注意：最好要判断是否能添加输入，会话不能添加空的
    // 6.1 添加视屏
    if ([_captureSession canAddInput:_currentVideoDeviceInput]) {
        [_captureSession addInput:_currentVideoDeviceInput];
    }
    // 6.2 添加音频
    if ([_captureSession canAddInput:audioDeviceInput]) {
        [_captureSession addInput:audioDeviceInput];
    }
    // 7.捕获视屏数据输出设备
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t videoQueue = dispatch_queue_create("Video Capure Queue", DISPATCH_QUEUE_SERIAL);
    [videoOutput setSampleBufferDelegate: self queue:videoQueue];
    if ([_captureSession canAddOutput:videoOutput]) {
        [_captureSession addOutput:videoOutput];
    }
    // 8.设置音频数据输出设备
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    // 8.1 设置代理，捕获视屏样品数据 注意：必须是串行队列才能捕获到数据,而且不能为空
    dispatch_queue_t audioQueue = dispatch_queue_create("Audio Capure Queue", DISPATCH_QUEUE_SERIAL);
    [audioOutput setSampleBufferDelegate:self queue:audioQueue];
    if ([_captureSession canAddOutput:audioOutput]) {
        [_captureSession addOutput:audioOutput];
    }
    // 9.获取视屏输入与输出连接，用于分辨音视频数据
    _videoConnection = [videoOutput connectionWithMediaType:AVMediaTypeVideo];
    // 10.添加视屏预览图层
    _previewdLayer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    _previewdLayer.frame = [UIScreen mainScreen].bounds;
    [self.view.layer  insertSublayer:_previewdLayer atIndex:0];
    [_captureSession startRunning];
    
    FHCameraView *cameraView = [[FHCameraView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [self.view addSubview:cameraView];
}
// 指定摄像头方向获取摄像头
- (AVCaptureDevice *)getVideoDevice: (AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) {
            return device;
        }
    }
    return nil;
}
#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
// 获取输入设备数据，有可能是音频，有可能是视屏
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
//    if (_videoConnection == connection) {
//        NSLog(@"采集到视屏数据");
//    }else {
//        NSLog(@"采集到音频数据");
//    }
}
#pragma mark - 切换摄像头
- (IBAction)toggleCapture:(id)sender {
    // 获取当前设备方向
    AVCaptureDevicePosition cureentPosition = _currentVideoDeviceInput.device.position;
    // 获取需要改变的方向
    AVCaptureDevicePosition togglePosition = (cureentPosition == AVCaptureDevicePositionFront ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront);
    // 获取需要改变的摄像头设备
    AVCaptureDevice *toggleDevice = [self getVideoDevice:togglePosition];
    // 获取需要改变的摄像头输入设备
    AVCaptureDeviceInput *toggleDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:toggleDevice error:nil];
    [_captureSession stopRunning];
    // 移除之前的摄像头输入设备
    [_captureSession removeInput:_currentVideoDeviceInput];
    // 添加新的摄像头输入设备
    [_captureSession addInput:toggleDeviceInput];
    [_captureSession startRunning];
    // 记录当前摄像头输入设备
    _currentVideoDeviceInput = toggleDeviceInput;
}
#pragma mark - 聚集光标
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 获取点击位置
    UITouch *touch= [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    // 把当前位置转换为摄像头点上的位置
    CGPoint cameraPoint = [_previewdLayer captureDevicePointOfInterestForPoint:point];
    // 设置聚集光标的位置
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
    // 设置聚焦
}
 // 设置聚集光标的位置
- (void)setFocusCursorWithPoint: (CGPoint)point {
    self.focusCursorImageView.center = point;
    self.focusCursorImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursorImageView.alpha = 1.0f;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursorImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursorImageView.alpha = 0.0f;
    }];
}
// 设置聚焦
- (void)focusWithMode: (AVCaptureFocusMode)focusMode exposureMode: (AVCaptureExposureMode)exposureMode atPoint: (CGPoint)point {
    
    AVCaptureDevice *captureDevice = _currentVideoDeviceInput.device;
    // 锁定配置 否则会崩溃
    [captureDevice lockForConfiguration:nil];
    // 设置聚焦
    if ([captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    if ([captureDevice isFocusPointOfInterestSupported]) {
        [captureDevice setFocusPointOfInterest:point];
    }
    // 设置曝光
    if ([captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
        [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
    }
    if ([captureDevice isExposurePointOfInterestSupported]) {
        [captureDevice setExposurePointOfInterest:point];
    }
    // 解锁配置
    [captureDevice unlockForConfiguration];
}
- (IBAction)backAction:(id)sender {
    
    FHUImageFilterViewController *filterVC = [FHUImageFilterViewController new];
    [self presentViewController:filterVC animated:YES completion:nil];
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
