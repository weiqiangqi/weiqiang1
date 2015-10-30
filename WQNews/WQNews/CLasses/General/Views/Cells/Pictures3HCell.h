//
//  Pictures3HCell.h
//  WQNews
//
//  Created by QWQ on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HdpicPictures.h"


@interface Pictures3HCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4topImage;

@property (weak, nonatomic) IBOutlet UIImageView *imgView4LeftImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Right;

@property (weak, nonatomic) IBOutlet UILabel *lable4Title;
@property (weak, nonatomic) IBOutlet UILabel *lable4Comment;

@property (weak, nonatomic) IBOutlet UILabel *lable4intro;

- (void)setCellWithPicturesItem:(HdpicPictures *)picturesItem;


@end
