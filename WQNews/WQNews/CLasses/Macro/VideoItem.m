//
//  VideoItem.m
//  WQNews
//
//  Created by QWQ on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "VideoItem.h"

@implementation VideoItem

//KVC赋值
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
}
//重写打印方法
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _title];
}

@end
