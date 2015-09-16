//
//  AudioPlayer.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AudioPlayer;

@protocol AudioPlayerDelegate <NSObject>
//在播放中每秒都执行的事件
- (void)audioPlayerPlayingWith:(AudioPlayer *)audiopPlayer Progress:(float)progress;
//当一首歌播放完执行的方法
- (void)audioPlayerDidfinishItem:(AudioPlayer *)audioPlayer;

@end

@interface AudioPlayer : NSObject

@property(nonatomic,assign)id<AudioPlayerDelegate>  delegate;

@property(nonatomic,assign)BOOL isPlaying;

+ (AudioPlayer*)sharePlayer;

- (void)play;

- (void)pause;

-(void)seekToTime:(float)time;

- (void)setPrepareMusicWithURL:(NSString*)urlStr;


@end
