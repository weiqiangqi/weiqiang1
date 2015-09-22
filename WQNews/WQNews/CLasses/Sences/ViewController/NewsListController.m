//
//  NewsListController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "NewsListController.h"
#import "NewsListHelper.h"
#import "IanScrollView.h"
#import "AFNetworking.h"
#import "NewsListItem.h"
#import "TouTiaoNews.h"


@interface NewsListController ()
//头条信息数组
@property(nonatomic,strong)NSMutableArray * mutArray;
@property(nonatomic,strong)NSMutableArray * LBMutArray;


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
    
    
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
        //解析数据
        NSArray * newsArray = [NewsListHelper shareNewsListHerlper].newsAray;
        NewsListItem * toutiaoItem = newsArray[0];

        NSString * toutiaoUrl = toutiaoItem.url;
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        [manager GET:toutiaoUrl parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
            NSDictionary * dataDict = result[@"data"];
            NSArray * TTListArray = dataDict[@"list"];
            //将数据转化成model类型保存到数组
            for (NSDictionary * dict in TTListArray) {
                TouTiaoNews * newsItem = [TouTiaoNews new];
                [newsItem setValuesForKeysWithDictionary:dict];
                [self.mutArray addObject:newsItem];
            }
            
            [self drawScrollView];
        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"错误是:%@",error);
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)drawScrollView{
    IanScrollView * scrollView = [[IanScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 150)];
    NSMutableArray * LmutArray = [[NSMutableArray alloc]initWithCapacity:20];
    //取去轮播图数组
    for (TouTiaoNews * news in self.mutArray) {
        
        if ([news.category isEqualToString:@"hdpic"]) {
            [self.LBMutArray addObject:news];
        }
        
    }
    for (TouTiaoNews * newsItem in self.LBMutArray) {
        
        [LmutArray addObject:newsItem.kpic];
    }
    scrollView.slideImagesArray = LmutArray;
    
    
    
    [scrollView startLoading];
    [self.view addSubview:scrollView];
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


#pragma mark --lazy load--
- (NSMutableArray *)mutArray{
    if (_mutArray == nil) {
        _mutArray = [NSMutableArray array];
    }
    return _mutArray;
}

//轮播图数组
- (NSMutableArray *)LBMutArray
{
    
    if (_LBMutArray == nil) {
        _LBMutArray = [NSMutableArray array];
    }
    return _LBMutArray;
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
