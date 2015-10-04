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
@property(nonatomic,strong)AVPlayerItem * item;
//
@property(nonatomic,strong)AVPlayerLayer * videoLayer;

@property(nonatomic,strong)NSString  * URLStr;

@property(nonatomic,strong) NSString * outStr;
@end

@implementation PlayerHelper


+ (PlayerHelper *)shareVideoPlayer{
    static PlayerHelper * videoPlayer = nil;
    if (videoPlayer == nil) {
        videoPlayer = [PlayerHelper new];
    }
    
    
    return videoPlayer;
}
#pragma mark --外界控制的事件--
- (void)videoPause{
    [self.Player pause];
    [self backAction];
}

//重写初始化方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        //通知中心
        [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(endAction) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
    return self;
}


#pragma mark ---创建播放Item--
- (void)setVideoWithURLStr:(NSString *)urlStr{
    _outStr = urlStr;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //如果之前播过就接着播
    if ([_URLStr isEqualToString:urlStr] ) {
        
        [self.Player play];
        return ;
    }
    _item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    [self.Player replaceCurrentItemWithPlayerItem:_item];
    [self.Player play];
    
    _videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.Player];
    _videoLayer.frame = CGRectMake(0 , 40, kScreenWidth, kScreenHeight - 40);
    _videoLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.backgroundColor = [UIColor blackColor];
    
    [_videoLayer player];
    [self.layer addSublayer:_videoLayer];
    self.URLStr = urlStr;
    [self drawHeader];
    
}

- (void)endAction{
    [self.Player pause];
    [self.Player seekToTime:CMTimeMakeWithSeconds(0, self.Player.currentTime.timescale)];
     [self backAction];
}


//绘制表头
- (void)drawHeader{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    
    UIButton * backbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    backbutton.frame = CGRectMake(5, 15, 30, 20);
    
    [backbutton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbutton];
    [self addSubview:view];
    //全屏按钮
    UIButton * allButton = [UIButton buttonWithType:UIButtonTypeSystem];
    allButton.frame = CGRectMake(kScreenWidth - 35, 10, 30, 30);
    [allButton setImage:[UIImage imageNamed:@"allScreen"] forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(changeScreen:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:allButton];
}
//全屏按钮事件
- (void)changeScreen:(UIButton *)button{
    if ([_videoLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspect]) {
        _videoLayer.videoGravity =  AVLayerVideoGravityResizeAspectFill;
            [button setImage:[UIImage imageNamed:@"backScreen"] forState:UIControlStateNormal];
    }else{
        _videoLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                    [button setImage:[UIImage imageNamed:@"allScreen"] forState:UIControlStateNormal];
    }
    
    
}

//返回按钮事件
- (void)backAction{
    [self  removeFromSuperview];
    [self.Player pause];
}

#pragma mark --lazy load---
- (AVPlayer *)Player{
    if (_Player == nil) {
        _Player = [AVPlayer new];
    }
    return _Player;
}

//- (AVPlayerItem *)item{
//    if (_item == nil) {
//        _item = [[AVPlayerItem alloc]init];
//    }
//    return _item;
//}





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
