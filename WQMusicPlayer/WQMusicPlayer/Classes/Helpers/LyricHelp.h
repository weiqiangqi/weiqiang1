//
//  LyricHelp.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LyricHelp : NSObject

@property(nonatomic,strong)NSArray * lyricArray;

+ (LyricHelp *)shareLyric;

- (void)initWithLyricString:(NSString  *)lyricStr;

//根据时间确定目前歌词所在的位置
- (NSInteger)getIndexWithTime:(float)time;

@end
