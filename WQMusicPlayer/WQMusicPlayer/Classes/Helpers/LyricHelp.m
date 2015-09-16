//
//  LyricHelp.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "LyricHelp.h"
#import "LyricModel.h"

@interface LyricHelp ()

@property(nonatomic,strong)NSMutableArray * mutArray;

@property(nonatomic,assign)NSInteger index;

@end

@implementation LyricHelp

+ (LyricHelp *)shareLyric{
    static LyricHelp * helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [LyricHelp new];
    });
    return helper;
}

- (void)initWithLyricString:(NSString  *)lyricStr{
    _index = -1;
    [self.mutArray removeAllObjects];
  NSArray * itemArray =   [lyricStr componentsSeparatedByString:@"\n"];
    for (NSString * itemStr in itemArray) {
       NSArray * lyicArray = [itemStr componentsSeparatedByString:@"]"];
        if ([lyicArray.firstObject length] < 1) {
            return;
        }
        NSString * timeStr =  [lyicArray.firstObject substringFromIndex:1];
        NSArray * timeArray =  [timeStr componentsSeparatedByString:@":"];
        float  time = [timeArray.firstObject integerValue] * 60 + [timeArray.lastObject integerValue];
        //创建歌词对象
        LyricModel * lyModel = [LyricModel  lyricWithTime:time LyricStr:lyicArray.lastObject];
        [self.mutArray addObject:lyModel];
    }

    
    
    

//    for (int i = 0; i < itemArray.count; i ++) {
//     NSArray * tempArray =   [itemArray[i] componentsSeparatedByString:@"]"];
//        if ([tempArray.firstObject length] < 1) {
//            return ;
//        }
//      NSString * timeStr =  [tempArray.firstObject substringFromIndex:1];
//     NSArray * timeArray =  [timeStr componentsSeparatedByString:@":"];
//        float  time = [timeArray.firstObject integerValue] * 60 + [timeArray.lastObject integerValue];
//        LyricModel * lyModel = [LyricModel  lyricWithTime:time LyricStr:itemArray.lastObject];
//        [self.mutArray addObject:lyModel];
//    }
//        }
}
//根据给定的时间确定歌词虽在的行
- (NSInteger)getIndexWithTime:(float)time{
    for (int i = 0; i < self.mutArray.count; i ++) {
        LyricModel * lyricItem = self.mutArray[i];
        if (lyricItem.time > time) {
            _index = (i - 1 > 0 ? i - 1 :0);
           break;
        }
    }
    return  _index;
}

#pragma mark -- 数组初始化

- (NSMutableArray *)mutArray{
    if (_mutArray ==nil) {
        _mutArray = [NSMutableArray new];
    }
    return _mutArray;
}

- (NSArray *)lyricArray{
    return [self.mutArray mutableCopy];
}
@end
