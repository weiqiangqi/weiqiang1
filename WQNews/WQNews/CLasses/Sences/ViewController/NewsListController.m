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
#import "LBViewController.h"
#import "SubjectCell.h"
#import "VIdeoCell.h"
#import "CmsCell.h"
#import "HdpicCell.h"
#import "WebViewController.h"
#import "ChooseController.h"
#import "TItleCell.h"
#import <SVPullToRefresh.h>

@interface NewsListController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//头条信息数组
@property(nonatomic,strong)NSMutableArray * mutArray;
//轮播图信息
@property(nonatomic,strong)NSMutableArray * LBMutArray;
//存储cell的数组
@property(nonatomic,strong)NSMutableArray * cellMutArray;

@property(nonatomic,strong)NSArray * newsArray;

@property(nonatomic,strong)NSMutableArray * chooseArray;
//选择界面
@property(nonatomic,strong)ChooseController * chooseVC;

@property(nonatomic,strong)NSMutableArray * likingArray;

@end

@implementation NewsListController
static  NSString * subjectCell = @"subjectCell";
static  NSString * videoCell = @"videoCell";
static  NSString * cmsCell = @"cmsCell";
static  NSString * hdpicCell = @"hdpicCell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.title = @"新闻";
        self.tabBarItem.image = [UIImage imageNamed:@"news"];
        //注册通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(chooseAction:) name:kChooseInterest object:nil];
        
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated{
    [self.tableView triggerPullToRefresh];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    __weak NewsListController * weakSelf = self;
 [self.tableView addPullToRefreshWithActionHandler:^{
     
     [weakSelf drawmainScrollView];
 }];
    
    //实现block
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
        //解析数据
//        [self.chooseArray removeLastObject];
        self.newsArray = [[NewsListHelper shareNewsListHerlper].newsAray mutableCopy];
        self.chooseArray = [[NewsListHelper shareNewsListHerlper].chooseArray mutableCopy];
        [self.chooseArray removeObjectAtIndex:0];
        //初始化自己喜欢的数组
        [self choooseYourLikingArray];
        //        NewsListItem * toutiaoItem = newsArray[0];
        //        NSString * toutiaoUrl = toutiaoItem.url;
        
        [self.mutArray removeAllObjects];
        NSString * toutiaoUrl = kTOUTIAOURL;
        AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
        [manager GET:toutiaoUrl parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
            NSDictionary * dataDict = result[@"data"];
            NSArray * TTListArray = dataDict[@"list"];
            //将数据转化成model类型保存到数组
            for (int i = 0; i < TTListArray.count; i ++) {
                NSDictionary * dict  = TTListArray[i];
                TouTiaoNews * newsItem = [TouTiaoNews new];
                [newsItem setValuesForKeysWithDictionary:dict];
                [self.mutArray addObject:newsItem];
            }
             [self drawButton];
            [self drawmainScrollView];
            [self drawTableView];
            
        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"错误是:%@",error);
        }];
    }];
    

}


