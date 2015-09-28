//
//  TItleCell.m
//  WQNews
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "TItleCell.h"
#import "UIImageView+WebCache.h"

@implementation TItleCell

- (void)awakeFromNib {
    // Initialization code
}


//赋值
- (void)setCellWithTitleItem:(TouTiaoNews *)titleModel{
    self.titleModel = titleModel;
    [self.imgView4Title sd_setImageWithURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",titleModel.pic]] ];
    self.lable4Title.text = titleModel.name ;
    self.lable4Intro.text = titleModel.shortIntro;
    [self.button4Choose setTitle:@"订阅" forState:UIControlStateNormal];
}

- (IBAction)subscription4YorLiking:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"订阅"]) {
        [sender setTitle:@"取消订阅" forState:UIControlStateNormal];
        
     NSString * str  =   self.titleModel.name;
        NSLog(@"%@",str);
        
        
    }else if ([sender.titleLabel.text isEqualToString:@"取消订阅"]){
        [sender setTitle:@"订阅" forState:UIControlStateNormal];
        
        
    }
    
    
    
}

#pragma mark --lazy load---
- (NSMutableArray *)subscriptionArray{
    if (_subscriptionArray == nil) {
        _subscriptionArray = [NSMutableArray array];
    }
    return _subscriptionArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
