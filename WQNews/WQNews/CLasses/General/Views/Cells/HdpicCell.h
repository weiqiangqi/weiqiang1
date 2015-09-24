//
//  HdpicCell.h
//  WQNews
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"

@interface HdpicCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4First;

@property (weak, nonatomic) IBOutlet UIImageView *imagView4Second;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Third;

- (void)setCellWithToutiaoNewsItem:(TouTiaoNews *)newsItem;


@end
