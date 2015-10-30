//
//  DataManager.m
//  WQNews
//
//  Created by QWQ on 15/10/17.
//  Copyright © 2015年 齐伟强. All rights reserved.
//

#import "DataManager.h"
#import <FMDB.h>
#import "HLoverModel.h"


@implementation DataManager
static FMDatabase * db= nil;

+ (DataManager *)shareDataManager{
    static DataManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc]init];

        db = [FMDatabase databaseWithPath:kDataPath];
    });
    return manager;
}

//创建表
- (BOOL)creatTableWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url type:(NSString*)type{
    BOOL state = NO;
    if (![db open]) {
        return NO;
    }
    
    if (![self istableExistWithTableNAme:tableName]) {
        NSString * sqlStr = [NSString stringWithFormat:@"create table %@ (%@ text primary key, %@ text deafault '',%@ text deafault '',%@ text deafault '')",tableName,mainKey,title,url,type];
        state = [db executeStatements:sqlStr];
    }
    [db close];
    return state;
}


//判断表是否存在事件
- (BOOL)istableExistWithTableNAme:(NSString *)tableName{
    if (![db open]) {
        return NO;
    }
    FMResultSet * set = [db executeQuery:@"select count(*) as count from sqlite_master where type = 'table' and name = ?",tableName];
    if ([set next]) {
        NSInteger count = [set intForColumn:@"count"];
        if (count == 0) {
            
            return NO;
        }
        
        return YES;
    }
   
    return YES;
}
//向表中插入数据
- (BOOL)InsertIntoTableName:(NSString *)tableName WithMainKey:(NSString *)mainKey title:(NSString *)title URL:(NSString *)url type:(NSString*)type{
    if (![db open]) {
        return  NO;
    }
    BOOL  result = NO;
    NSString * sqlStr = [NSString stringWithFormat:@"insert into %@ (%@,%@,%@,%@) values('%@','%@','%@','%@')",tableName,kLoverKey,kLoverTitle,kLoverURL,kLoverType,mainKey,title,url,type];
    
    result = [db executeUpdate:sqlStr];
    if (result) {
        NSLog(@"收藏成功了");
    }else{
        NSLog(@"失败");
    }
    [db close];
    return result;
}

//删除所有数据
- (BOOL)clearAllDataTableName:(NSString*)tableName{
    if (![db open]) {
        return NO;
    }
    NSString * sqlStr = [NSString stringWithFormat:@"delete from %@",tableName];
    if ([db executeUpdate:sqlStr]) {
        NSLog(@"删除表成功");
        [db close];
        return YES;
    }else{
        NSLog(@"删除失败");
        [db close];
        return NO;
    }
}

//根据网址清除收藏项
- (BOOL)clearTableCollectWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey{
    if ([db open]) {
        return NO;
    }
    BOOL result = NO;
    NSString * sqlStr = [NSString stringWithFormat:@"delete frome %@ where %@ = '%@'",tableName,kLoverKey,mainKey];
    result = [db executeUpdate:sqlStr];
    if (result) {
        NSLog(@"删除那条数据成功");
    }else{
        NSLog(@"失败");
    }
    
    return result;
}

//查询所有数据
- (NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName mainKey:(NSString *)mainKey title:(NSString *)title URl:(NSString *)url type:(NSString*)type{
    if (![db open]) {
        return nil;
    }
    NSMutableArray * mutArray = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@" ,tableName];
    FMResultSet *resultSet = [db executeQuery:sql];
    while ([resultSet next]) {
        HLoverModel * model = [HLoverModel new];
        model.title = [resultSet stringForColumn:title];
        model.picUrl = [resultSet stringForColumn:url];
        model.ID =  [resultSet stringForColumn:mainKey];
        model.type = [resultSet stringForColumn:type];
        [mutArray addObject:model];
    }
    [db close];
    return mutArray;
}
//根据mainKey查询数据长度
- (NSInteger)selectLengthOfMainKey:(NSString *)mainKey fromTable:(NSString *)tableName{
    if (![db open]) {
        return 0;
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ where %@ = '%@'" ,kLoverTitle,tableName,kLoverKey,mainKey];
    FMResultSet * result = [db executeQuery:sql];
    while ([result next]){
        NSString * str = [result stringForColumn:kLoverTitle];
        return str.length;
    }
    return 0;
}



@end
