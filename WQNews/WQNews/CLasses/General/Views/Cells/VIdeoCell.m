//
//  VIdeoCell.m
//  WQNews
//
//  Created by QWQ on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "VIdeoCell.h"
#import "UIImageView+WebCache.h"

@implementation VIdeoCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithToutiaoNewsItem:(TouTiaoNews *)newsItem{
    [self.imgView4Video sd_setImageWithURL: [NSURL URLWithString:newsItem.pic]];
    self.lable4Title.text = newsItem.title;
    self.lable4Title.font = [UIFont systemFontOfSize:15];
    self.lable4intro.text = newsItem.intro;
    self.lable4intro.font = [UIFont systemFontOfSize:12];
    //获取评价数
    NSDictionary * commentDict =  newsItem.comment_count_info;
    NSString * totalStr = commentDict[@"total"];
    NSString * conmentStr = [NSString stringWithFormat:@"%@评论",totalStr];
    self.lable4comment.text = conmentStr;
    self.lable4comment.font = [UIFont systemFontOfSize:9];
}








@end
