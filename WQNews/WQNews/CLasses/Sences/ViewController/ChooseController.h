//
//  ChooseController.h
//  WQNews
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"

typedef void(^reload)(NSMutableArray * );

@interface ChooseController : UIViewController

@property(nonatomic,strong)NSArray * titleArray;

//- (void)backAction:(void(^)())reloadUI;

- (void)backToMainScreen:(reload)reloadUI;

@property(nonatomic,strong)NSMutableArray * likingArray;

//@property(nonatomic,strong)reloadUI * relodView;

//@property(nonatomic,strong)TouTiaoNews * titleModel;




@end