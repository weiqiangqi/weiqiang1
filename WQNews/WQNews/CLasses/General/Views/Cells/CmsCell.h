//
//  CmsCell.h
//  WQNews
//
//  Created by QWQ on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"

@interface CmsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Image;
@property (weak, nonatomic) IBOutlet UILabel *label4Titel;
@property (weak, nonatomic) IBOutlet UILabel *label4intro;
@property (weak, nonatomic) IBOutlet UILabel *label4comment;

//赋值的方法
- (void)setCellWithToutiaoNewsItem:(TouTiaoNews *)newsItem;




@end
