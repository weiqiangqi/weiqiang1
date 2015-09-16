//
//  AudioPlayer.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/16.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AudioPlayer;

@interface AudioPlayer : NSObject

+ (AudioPlayer*)sharePlayer;

- (void)play;

- (void)pause;

-(void)seekToTime:(float)time;

- (void)setPrepareMusicWithURL:(NSString*)urlStr;


@end
