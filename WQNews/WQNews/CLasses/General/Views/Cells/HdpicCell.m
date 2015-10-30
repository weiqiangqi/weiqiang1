//
//  HdpicCell.m
//  WQNews
//
//  Created by QWQ on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "HdpicCell.h"
#import "UIImageView+WebCache.h"

@implementation HdpicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//赋值
- (void)setCellWithToutiaoNewsItem:(TouTiaoNews *)newsItem{
    self.lable4Title.text = newsItem.title;
    NSDictionary * picsDict = [NSDictionary new];
       picsDict = newsItem.pics;
    NSArray * picsArray = [NSArray array];
   picsArray = picsDict[@"list"];
    NSMutableArray * URLStrArray = [[NSMutableArray alloc]initWithCapacity:8];
    for ( int i = 0; i < 3; i ++) {
        NSDictionary * dict = [NSDictionary new];
         dict = picsArray[i];
        NSString * URLStr = dict[@"kpic"];
        [URLStrArray addObject:URLStr];
    }
    [self.imgView4First sd_setImageWithURL:[NSURL URLWithString:URLStrArray[0]]];
    [self.imagView4Second sd_setImageWithURL:[NSURL URLWithString:URLStrArray[1]]];
    [self.imgView4Third sd_setImageWithURL:[NSURL URLWithString:URLStrArray[2]]];
    
}



@end
