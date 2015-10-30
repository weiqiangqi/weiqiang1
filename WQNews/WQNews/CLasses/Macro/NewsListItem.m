//
//  NewsListItem.m
//  WQNews
//
//  Created by QWQ on 15/9/21.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "NewsListItem.h"

@implementation NewsListItem


//KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _ID = value;
    }
   
}

//打印
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _name];
}



@end
