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


@interface VideoController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)NSMutableArray * VideoMutArray;

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
   
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
    
    //网址分析
    NSArray * videoArray =  [[NewsListHelper shareNewsListHerlper].videoArray mutableCopy];
    NSString * cryURl = [NSString new];
    for (NewsListItem * videoItem in videoArray) {
        if ([videoItem.name isEqualToString:@"笑cry"] ) {
            
            cryURl = videoItem.url;
        }
    }
    NSLog(@"%@",cryURl);
    
     //解析数据
    AFHTTPRequestOperationManager * videoManager = [AFHTTPRequestOperationManager manager];
[videoManager GET:cryURl parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
    NSArray * array = result[@"data"][@"list"];
    
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
    self.maintableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth , kScreenHeight - 115) style:UITableViewStylePlain];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
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

#pragma mark ---lazy load---
- (NSMutableArray *)VideoMutArray{
    if (_VideoMutArray == nil) {
        _VideoMutArray = [[NSMutableArray alloc]initWithCapacity:25];
    }
    return _VideoMutArray;
}

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
    NSString * URL = VideoDict[@"video_id"];
     [[PlayerHelper shareVideoPlayer] setVideoWithURLStr:URL];
    PlayerHelper * player = [PlayerHelper shareVideoPlayer];
    
    self.view = player;
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
