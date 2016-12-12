//
//  FHLiveModel.m
//  LiveAppDemo
//
//  Created by FuHang on 16/10/11.
//  Copyright © 2016年 fuhang. All rights reserved.
//

#import "FHLiveModel.h"

@implementation FHLiveModel


- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}
@end
