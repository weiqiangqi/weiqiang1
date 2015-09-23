//
//  LBViewController.m
//  WQNews
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "LBViewController.h"
#import "IanScrollView.h"

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self drawLBScrollView];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --- 绘制点击进去的轮播图-----

- (void)drawLBScrollView
{
    IanScrollView * scrollView = [[IanScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 164)];
    scrollView.withoutAutoScroll = YES;
    scrollView.withoutPageControl = YES;
    NSMutableArray * PICmutArray = [[NSMutableArray alloc]initWithCapacity:8];
     NSDictionary * dict = self.LBnews.pics;
    NSArray * PICarray = dict[@"list"];
    NSLog(@"%@",PICarray);
    for (NSDictionary * Dict in PICarray) {
        NSString * URL = Dict[@"kpic"];
        [PICmutArray addObject:URL];
    }
    NSLog(@"%@",PICmutArray);
    scrollView.slideImagesArray = PICmutArray;
    [scrollView startLoading];
    [self.view addSubview:scrollView];
}

- (void)drawView
{
    
    
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
