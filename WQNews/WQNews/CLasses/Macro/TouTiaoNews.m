//
//  TouTiaoNews.m
//  WQNews
//
//  Created by QWQ on 15/9/22.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "TouTiaoNews.h"

@implementation TouTiaoNews

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }

}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _title];
}



@end
