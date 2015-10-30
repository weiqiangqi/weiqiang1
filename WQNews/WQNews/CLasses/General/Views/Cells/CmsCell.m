//
//  CmsCell.m
//  WQNews
//
//  Created by QWQ on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "CmsCell.h"
#import "UIImageView+WebCache.h"

@implementation CmsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setCellWithToutiaoNewsItem:(TouTiaoNews *)newsItem{
    [self.imgView4Image sd_setImageWithURL: [NSURL URLWithString:newsItem.pic]];
    self.label4Titel.text = newsItem.title;
    self.label4Titel.font = [UIFont systemFontOfSize:15];
    self.label4intro.text = newsItem.intro;
    self.label4intro.font = [UIFont systemFontOfSize:12];
    //获取评价数
    NSDictionary * commentDict =  newsItem.comment_count_info;
    NSString * totalStr = commentDict[@"total"];
    NSString * conmentStr = [NSString stringWithFormat:@"%@评论",totalStr];
    self.label4comment.text = conmentStr;
    self.label4comment.font = [UIFont systemFontOfSize:9];
}

@end
