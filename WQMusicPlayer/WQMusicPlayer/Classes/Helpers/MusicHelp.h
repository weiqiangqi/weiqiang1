//
//  MusicHelp.h
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MusicItem.h"

@interface MusicHelp : NSObject

@property(nonatomic,strong)NSMutableArray * mutArray;


+ (MusicHelp*)shareMusicHelp;

- (MusicItem *)itemWithIndex:(NSInteger)index;

- (void)requestAllMusicWithFinish:(void (^)())result;


@end
