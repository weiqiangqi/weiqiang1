//
//  Pictures4PictCell.h
//  WQNews
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HdpicPictures.h"

@interface Pictures4PictCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4First;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Second;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Third;

@property (weak, nonatomic) IBOutlet UIImageView *imgView4Fourth;
@property (weak, nonatomic) IBOutlet UILabel *lable4Title;

@property (weak, nonatomic) IBOutlet UILabel *lable4intro;

@property (weak, nonatomic) IBOutlet UILabel *lable4Comment;

- (void)setCellWithPicturesItem:(HdpicPictures *)picturesItem;


@end