#pragma mark ---设置自己喜欢的数组---
- (void)choooseYourLikingArray{
    for (NewsListItem * item in self.chooseArray) {
        if ([item.name isEqualToString:@"娱乐"] || [item.name isEqualToString:@"体育"] || [item.name isEqualToString:@"财经"]) {
            [self.likingArray addObject:item];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --绘制ScrollView----
- (void)drawScrollView{
    //在重新加载之前先清理掉之前的数据
    [self.LBMutArray removeAllObjects];
    
    IanScrollView * scrollView = [[IanScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 188)];
    NSMutableArray * LmutArray = [[NSMutableArray alloc]initWithCapacity:20];
    
    
    //取轮播图数组
    for (TouTiaoNews * news in self.mutArray) {
        //FIXME: 网络提供的数据有问题
        if (news.is_focus && ([news.category isEqualToString:@"hdpic"] || [news.category isEqualToString:@"plan"] || [news.category isEqualToString:@"cms"])) {
            [self.LBMutArray addObject:news];
            [LmutArray addObject:news.kpic];
        }
    }
    scrollView.slideImagesArray = LmutArray;
    scrollView.withoutAutoScroll = YES;
    //点击转到详细轮播
    scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
        TouTiaoNews * modelItem =  self.LBMutArray[i];
        if ([modelItem.category isEqualToString:@"cms"]) {
            WebViewController * webVC = [WebViewController new];
            webVC.URLStr = modelItem.link ;
            webVC.Title = modelItem.title;
            [self presentViewController:webVC animated:YES completion:nil];
            
        }else{
        LBViewController * LBItem =[LBViewController new];
        LBItem.LBnews = self.LBMutArray[i];
        
        LBItem.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:LBItem animated:YES completion:nil];
    }
    };
    
    [scrollView startLoading];
   
    self.tableView.tableHeaderView = scrollView;
    
}

- (void)drawmainScrollView
{
    
    self.mainSccrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 110)];
    self.mainSccrollView.contentSize = CGSizeMake(kScreenWidth * 4, self.mainSccrollView.frame.size.height);
    self.mainSccrollView.backgroundColor = [UIColor greenColor];
    _mainSccrollView.pagingEnabled = YES;
    self.mainSccrollView.showsHorizontalScrollIndicator = NO;
    self.mainSccrollView.showsVerticalScrollIndicator = YES;
    //这里有问题
    //FIXME:
    self.mainSccrollView.bounces = NO;
    self.mainSccrollView.alwaysBounceHorizontal = NO;
    self.mainSccrollView.alwaysBounceVertical = NO;
    
    [self.view addSubview:self.mainSccrollView];
    
}
#pragma mark --- 绘制主界面tableView-----

- (void)drawTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight -108 ) style:UITableViewStylePlain];
    [self.mainSccrollView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //在重新加载之前先清理掉之前的数据
    [self.cellMutArray removeAllObjects];
    //解析数组
    for (TouTiaoNews  * CellNews in self.mutArray) {
        if ([CellNews.category isEqualToString:@"subject"] || [CellNews.category isEqualToString:@"video"] || ([CellNews.category isEqualToString:@"cms"] && (!CellNews.is_focus)) || ([CellNews.category isEqualToString:@"hdpic"] &&  (!(CellNews.is_focus))) || [CellNews.category isEqualToString:@"consice"] ) {
            [self.cellMutArray addObject:CellNews];
        }
    }
    
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellReuseIdentifier:subjectCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"VIdeoCell" bundle:nil] forCellReuseIdentifier:videoCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"CmsCell" bundle:nil] forCellReuseIdentifier:cmsCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"HdpicCell" bundle:nil] forCellReuseIdentifier:hdpicCell];
    
    
    [self drawScrollView];
    
}


//tableView的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//TableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellMutArray.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TouTiaoNews * CellNews = self.cellMutArray[indexPath.row];
    if ([CellNews.category isEqualToString:@"subject" ]) {
        SubjectCell * cell = [tableView dequeueReusableCellWithIdentifier:subjectCell forIndexPath:indexPath];
        [cell setCellWithToutiaoNewsItem:CellNews];
        cell.lable4category.text = @"专题";
        return cell;
    }else if ([CellNews.category isEqualToString:@"video"]){
        VIdeoCell * cell = [tableView dequeueReusableCellWithIdentifier:videoCell forIndexPath:indexPath];
        [cell setCellWithToutiaoNewsItem:CellNews];
        return cell;
    }else if ([CellNews.category isEqualToString:@"cms"]){
        CmsCell * cell = [tableView dequeueReusableCellWithIdentifier:cmsCell forIndexPath:indexPath];
        [cell setCellWithToutiaoNewsItem:CellNews];
        return cell;
    }else if ([CellNews.category isEqualToString:@"consice"]){
        SubjectCell * cell = [tableView dequeueReusableCellWithIdentifier:subjectCell forIndexPath:indexPath];
        [cell setCellWithToutiaoNewsItem:CellNews];
    }else if ([CellNews.category isEqualToString:@"hdpic"] ){
        HdpicCell * cell = [tableView dequeueReusableCellWithIdentifier:hdpicCell forIndexPath:indexPath];
        [cell setCellWithToutiaoNewsItem:CellNews];
        
    }
    //FIXME: 精读的选项还没有完善
    SubjectCell * cell = [tableView dequeueReusableCellWithIdentifier:subjectCell forIndexPath:indexPath];
    
    return cell;
}

