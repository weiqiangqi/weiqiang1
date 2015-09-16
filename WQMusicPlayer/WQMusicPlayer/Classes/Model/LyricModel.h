//
//  LyricModel.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricModel : NSObject
@property(nonatomic,strong)NSString * lyricStr;
@property(nonatomic,assign)float  time;

- (instancetype)initWithTime:(float)time LyricStr:(NSString *)lyricStr;

+ (LyricModel *)lyricWithTime:(float)time LyricStr:(NSString *)lyricStr;

@end
