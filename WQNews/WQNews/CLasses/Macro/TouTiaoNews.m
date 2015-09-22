//
//  TouTiaoNews.m
//  WQNews
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "TouTiaoNews.h"

@implementation TouTiaoNews

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
    NSLog(@"异常的key:%@",key);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _title];
}



@end
