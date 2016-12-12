//
//  FHLiveTableViewCell.m
//  LiveAppDemo
//
//  Created by FuHang on 16/10/11.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHLiveTableViewCell.h"
#import "FHLiveModel.h"
#import <UIImageView+WebCache.h>

@implementation FHLiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImage.layer.borderColor = [UIColor purpleColor].CGColor;
    self.iconImage.layer.borderWidth = 1.5f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setPlayerModel:(FHLiveModel *)playerModel
{
    _playerModel = playerModel;
    
    // 用户名
    _nameLabel.text = playerModel.name;
    
    // 用户所在城市
    if ([playerModel.city isEqualToString:@""]) {
        _address.text =@"难道在火星?";
    }else{
        _address.text = playerModel.city;
    }
    
    // 用户Image
    if (![playerModel.portrait containsString:@"http://img2.inke.cn"]) {
        playerModel.portrait = [NSString stringWithFormat:@"http://img2.inke.cn/%@",playerModel.portrait];
    }
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:playerModel.portrait]];
    [_coverImage sd_setImageWithURL:[NSURL URLWithString:playerModel.portrait]];
    
    // 观看人数
    _peopleNumber.text = [NSString stringWithFormat:@"%d",playerModel.online_users];
    
    
    
}
@end
