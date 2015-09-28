//
//  TItleCell.h
//  WQNews
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"

@interface TItleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Title;

@property (weak, nonatomic) IBOutlet UILabel *lable4Intro;


@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

@property (weak, nonatomic) IBOutlet UIButton *button4Choose;

@property(nonatomic,strong)TouTiaoNews * titleModel;
//存储感兴趣的数组
@property(nonatomic,strong)NSMutableArray * subscriptionArray;


//赋值方法
- (void)setCellWithTitleItem:(TouTiaoNews *)titleModel;

- (IBAction)subscription4YorLiking:(UIButton *)sender;




@end
