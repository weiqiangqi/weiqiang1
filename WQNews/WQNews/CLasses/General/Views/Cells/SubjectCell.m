//
//  SubjectCell.m
//  WQNews
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "SubjectCell.h"
#import "UIImageView+WebCache.h"

@implementation SubjectCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}
//对cell进行赋值
- (void)setCellWithNewsListItem:(TouTiaoNews *)newsItem{
    [self.imgView4image sd_setImageWithURL: [NSURL URLWithString:newsItem.pic]];
    self.lable4Title.text = newsItem.title;
    self.lable4Title.font = [UIFont systemFontOfSize:15];
    self.lable4intro.text = newsItem.intro;
    self.lable4intro.font = [UIFont systemFontOfSize:10];
    NSString * conmentStr = [NSString stringWithFormat:@"%@评论",newsItem.comment];
    self.lable4comment.text = conmentStr;
    self.lable4comment.font = [UIFont systemFontOfSize:9];
}

@end
