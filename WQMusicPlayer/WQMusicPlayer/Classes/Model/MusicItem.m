//
//  MusicItem.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MusicItem.h"

@implementation MusicItem

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _mut_id = value;
    }else{
        NSLog(@"异常的key:%@",key);
    }
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"歌手名:%@,歌曲名%@", _singer,_name];
}

@end
