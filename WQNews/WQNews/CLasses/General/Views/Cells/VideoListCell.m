//
//  VideoListCell.m
//  WQNews
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "VideoListCell.h"
#import "UIImageView+WebCache.h"


@implementation VideoListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//赋值
- (void)setCellWithVideoItem:(VideoItem *)videoItem{
    
    [self.imgView4video sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",videoItem.kpic]]];
    
    self.lable4Title.text = videoItem.title;
    NSDictionary * dict = videoItem.video_info;
    NSString * str = dict[@"playnumber"];
    NSString * commentStr = [NSString stringWithFormat:@"%@",str];
    self.lable4Comment.text = commentStr;
    
}

@end
