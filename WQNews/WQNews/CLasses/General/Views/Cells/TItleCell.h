//
//  TItleCell.h
//  WQNews
//
//  Created by QWQ on 15/9/28.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"
#import "NewsListItem.h"

@interface TItleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Title;

@property (weak, nonatomic) IBOutlet UILabel *lable4Intro;


@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

@property (weak, nonatomic) IBOutlet UILabel *lable4Choose;




//@property(nonatomic,strong)TouTiaoNews * titleModel;
////存储感兴趣的数组
//@property(nonatomic,strong)NSMutableArray * likingArray;

//赋值方法
- (void)setCellWithTitleItem:(NewsListItem *)titleModel;






@end
