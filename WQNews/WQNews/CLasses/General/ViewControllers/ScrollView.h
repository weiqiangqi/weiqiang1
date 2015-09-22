//
//  ScrollView.h
//  WQNews
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollView : UIViewController
//轮播图
@property(nonatomic,strong)UIScrollView * ScrollView;
//
@property(nonatomic,strong) UIPageControl * PageController;
//输入的播放照片的数组
@property(nonatomic,strong)NSArray * imageArray;

//@property(nonatomic,assign)CGRect  ScrollviewRect;




@end
