//
//  PlayerHelper.h
//  WQNews
//
//  Created by QWQ on 15/9/25.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PlayerHelper;
@interface PlayerHelper : UIView

+ (PlayerHelper *)shareVideoPlayer;

- (void)setVideoWithURLStr:(NSString *)urlStr;

- (void)videoPause;

@end
