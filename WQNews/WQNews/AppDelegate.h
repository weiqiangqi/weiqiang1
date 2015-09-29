//
//  AppDelegate.h
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WeiboSDK.h"

@class MyController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,strong)NSString * wbtoken;
@property(nonatomic,strong)NSString * wbRefreshToken;
@property(nonatomic,strong)NSString * webCurrentUserID;
@property(nonatomic,strong)MyController * myVC;

//https://api.weibo.com/2/users/show.json?access_token=2.00YOnjNGfDCb3E32a3340cf90inyGN&uid=5699803378



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

