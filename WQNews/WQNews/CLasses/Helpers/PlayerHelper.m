//
//  PlayerHelper.m
//  WQNews
//
//  Created by lanou3g on 15/9/25.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "PlayerHelper.h"
@import AVFoundation;

@interface PlayerHelper ()

@property(nonatomic,strong)AVPlayer * Player;

@end

@implementation PlayerHelper


+ (PlayerHelper *)shareVideoPlayer{
    static PlayerHelper * videoPlayer = nil;
    if (videoPlayer == nil) {
        videoPlayer = [PlayerHelper new];
    }
    
    
    return videoPlayer;
}

#pragma mark ---创建播放Item--
- (void)setVideoWithURLStr:(NSString *)urlStr{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    [self.Player replaceCurrentItemWithPlayerItem:item];
    [self.Player play];
    
    AVPlayerLayer * videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.Player];
    videoLayer.frame = CGRectMake(0 , 40, kScreenWidth, kScreenHeight - 40);
    self.backgroundColor = [UIColor blackColor];

    [videoLayer player];
    [self.layer addSublayer:videoLayer];
    
    [self drawHeader];
    
}

//绘制表头
- (void)drawHeader{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    UIButton * backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    backbutton.frame = CGRectMake(0, 12, 30, 16);
    [backbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:view];
}
//返回按钮事件
- (void)backAction{
    [self  removeFromSuperview];
}

#pragma mark --lazy load---
- (AVPlayer *)Player{
    if (_Player == nil) {
        _Player = [AVPlayer new];
    }
    return _Player;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
