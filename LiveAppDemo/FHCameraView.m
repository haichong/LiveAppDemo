//
//  FHCameraView.m
//  LiveAppDemo
//
//  Created by FuHang on 2016/11/2.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHCameraView.h"

@implementation FHCameraView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self = [[[NSBundle mainBundle] loadNibNamed:@"FHCameraView" owner:self options:nil] objectAtIndex:0];
    if (self) {
        self.frame = frame;
    }
    return self;
}

@end
