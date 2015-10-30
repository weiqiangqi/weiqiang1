//
//  LBViewController.m
//  WQNews
//
//  Created by QWQ on 15/9/23.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "LBViewController.h"
#import "IanScrollView.h"

@interface LBViewController ()
//存储对应的一组照片
@property(nonatomic,strong)NSMutableArray * mutArray;
//当前的视图
@property(nonatomic,assign)NSInteger cureentIndex;


@end

@implementation LBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cureentIndex = 0;
    [self drawLBScrollView];
    [self drawView];
    [self drawFootSection];
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
    self.mutArray = [PICarray mutableCopy];
    NSLog(@"%@",self.mutArray);
    for (NSDictionary * Dict in PICarray) {
        NSString * URL = Dict[@"kpic"];
        [PICmutArray addObject:URL];
    }
    scrollView.slideImagesArray = PICmutArray;
    scrollView.ianCurrentIndex = ^(NSInteger index){
        self.cureentIndex = index;
        //刷新图片注释
        [self drawFootSection];
    };
    
    [scrollView startLoading];
    [self.view addSubview:scrollView];
}
//绘制表头
- (void)drawView
{
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    titleView.alpha = 0.5;
    titleView.backgroundColor = [UIColor orangeColor];
    UIButton * backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 30, 40, 30)];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToToutiao) forControlEvents:UIControlEventTouchUpInside];
    
    [titleView addSubview:backButton];
    [self.view addSubview:titleView];
}

- (void)drawFootSection
{
    UIView * FootView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100)];
    FootView.backgroundColor = [UIColor orangeColor];
    //页数
    UILabel * pageLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 40, 0, 30, 30)];
    NSString * pageStr = [NSString stringWithFormat:@"%ld/%ld",self.cureentIndex + 1,self.mutArray.count];
    pageLable.text = pageStr;
    pageLable.font = [UIFont systemFontOfSize:15];
    [FootView addSubview:pageLable];
    
    // 图片标题
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth - 50, 30)];
    titleLabel.text = self.LBnews.title;
    
    [FootView addSubview:titleLabel];
    
    //详细
    UILabel * badyLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth - 20, 50)];
    NSDictionary * dict = self.mutArray[self.cureentIndex];
    badyLable.text = dict[@"alt"];
    badyLable.numberOfLines = 0 ;
    badyLable.font = [UIFont systemFontOfSize:13];
    //FIXME: 如何将对其方式改为上面对齐
    badyLable.textAlignment =  NSTextAlignmentLeft;
    [FootView addSubview:badyLable];
    [self.view addSubview:FootView];
    
}

#pragma mark ---内部写的方法--
- (void)backToToutiao
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --lazy load--
-(NSMutableArray *)mutArray{
    if (_mutArray == nil) {
        _mutArray = [[NSMutableArray alloc]initWithCapacity:8];
    }
    return _mutArray;
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
