//
//  NewsListController.h
//  WQNews
//
//  Created by QWQ on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListController : UIViewController

//绘制主界面上面的导航栏
- (void)drawButton;
//导航栏的button
@property(nonatomic,strong)UIButton * firstButton;
@property(nonatomic,strong)UIButton * button2;
@property(nonatomic,strong)UIButton * button3;
@property(nonatomic,strong)UIButton * button4;
@property(nonatomic,strong)UIButton * button5;
//主界面scrollView
@property(nonatomic,strong)UIScrollView * mainSccrollView;
//主界面tabeleView
@property(nonatomic,strong)UITableView * tableView;








@end
