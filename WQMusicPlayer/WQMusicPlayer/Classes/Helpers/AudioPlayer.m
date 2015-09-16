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

@property(nonatomic,strong)AVPlayer * player;

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
    [self.player play];
}
    

- (void)pause{
    
}

-(void)seekToTime:(float)time{
    
}

- (void)setPrepareMusicWithURL:(NSString*)urlStr{
//    if (self.player.currentItem) {
//        [self.player.currentItem removeObserver:self forKeyPath:@"status"];
//    }
    //创建一个item资源
    AVPlayerItem * item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
//    [item addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [self play];
}

#pragma mark --lazy load--
-(AVPlayer *)player{
    if (_player == nil) {
        _player = [AVPlayer new];
    }
    return _player;
}




@end
