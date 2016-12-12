//
//  FHLiveModel.h
//  LiveAppDemo
//
//  Created by FuHang on 16/10/11.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHLiveModel : NSObject

@property (nonatomic, strong)NSString * ID;

@property (nonatomic, strong)NSString * city;

@property (nonatomic, strong)NSString * name;

@property (nonatomic, strong)NSString * portrait;

@property (nonatomic, assign)int  online_users;

@property (nonatomic, strong)NSString * url;
- (id)initWithDictionary:(NSDictionary *)dic;
@end
