//
//  FHLiveTableViewCell.h
//  LiveAppDemo
//
//  Created by FuHang on 16/10/11.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FHLiveModel;

@interface FHLiveTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *iconImage; // 用户头像
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; // 用户姓名
@property (weak, nonatomic) IBOutlet UILabel *address; // 用户地址
@property (weak, nonatomic) IBOutlet UILabel *peopleNumber; // 观看人数
@property (weak, nonatomic) IBOutlet UIImageView *coverImage; // 封面

@property (nonatomic, strong)FHLiveModel * playerModel;

@end
