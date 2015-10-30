//
//  HdpicPictures.h
//  WQNews
//
//  Created by QWQ on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HdpicPictures : NSObject


@property(nonatomic,strong)NSString * ID;
//标题
@property(nonatomic,strong)NSString * title;
//长标题
@property(nonatomic,strong)NSString * long_title;
//来源
@property(nonatomic,strong)NSString * source;
//链接
@property(nonatomic,strong)NSString * link;
//小照片链接
@property(nonatomic,strong)NSString * pic;
//大照片链接
@property(nonatomic,strong)NSString * kpic;
//未知
@property(nonatomic,strong)NSString * bpic;
//简介
@property(nonatomic,strong)NSString * intro;
//未知
@property(nonatomic,strong)NSString * pubDate;
//未知
@property(nonatomic,strong)NSString * comments;
//照片组合
@property(nonatomic,strong)NSDictionary * pics;
//未知
@property(nonatomic,strong)NSString * feedShowStyle;
//类型
@property(nonatomic,strong)NSString * category;
//类型
@property(nonatomic,strong)NSString * comment;
//评论
@property(nonatomic,strong)NSDictionary * comment_count_info;




@end
