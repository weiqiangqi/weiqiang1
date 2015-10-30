//
//  Picture2PictCell.h
//  WQNews
//
//  Created by QWQ on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HdpicPictures.h"

@interface Picture2PictCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4First;
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Second;
@property (weak, nonatomic) IBOutlet UILabel *lable4Title;
@property (weak, nonatomic) IBOutlet UILabel *lable4intro;
@property (weak, nonatomic) IBOutlet UILabel *lable4comment;

- (void)setCellWithPicturesItem:(HdpicPictures *)picturesItem;




@end
