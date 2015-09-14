//
//  MusiclItemCell.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicItem.h"

@interface MusiclItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView4Picture;
@property (weak, nonatomic) IBOutlet UILabel *lable4songs;

@property (weak, nonatomic) IBOutlet UILabel *label4SingerName;

@property(nonatomic,strong)MusicItem * model;










@end
