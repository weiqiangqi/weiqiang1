//
//  Picture2PictCell.m
//  WQNews
//
//  Created by QWQ on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "Picture2PictCell.h"
#import "UIImageView+WebCache.h"

@implementation Picture2PictCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithPicturesItem:(HdpicPictures *)picturesItem{
    NSDictionary * picDict = picturesItem.pics;
    NSArray * picArray = picDict[@"list"];
    NSMutableArray * mutURLArray = [[NSMutableArray alloc]initWithCapacity:8];
    for (int i = 0; i < picArray.count; i ++) {
        NSDictionary  * modelDict = picArray[i];
        NSString * urlStr = modelDict[@"kpic"];
        [mutURLArray addObject:urlStr];
    }
    [self.imgView4First sd_setImageWithURL:[NSURL URLWithString:mutURLArray[0]]];
    [self.imgView4Second sd_setImageWithURL:[NSURL URLWithString:mutURLArray[1]]];
      self.lable4Title.text = picturesItem.title;
    self.lable4Title.font = [UIFont systemFontOfSize:15];
    self.lable4intro.text = picturesItem.intro;
    self.lable4intro.numberOfLines = 0;
    self.lable4intro.font = [UIFont systemFontOfSize:10];
    NSDictionary * commentDict = picturesItem.comment_count_info;
    NSString * total = commentDict[@"total"];
    NSString * commentStr = [NSString stringWithFormat:@"%@评论",total];
    self.lable4comment.text = commentStr;
    self.lable4comment.font = [UIFont systemFontOfSize:10];

    
    
}




@end
