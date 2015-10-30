//
//  VideoListCell.h
//  WQNews
//
//  Created by QWQ on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoItem.h"

@interface VideoListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView4video;
@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

@property (weak, nonatomic) IBOutlet UILabel *lable4Comment;

- (void)setCellWithVideoItem:(VideoItem *)videoItem;


@end