//设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//点击cell时触发的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TouTiaoNews * CellNews = self.cellMutArray[indexPath.row];
    WebViewController * webView = [WebViewController new];
    if ([CellNews.category isEqualToString:@"hdpic"]) {
        LBViewController * LBItem = [[LBViewController alloc]init];
        LBItem.LBnews = CellNews;
        LBItem.modalPresentationStyle = UIModalTransitionStyleCrossDissolve ;
        [self presentViewController:LBItem animated:YES completion:nil];
        
    }else{
        
        webView.URLStr = CellNews.link;
        [self presentViewController:webView animated:YES completion:nil];
    }
}



#pragma  mark ---绘制主界面------
//绘制主界面上面的导航栏
- (void)drawButton{
    
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, 44)];
    buttonView.tag = 2001;
    //头条新闻
    self.firstButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.firstButton.frame = CGRectMake(0, 0, (kScreenWidth - 40) / 5, 40);
    
    [self.firstButton setTitle:@"头条" forState:UIControlStateNormal];
    self.firstButton.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.firstButton.tintColor = [UIColor redColor];
    
    //第二个button
    self.button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button2.frame = CGRectMake( (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    NewsListItem * yuleItem = self.likingArray[0];
    
    [self.button2 setTitle:yuleItem.name forState:UIControlStateNormal];
    self.button2.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.button2.tintColor = [UIColor blackColor];
    //    第三个button
    self.button3 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button3.frame = CGRectMake( 2 * (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    NewsListItem * tiyuItem = self.likingArray[1];
    [self.button3 setTitle:tiyuItem.name forState:UIControlStateNormal];
    self.button3.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.button3.tintColor = [UIColor blackColor];
    //    第四个
    self.button4 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button4.frame = CGRectMake( 3 * (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    
    NewsListItem * caijingItem = self.likingArray[2];
    [self.button4 setTitle:caijingItem.name forState:UIControlStateNormal];
    self.button4.titleLabel.textAlignment =NSTextAlignmentCenter;
    self.button4.tintColor = [UIColor blackColor];
    
    [buttonView addSubview:self.button4];
    //    第五个
    self.button5 = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button5.frame = CGRectMake( 4 * (kScreenWidth - 40) / 5,0, (kScreenWidth - 40) / 5, 40);
    
    [self.button5 setTitle:@"编辑" forState:UIControlStateNormal];
    self.button5.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    self.button5.tintColor = [UIColor blackColor];
    //添加事件
    [self.firstButton addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [self.button4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
    [self.button5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonView addSubview:self.button5];
    
    [buttonView addSubview:self.button5];
    [buttonView addSubview:self.button4];
    [buttonView addSubview:self.button3];
    [buttonView addSubview:self.button2];
    [buttonView addSubview:self.firstButton];
    [self.view addSubview:buttonView];
}

#pragma mark --表头选择事件

- (void)button1Action{
    //控制按钮颜色
    self.firstButton.tintColor = [UIColor redColor];
    self.button2.tintColor = [UIColor blackColor];
    self.button3.tintColor = [UIColor blackColor];
    self.button4.tintColor = [UIColor blackColor];
    self.button5.tintColor = [UIColor blackColor];
    
    [self.mutArray removeAllObjects];
    NSString * toutiaoUrl = kTOUTIAOURL;
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:toutiaoUrl parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        
        
        NSDictionary * dataDict = result[@"data"];
        NSArray * TTListArray = dataDict[@"list"];
        //将数据转化成model类型保存到数组
        for (int i = 0; i < TTListArray.count; i ++) {
            NSDictionary * dict  = TTListArray[i];
            TouTiaoNews * newsItem = [TouTiaoNews new];
            [newsItem setValuesForKeysWithDictionary:dict];
            [self.mutArray addObject:newsItem];
        }
        //从原来的视图上移除再添加
        [self.mainSccrollView removeFromSuperview];
        [self.tableView removeFromSuperview];
        
        [self drawmainScrollView];
        [self drawTableView];
        
        
    } failure:^void(AFHTTPRequestOperation *operation, NSError * error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)button2Action{
    self.firstButton.tintColor = [UIColor blackColor];
    self.button2.tintColor = [UIColor redColor];
    self.button3.tintColor = [UIColor blackColor];
    self.button4.tintColor = [UIColor blackColor];
    self.button5.tintColor = [UIColor blackColor];
    
    
    [self.mutArray removeAllObjects];
    NSString * yuleStr;
//    for (NewsListItem * yuleItem in self.newsArray) {
//                if ([yuleItem.name isEqualToString:@"娱乐"]) {
//                    yuleStr = yuleItem.url;
//        }
//        
//    }
    NewsListItem * yuleItem = self.likingArray[0];
    yuleStr = yuleItem.url;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:yuleStr parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        
        
        NSDictionary * dataDict = result[@"data"];
        NSArray * TTListArray = dataDict[@"list"];
        //将数据转化成model类型保存到数组
        for (int i = 0; i < TTListArray.count; i ++) {
            NSDictionary * dict  = TTListArray[i];
            TouTiaoNews * newsItem = [TouTiaoNews new];
            [newsItem setValuesForKeysWithDictionary:dict];
            [self.mutArray addObject:newsItem];
        }
        //从原来的视图上移除再添加
        [self.mainSccrollView removeFromSuperview];
        [self.tableView removeFromSuperview];
                [self drawmainScrollView];
                [self drawTableView];
        
        
    } failure:^void(AFHTTPRequestOperation *operation, NSError * error) {
        NSLog(@"%@",error);
    }];
    
    
    
}

- (void)button3Action{
    self.firstButton.tintColor = [UIColor blackColor];
    self.button2.tintColor = [UIColor blackColor];
    self.button3.tintColor = [UIColor redColor];
    self.button4.tintColor = [UIColor blackColor];
    self.button5.tintColor = [UIColor blackColor];
    
    [self.mutArray removeAllObjects];
    NSString * tiyuStr;
//    for (NewsListItem * tiyuItem in self.newsArray) {
//        if ([tiyuItem.name isEqualToString:@"体育"]) {
//            tiyuStr = tiyuItem.url;
//        }
//        
//    }
    NewsListItem * tiyuItem = self.likingArray[1];
    tiyuStr = tiyuItem.url;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:tiyuStr parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        
        
        NSDictionary * dataDict = result[@"data"];
        NSArray * TTListArray = dataDict[@"list"];
        //将数据转化成model类型保存到数组
        for (int i = 0; i < TTListArray.count; i ++) {
            NSDictionary * dict  = TTListArray[i];
            TouTiaoNews * newsItem = [TouTiaoNews new];
            [newsItem setValuesForKeysWithDictionary:dict];
            [self.mutArray addObject:newsItem];
        }
        //从原来的视图上移除再添加
        [self.mainSccrollView removeFromSuperview];
        [self.tableView removeFromSuperview];
        
        [self drawmainScrollView];
        [self drawTableView];
        
        
    } failure:^void(AFHTTPRequestOperation *operation, NSError * error) {
        
        NSLog(@"%@",error);
    }];
    
    
}

- (void)button4Action{
    self.firstButton.tintColor = [UIColor blackColor];
    self.button2.tintColor = [UIColor blackColor];
    self.button3.tintColor = [UIColor blackColor];
    self.button4.tintColor = [UIColor redColor];
    self.button5.tintColor = [UIColor blackColor];
    
    [self.mutArray removeAllObjects];
    NSString * caijingStr;
//    for (NewsListItem * caijingItem in self.newsArray) {
//        if ([caijingItem.name isEqualToString:@"财经"]) {
//            caijingStr = caijingItem.url;
//        }
//    }
    NewsListItem * caijingItem = self.likingArray[2];
    caijingStr = caijingItem.url;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    [manager GET:caijingStr parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        
        
        NSDictionary * dataDict = result[@"data"];
        NSArray * TTListArray = dataDict[@"list"];
        //将数据转化成model类型保存到数组
        for (int i = 0; i < TTListArray.count; i ++) {
            NSDictionary * dict  = TTListArray[i];
            TouTiaoNews * newsItem = [TouTiaoNews new];
            [newsItem setValuesForKeysWithDictionary:dict];
            [self.mutArray addObject:newsItem];
        }
        
        //从原来的视图上移除再添加
        [self.mainSccrollView removeFromSuperview];
        [self.tableView removeFromSuperview];
        
        [self drawmainScrollView];
        [self drawTableView];
        
        
    } failure:^void(AFHTTPRequestOperation *operation, NSError * error) {
        
        NSLog(@"%@",error);
    }];
    
}

- (void)button5Action{
    self.firstButton.tintColor = [UIColor blackColor];
    self.button2.tintColor = [UIColor blackColor];
    self.button3.tintColor = [UIColor blackColor];
    self.button4.tintColor = [UIColor blackColor];
    self.button5.tintColor = [UIColor redColor];
    ChooseController * chooseVC = [ChooseController new];
    
    chooseVC.titleArray = [self.chooseArray mutableCopy];
    
    
    [chooseVC.likingArray removeAllObjects];
    [chooseVC.likingArray addObjectsFromArray: [self.likingArray mutableCopy]];
    [self presentViewController:chooseVC animated:YES completion:nil];
    

}

- (void)chooseAction:(NSNotification*)notice{
    //移除之前的视图
    UIView * view = (UIView *)[self.view viewWithTag:2001];
    [view removeFromSuperview];
//    NSMutableArray * mutArray = [notice.userInfo[@"likingArray"] mutableCopy];
    [self.likingArray removeAllObjects];
    [self.likingArray addObjectsFromArray: [notice.userInfo[@"likingArray"] mutableCopy]];
    
    [self drawButton];
}






#pragma mark --lazy load--
- (NSMutableArray *)chooseArray{
    if (_chooseArray == nil) {
        _chooseArray = [NSMutableArray array];
    }
    return _chooseArray;
}
- (NSMutableArray *)mutArray{
    if (_mutArray == nil) {
        _mutArray = [NSMutableArray array];
    }
    return _mutArray;
}
//自己喜欢的数组
- (NSMutableArray *)likingArray{
    if (_likingArray == nil) {
        _likingArray = [NSMutableArray array];
    }
    return _likingArray;
}

//轮播图数组
- (NSMutableArray *)LBMutArray
{
    
    if (_LBMutArray == nil) {
        _LBMutArray = [NSMutableArray array];
    }
    return _LBMutArray;
}
//cell数组
- (NSMutableArray *)cellMutArray{
    if (_cellMutArray == nil) {
        _cellMutArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _cellMutArray;
}

//新闻表头数组
- (NSArray *)newsArray{
    if (_newsArray == nil) {
        _newsArray = [NSArray array];
    }
    return _newsArray;
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
