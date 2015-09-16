//
//  PlayingController.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/15.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingController : UIViewController
//视图上的方法与属性
@property (weak, nonatomic) IBOutlet UIImageView *img4Picture;
@property (weak, nonatomic) IBOutlet UILabel *label4PlayedTime;

@property (weak, nonatomic) IBOutlet UILabel *label4LastrTime;

@property (weak, nonatomic) IBOutlet UISlider *slider4Playing;



- (IBAction)buttont4StartAndPause:(UIButton *)sender;

- (IBAction)button4NextAction:(UIButton *)sender;
- (IBAction)back4ListVC:(UIBarButtonItem *)sender;

- (IBAction)button4PreviorAction:(UIButton *)sender;



//自己写的方法
@property(nonatomic,assign)NSInteger  index;

+ (PlayingController *)sharePlayingController;
- (void)startPlay;



@end






