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
        if ( self.likingArray.count >= 4) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"你兴趣真的很广" message:@"超过了最大订阅量,\n其余的将不能展示" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
            [alert show];
            return;
        }
       
        [sender setTitle:@"取消订阅" forState:UIControlStateNormal];

        [ self.likingArray addObject:self.titleModel];

    }else if ([sender.titleLabel.text isEqualToString:@"取消订阅"]){
        [sender setTitle:@"订阅" forState:UIControlStateNormal];
        for (int  i = 0; i < self.likingArray.count; i ++) {
            if (self.likingArray.count < 3) {
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你换可以接着选" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] ;
                [alert show];
                
            }
            
            TouTiaoNews * item = self.likingArray[i];
            if ([item.name isEqualToString:self.titleModel.name]) {
                [self.likingArray removeObjectAtIndex:i];
            }
        }
    }
    [self chooseYourItem];
}

- (void)chooseYourItem{
    
    NSLog(@"%@",self.likingArray);

    
}


#pragma mark --lazy load---
- (NSMutableArray *)likingArray{
    if (_likingArray == nil) {
        _likingArray = [NSMutableArray array];
    }
    return _likingArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
