//
//  AudioPlayer.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "AudioPlayer.h"
@import AVFoundation;

@interface AudioPlayer ()
{
    BOOL _isPrepare;
    BOOL _isPlaying;
}
@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,strong)NSTimer * timer;

@end

@implementation AudioPlayer

+ (AudioPlayer *)sharePlayer{
    static AudioPlayer * player = nil;
    if (player == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            player = [AudioPlayer new];
        });
    }
    return player;
}


- (void)play{
    if (!_isPrepare) {
        return;
    }
    [self.player play];
    _isPlaying = YES;
    if (_timer) {
        return;
    }
    //创建一个timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(playAction:) userInfo:nil repeats:YES];
    
}
//初始化方法里面添加通知中心
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endAction:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        
    }
    return self;
}



- (void)pause{
    if (!_isPrepare) {
        return;
    }
    [self.player pause];
    _isPlaying = NO;
    [_timer invalidate];
    _timer = nil;
}

-(void)seekToTime:(float)time{
    [self pause];
    [self.player seekToTime:CMTimeMakeWithSeconds(time, self.player.currentTime.timescale) completionHandler:^(BOOL finished) {
        if (finished) {
            [self play];
            
        }
    }];
}

- (void)setPrepareMusicWithURL:(NSString*)urlStr{
    if (self.player.currentItem) {
        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    }
    //创建一个item资源
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    

}
#pragma mark --设计代理方法---
//每0.1秒执行的方法
- (void)playAction:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(audioPlayerPlayingWith:Progress:)]) {
        
        float progress = 1.0 * self.player.currentTime.value / self.player.currentTime.timescale;
        [self.delegate audioPlayerPlayingWith:self Progress:progress];
        
    }
}

//歌曲播放完会执行这个方法
- (void)endAction:(NSNotification *)notification{
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(audioPlayerDidfinishItem:)]) {
        [self.delegate audioPlayerDidfinishItem:self];
    }
    
}


//观察者事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerStatus status = [change[@"new"] integerValue];
    switch (status) {
        case AVPlayerStatusReadyToPlay:
            _isPrepare = YES;
            [self play];
            break;
        case AVPlayerStatusFailed:
            _isPrepare = NO;
            NSLog(@"加载失败");
            break;
        case AVPlayerStatusUnknown:
            _isPrepare = NO;
            NSLog(@"资源找不到");
            break;
            
        default:
            break;
    }
    NSLog(@"change:%@",change);
    
}



#pragma mark --lazy load--
-(AVPlayer *)player{
    if (_player == nil) {
        _player = [AVPlayer new];
    }
    return _player;
}

- (BOOL)isPlaying{
    return _isPlaying;
}


@end
