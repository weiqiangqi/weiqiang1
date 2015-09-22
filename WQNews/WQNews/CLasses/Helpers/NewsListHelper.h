//
//  NewsListHelper.h
//  WQNews
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListHelper : NSObject

@property(nonatomic,strong)NSArray * newsAray;
@property(nonatomic,strong)NSArray * hdpicArray;
@property(nonatomic,strong)NSArray * videoArray;



+ (NewsListHelper *)shareNewsListHerlper;
- (void)getAllURL;




@end
