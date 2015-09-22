//
//  NewsListController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "NewsListController.h"
#import "NewsListHelper.h"

@interface NewsListController ()<UIScrollViewDelegate>

@end

@implementation NewsListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
       
        self.title = @"新闻";
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self drawButton];
    [[NewsListHelper shareNewsListHerlper]getAllURL];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma  mark ---绘制主界面------
//绘制主界面上面的导航栏
- (void)drawButton{
    
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, 44)];
//头条新闻
    self.firstButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.firstButton.frame = CGRectMake(0, 0, (kScreenWidth - 40) / 5, 40);

    [self.firstButton setTitle:@"头条" forState:UIControlStateNormal];
    self.firstButton.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    [self.firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.firstButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//第二个button
    self.button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button2.frame = CGRectMake( (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    
    [self.button2 setTitle:@"娱乐" forState:UIControlStateNormal];
    self.button2.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    [self.button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    第三个button
    self.button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button3.frame = CGRectMake( 2 * (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    
    [self.button3 setTitle:@"体育" forState:UIControlStateNormal];
    self.button3.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    [self.button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    第四个
    self.button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button4.frame = CGRectMake( 3 * (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    
    [self.button4 setTitle:@"财经" forState:UIControlStateNormal];
    self.button4.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    [self.button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button4 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [buttonView addSubview:self.button4];
//    第五个
    self.button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button5.frame = CGRectMake( 4 * (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    
    [self.button5 setTitle:@"编辑" forState:UIControlStateNormal];
    self.button5.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    [self.button5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button5 setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [buttonView addSubview:self.button5];
    
    [buttonView addSubview:self.button5];
    [buttonView addSubview:self.button4];
    [buttonView addSubview:self.button3];
    [buttonView addSubview:self.button2];
    [buttonView addSubview:self.firstButton];
    [self.view addSubview:buttonView];
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
