//
//  ChooseController.h
//  WQNews
//
//  Created by QWQ on 15/9/28.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouTiaoNews.h"

typedef void(^reloadBlock)(NSMutableArray *);

@interface ChooseController : UIViewController

@property(nonatomic,strong)NSArray * titleArray;



@property(nonatomic,strong)NSMutableArray * likingArray;

//@property(nonatomic,copy)reloadBlock likingBlock;





@end
