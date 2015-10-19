//
//  DataManager.h
//  WQNews
//
//  Created by lanou3g on 15/10/17.
//  Copyright © 2015年 齐伟强. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DataManager;
@interface DataManager : NSObject
+ (DataManager *)shareDataManager;

//创建图表
- (BOOL)creatTableWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url type:(NSString*)type;

//向表中插入数据
- (BOOL)InsertIntoTableName:(NSString *)tableName WithMainKey:(NSString *)mainKey title:(NSString *)title URL:(NSString *)url type:(NSString*)type;
//删除所有数据
- (BOOL)clearAllDataTableName:(NSString*)tableName;

//根据网址清楚收藏项
- (BOOL)clearTableCollectWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey;

//查询所有数据
- (NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url type:(NSString*)type;

//根据mainKey查询数据长度
- (NSInteger)selectLengthOfMainKey:(NSString *)mainKey fromTable:(NSString *)tableName;


@end
