//
//  AppDelegate.h
//  Wobo_lian
//
//  Created by lanou3g on 15/9/11.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyController.h"

@interface AppDelegate : UIResponder 

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;

@property(strong,nonatomic)NSString * wbCurrentUserID;

@property(strong,nonatomic)NSString * wbRefrenshToken;

@property(strong,nonatomic)MyController * viewController;




@end

