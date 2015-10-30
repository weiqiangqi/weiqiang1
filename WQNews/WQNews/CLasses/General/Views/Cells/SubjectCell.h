//
//  SubjectCell.h
//  WQNews
//
//  Created by QWQ on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"

@interface SubjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView4image;
@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

@property (weak, nonatomic) IBOutlet UILabel *lable4intro;
@property (weak, nonatomic) IBOutlet UILabel *lable4comment;
@property (weak, nonatomic) IBOutlet UILabel *lable4category;

- (void)setCellWithToutiaoNewsItem:(TouTiaoNews *)newsItem;




@end
