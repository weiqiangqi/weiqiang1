//
//  MusicHelp.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MusicHelp.h"


@implementation MusicHelp

+ (MusicHelp*)shareMusicHelp{
    static MusicHelp * manager = nil;
   
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [MusicHelp new];
            
        });
    return  manager;
}
//括号里面是类型void (^)()
- (void)requestAllMusicWithFinish:(void (^)())result{
    //进入子线程进行数据请求,数据解析
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray * array = [NSArray arrayWithContentsOfURL:[NSURL URLWithString:kMusiclist]];
        //解析数据
        for (NSDictionary * dict in array) {
            MusicItem * item = [MusicItem new];
            [item setValuesForKeysWithDictionary:dict];
            [self.mutArray addObject:item];
        }
        //数据请求解析完成之后到主线程去执行block
            dispatch_async(dispatch_get_main_queue(), ^{
        //这个是调用block
        result();
    });
    });
}
- (MusicItem *)itemWithIndex:(NSInteger)index{
    return self.mutArray[index];
}







#pragma mark -- lazy load--

- (NSMutableArray *)mutArray{
    if (nil == _mutArray) {
        _mutArray = [NSMutableArray array];
    }
    return _mutArray;
}














@end
