//
//  TouTiaoNews.h
//  WQNews
//
//  Created by lanou3g on 15/9/22.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TouTiaoNews : NSObject

@property(nonatomic,strong)NSString * ID;
@property(nonatomic,strong)NSString * title;
@property(nonatomic,strong)NSString * long_title;
@property(nonatomic,strong)NSString * source;
@property(nonatomic,strong)NSString * link;
@property(nonatomic,strong)NSString * pic;
@property(nonatomic,strong)NSString * kpic;
@property(nonatomic,strong)NSString * bpic;
@property(nonatomic,strong)NSString * intro;
@property(nonatomic,strong)NSString * pubDate;
@property(nonatomic,strong)NSString * comments;
@property(nonatomic,strong)NSDictionary * pics;
@property(nonatomic,strong)NSString * feedShowStyle;
@property(nonatomic,strong)NSString * category;
@property(nonatomic,strong)NSString * is_focus;
@property(nonatomic,strong)NSString * comment;
@property(nonatomic,strong)NSDictionary * comment_count_info;

//编辑是需要的额外加的属性
@property(nonatomic,strong)NSString * shortIntro;
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSString * name;



@end
