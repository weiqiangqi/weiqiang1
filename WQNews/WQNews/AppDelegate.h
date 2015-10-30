//
//  AppDelegate.h
//  WQNews
//
//  Created by QWQ on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WeiboSDK.h"
#import <AVOSCloud/AVOSCloud.h>

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

@property(nonatomic,strong)NSString * sinaURL;




- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

