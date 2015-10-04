//
//  VideoController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "VideoController.h"
#import "VideoListCell.h"
#import "AFNetworking.h"
#import "NewsListHelper.h"
#import "NewsListItem.h"
#import "VideoItem.h"
#import "WebViewController.h"
#import "PlayerHelper.h"
#import <SVPullToRefresh.h>

@interface VideoController ()<UITableViewDelegate,UITableViewDataSource>
{
    //加载页数
    NSInteger pageNumber;
    
}

@property(nonatomic,strong)NSMutableArray * VideoMutArray;
@property(nonatomic,strong)UISegmentedControl * segCV;
//选中的标题栏
@property(nonatomic,strong)NSArray * titleArray;
//选中的下标
@property(nonatomic,assign)NSInteger index;

@end

@implementation VideoController
static   NSString *  videolistCell = @"videolistCell";
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"视频";
        self.tabBarItem.image = [UIImage imageNamed:@"video"];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //赋初值
    self.index = 0 ;
    [self drawSegmenttedControlView];
    
    self.titleArray = @[@"笑cry",@"暖心",@"八卦",@"震惊"];
    
    [self analysysData];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[PlayerHelper shareVideoPlayer] videoPause];
    
}

#pragma mark ---解析shuju--
- (void)analysysData{
    
    
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
        
        //网址分析
        NSArray * videoArray =  [[NewsListHelper shareNewsListHerlper].videoArray mutableCopy];
        NSString * cryURl = [NSString new];
        for (NewsListItem * videoItem in videoArray) {
            if ([videoItem.name isEqualToString:self.titleArray[self.index]] ) {
                
                cryURl = videoItem.url;
            }
        }
      
        
        //解析数据
        AFHTTPRequestOperationManager * videoManager = [AFHTTPRequestOperationManager manager];
        [videoManager GET:cryURl parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
            NSArray * array = result[@"data"][@"list"];
            //清楚数组中的数据
            [self.VideoMutArray removeAllObjects];
            for (int i = 0; i < array.count; i ++) {
                NSDictionary * dict = array[i];
                VideoItem * modelVideo = [VideoItem new];
                [modelVideo setValuesForKeysWithDictionary:dict];
                [self.VideoMutArray addObject:modelVideo];
            }
            
            [self drawTableView];
        } failure:^void(AFHTTPRequestOperation * opration, NSError * error) {
        }];
        
    }];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---draw TableView----
- (void)drawTableView{
    self.maintableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth , kScreenHeight - 115) style:UITableViewStylePlain];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
    //上拉刷新
    __weak VideoController * weakSelf = self;
    [self.maintableView addPullToRefreshWithActionHandler:^{
        //先移除在画tableview
        [weakSelf.maintableView removeFromSuperview];
        [weakSelf analysysData];
        
    }];
    //下拉加载
    [self.maintableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullFromButtom];
        
    }];
    
    
    //注册自定义cell
    [self.maintableView registerNib:[UINib nibWithNibName:@"VideoListCell" bundle:nil] forCellReuseIdentifier:videolistCell];
    
    [self.view addSubview:self.maintableView];
    
}
//设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.VideoMutArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoItem * modelVideo = self.VideoMutArray[indexPath.row];
    VideoListCell * cell = [tableView dequeueReusableCellWithIdentifier:videolistCell forIndexPath:indexPath];
    [cell setCellWithVideoItem:modelVideo];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 240;
}


#pragma mark -- 绘制segmenttedcontroll --

- (void)drawSegmenttedControlView{
    
    _segCV = [[UISegmentedControl alloc]initWithItems:@[@"笑cry",@"暖心",@"八卦",@"震惊"]];
    _segCV.frame = CGRectMake(50, 25, kScreenWidth - 100, 30);
    _segCV.tintColor = [UIColor colorWithRed:0.993 green:0.021 blue:0.159 alpha:1.000];
    _segCV.backgroundColor = [UIColor whiteColor];
    [_segCV addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventValueChanged];
    _segCV.selectedSegmentIndex = 0;
    [self.view addSubview:_segCV];
}

- (void)changeAction{
    
    self.index = _segCV.selectedSegmentIndex;
    //先移除在绘制
    [self.maintableView removeFromSuperview];
    [self analysysData];
    
}
#pragma mark --- 上拉加载事件--
//加载事件
- (void)pullFromButtom{
    
    pageNumber ++;
    
    //网址分析
    NSArray * videoArray =  [[NewsListHelper shareNewsListHerlper].videoArray mutableCopy];
    NewsListItem * newsList = videoArray[_index];
    NSString * videoURL = [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=f4e8fd0c674b1f09&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&imei=864502025497611&from=6048195012&connection_type=2&chwm=12030_0001&AndroidID=ec0fd8e3601d5a55dcf7c6ffe0eeaf35&v=1&s=20&IMEI=f10426ec3f30043c6798dae6fe0cbf0d&p=%ld&MAC=c08f509cfc8e818f8482d523edf1ee84&channel=%@",pageNumber,newsList.ID];
    
    //解析数据
    AFHTTPRequestOperationManager * videoManager = [AFHTTPRequestOperationManager manager];
    [videoManager GET:videoURL parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        NSArray * array = result[@"data"][@"list"];
        for (int i = 0; i < array.count; i ++) {
            NSDictionary * dict = array[i];
            VideoItem * modelVideo = [VideoItem new];
            [modelVideo setValuesForKeysWithDictionary:dict];
            [self.VideoMutArray addObject:modelVideo];
        }
        //先移除在绘制新的tableview
        [self.maintableView removeFromSuperview];
        [self drawTableView];
    } failure:^void(AFHTTPRequestOperation * opration, NSError * error) {
        
    }];

}



#pragma mark ---lazy load---
- (NSMutableArray *)VideoMutArray{
    if (_VideoMutArray == nil) {
        _VideoMutArray = [[NSMutableArray alloc]initWithCapacity:25];
    }
    return _VideoMutArray;
}


#pragma mark -- cell的点击事件
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoItem * modelVideo = self.VideoMutArray[indexPath.row];
    
    //点击跳转到webView页面
    //    WebViewController * webView = [WebViewController new];
    //    webView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    NSDictionary * VideoDict = modelVideo.video_info;
    //    NSString * URL = VideoDict[@"video_id"];
    //    webView.URLStr = URL;
    //    webView.Title = modelVideo.title;
    //    [self presentViewController:webView animated:YES completion:nil];
    
    NSDictionary * VideoDict = modelVideo.video_info;
    NSString * URL = VideoDict[@"url"];
    [[PlayerHelper shareVideoPlayer] setVideoWithURLStr:URL];
    PlayerHelper * player = [PlayerHelper shareVideoPlayer];
    
    [self.view addSubview: player];
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
