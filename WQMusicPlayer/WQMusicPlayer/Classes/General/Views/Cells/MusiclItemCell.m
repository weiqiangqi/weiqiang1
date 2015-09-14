//
//  MusiclItemCell.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MusiclItemCell.h"
#import "UIImageView+WebCache.h"

@implementation MusiclItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}
- (void)setModel:(MusicItem *)model{
    self.label4SingerName.text = model.singer;
    self.lable4songs.text = model.name;
    [self.imgView4Picture sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"b.jpeg"]];
}


    



@end
