//
//  NewsListHelper.m
//  WQNews
//
//  Created by QWQ on 15/9/21.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "NewsListHelper.h"
#import "AFNetworking.h"
#import "NewsListItem.h"
#import "TouTiaoNews.h"

@interface NewsListHelper ()
//导航列表
@property (nonatomic,strong)NSMutableArray * mutArray;
//图像列表
@property(nonatomic,strong)NSMutableArray   * mutHdpicArray;
//视频列表
@property(nonatomic,strong)NSMutableArray * mutVideoArray;



@end

@implementation NewsListHelper

+ (NewsListHelper *)shareNewsListHerlper{
    static NewsListHelper * helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [NewsListHelper new];
    });
    
    return helper;
}

- (void)getAllURL:(void(^)())resultBlock{
    
    AFHTTPRequestOperationManager * myManager = [AFHTTPRequestOperationManager manager];
    
    
    [myManager GET:kAllURL parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        
        NSDictionary * dict =  result[@"data"];
        
        NSDictionary * listDict = dict[@"forced_sub"];
        NSArray * listArray = listDict[@"list"];
        
        NSDictionary * groupDict = dict[@"groups"];
        NSDictionary * hdpicDict1 = groupDict[@"hdpic2"];
        NSArray * hdpicArray1 = hdpicDict1[@"list"];
        
        NSDictionary * videoDict = groupDict[@"video2"];
        NSArray * VLArray = videoDict[@"list"];
        
        
        NSDictionary * chooseDict = groupDict[@"news2"];
        NSDictionary * headlinesDict = chooseDict[@"headlines"];
        NSArray * chooseArray = headlinesDict[@"list"];
        
        NSMutableArray * chMutArray = [[NSMutableArray alloc]initWithCapacity:25];
        for (NSDictionary * chDit in chooseArray) {
            NewsListItem * NewsItem = [NewsListItem new];
            [NewsItem setValuesForKeysWithDictionary:chDit];
            [chMutArray addObject:NewsItem];
        }
        self.chooseArray = [chMutArray mutableCopy];
        
        for (NSDictionary * dict1 in listArray) {
            NewsListItem * NewsItem = [NewsListItem new];
            [NewsItem setValuesForKeysWithDictionary:dict1];
            [self.mutArray addObject:NewsItem];
        }
        
        for (NSDictionary * hDict in hdpicArray1) {
            NewsListItem * newsItem = [NewsListItem new];
            [newsItem setValuesForKeysWithDictionary:hDict];
            [self.mutHdpicArray addObject:hDict];
        }
        for (NSDictionary * VLDict in VLArray) {
            NewsListItem * newsItem = [NewsListItem new];
            [newsItem setValuesForKeysWithDictionary:VLDict];
            [self.mutVideoArray addObject:newsItem];
        }
        
        
        
        resultBlock();
    } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"出错了,错误是:%@",error);
    }];
    
    
}

#pragma mark --lazy load----
- (NSArray *)chooseArray{
    if (_chooseArray == nil) {
        _chooseArray = [NSMutableArray array];
    }
    return _chooseArray;
}

- (NSMutableArray *)mutArray{
    if (_mutArray == nil) {
        _mutArray = [NSMutableArray new];
    }
    return _mutArray;
}
- (NSArray *)newsAray{
    return [_mutArray mutableCopy];
}
//图片列表
- (NSMutableArray *)mutHdpicArray{
    if (_mutHdpicArray == nil) {
        _mutHdpicArray = [NSMutableArray new];
    }
    return _mutHdpicArray;
}

- (NSArray *)hdpicArray{
    
    return [_mutHdpicArray mutableCopy];
}

//视频列表
- (NSMutableArray *)mutVideoArray{
    if (_mutVideoArray == nil) {
        _mutVideoArray = [NSMutableArray array];
    }
    return _mutVideoArray;
}

- (NSArray *)videoArray{
    return [_mutVideoArray mutableCopy];
}




@end
