//
//  LyricModel.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "LyricModel.h"

@implementation LyricModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"异常的key:%@",key);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"lyric:%@", _lyricStr];
}

- (instancetype)initWithTime:(float)time LyricStr:(NSString *)lyricStr{
    self.lyricStr = lyricStr;
    self.time = time;
    return self;
}

+ (LyricModel *)lyricWithTime:(float)time LyricStr:(NSString *)lyricStr{
    return [[LyricModel alloc]initWithTime:time LyricStr:lyricStr];
}



@end
