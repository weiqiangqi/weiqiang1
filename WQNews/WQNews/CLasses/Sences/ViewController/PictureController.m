//
//  PictureController.m
//  WQNews
//
//  Created by QWQ on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "PictureController.h"
#import "NewsListHelper.h"
#import "AFNetworking.h"
#import "HdpicPictures.h"
#import "Pictures3HCell.h"
#import "WebViewController.h"
#import "Pictures4PictCell.h"
#import "Picture2PictCell.h"
#import "Pictures3VCell.h"
#import <SVPullToRefresh.h>

@interface PictureController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageNumber;
    NSString * URLStr;
}
//存储板块表头的数组
@property(nonatomic,strong)NSMutableArray * TitleMutArray;
//存储cell信息的数组
@property(nonatomic,strong)NSMutableArray * cellMutArray;
@property(nonatomic,strong)UITableView * PICStableVIew;

@end

@implementation PictureController
static NSString * picturesCell = @"picturesCell";
static NSString * pictures4PicCell = @"pictures4PicCell";
static NSString * pictures2PicCell = @"pictures2PicCell";
static NSString * pictures3VCell = @"pictures3VPicCell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        pageNumber = 1;
        self.title = @"图片";
        self.tabBarItem.image = [UIImage imageNamed:@"picture"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //解析数据
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
        self.TitleMutArray = [[NewsListHelper shareNewsListHerlper].hdpicArray mutableCopy];
        for (NSDictionary * titleDict in self.TitleMutArray) {
            if ([titleDict[@"name"] isEqualToString:@"精选"]) {
                URLStr = titleDict[@"url"];
            }
        }
        AFHTTPRequestOperationManager * JXmanager = [AFHTTPRequestOperationManager manager];
       [JXmanager GET:URLStr parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
           NSArray * array = [NSArray array];
           NSLog(@"%ld",array.count);
          array = result[@"data"][@"list"];
           NSLog(@"%ld",array.count);
           for (int i = 0; i < array.count; i ++ ) {
               NSDictionary * tempDict = [NSDictionary new];
               tempDict = array[i];
                HdpicPictures * pictureItem = [HdpicPictures new];
               [pictureItem setValuesForKeysWithDictionary:tempDict];
               [self.cellMutArray addObject:pictureItem];
           }
           [self drawTableView];
        } failure:^void(AFHTTPRequestOperation * opration, NSError * error) {
            NSLog(@"数据请求出错了");
        }];
        
    }];
    [self drawHeader];
}

#pragma mark --画表头---
- (void)drawHeader{
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 20)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"图片";
    titleLable.textColor = [UIColor redColor];
    [self.view addSubview:titleLable];
    
}

#pragma mark ---绘制TableView-----
- (void)drawTableView
{
    self.PICStableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, kScreenWidth, kScreenHeight - 113)];
    self.PICStableVIew.delegate = self;
    self.PICStableVIew.dataSource = self;
    //注册自定义cell
    [self.PICStableVIew registerNib:[UINib nibWithNibName:@"Pictures3HCell" bundle:nil] forCellReuseIdentifier:picturesCell];
    [self.PICStableVIew registerNib:[UINib nibWithNibName:@"Pictures4PictCell" bundle:nil] forCellReuseIdentifier:pictures4PicCell];
    [self.PICStableVIew registerNib:[UINib nibWithNibName:@"Picture2PictCell" bundle:nil] forCellReuseIdentifier:pictures2PicCell];
    [self.PICStableVIew registerNib:[UINib nibWithNibName:@"Pictures3VCell" bundle:nil] forCellReuseIdentifier:pictures3VCell];
    
    //上拉刷新
    __weak PictureController * weakSelf = self;
    [self.PICStableVIew addPullToRefreshWithActionHandler:^{
        [weakSelf.PICStableVIew removeFromSuperview];
        [weakSelf viewDidLoad];

    }];
    //下拉加载
    [self.PICStableVIew addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullFromBottom];
        
    }];

    
    
    [self.view addSubview:self.PICStableVIew];
    
}

//设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//设置行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellMutArray.count;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HdpicPictures * picturesItem = self.cellMutArray[indexPath.row];
    NSDictionary * tempDict = picturesItem.pics;
    NSString * str = [ NSString stringWithFormat:@"%@",tempDict[@"picTemplate"] ];
    if ([str isEqualToString:@"2"] ) {
        Pictures3HCell * cell = [tableView dequeueReusableCellWithIdentifier:picturesCell forIndexPath:indexPath];
        [cell setCellWithPicturesItem:picturesItem];
        return cell;
    }else if ([str isEqualToString:@"4"]){
        Pictures4PictCell * cell = [tableView dequeueReusableCellWithIdentifier:pictures4PicCell forIndexPath:indexPath];
        [cell setCellWithPicturesItem:picturesItem];
        return cell;
    }else if ([str isEqualToString:@"1"]){
        Picture2PictCell * cell = [tableView dequeueReusableCellWithIdentifier:pictures2PicCell forIndexPath:indexPath];
        [cell setCellWithPicturesItem:picturesItem];
        return  cell;
    }else if ([str isEqualToString:@"3"]){
        Pictures3VCell * cell = [tableView dequeueReusableCellWithIdentifier:pictures3VCell forIndexPath:indexPath];
        [cell setCellWithPicturesItem:picturesItem];
        return cell;
    }
    
    Pictures3HCell * cell = [tableView dequeueReusableCellWithIdentifier:picturesCell forIndexPath:indexPath];
    [cell setCellWithPicturesItem:picturesItem];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HdpicPictures * picturesItem = self.cellMutArray[indexPath.row];
    NSDictionary * tempDict = picturesItem.pics;
    NSString * str = [ NSString stringWithFormat:@"%@",tempDict[@"picTemplate"] ];
    if ([str isEqualToString:@"2"] ) {
                return 440;
    }else if ([str isEqualToString:@"1"] || [str isEqualToString:@"4"] || [str isEqualToString:@"3"]){
        return 320;
    }
    return 440;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController * webViewVC = [WebViewController new];
    webViewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
     HdpicPictures * picturesItem = self.cellMutArray[indexPath.row];
    webViewVC.URLStr = picturesItem.link;
    webViewVC.Title = picturesItem.title;
    webViewVC.picUrl = picturesItem.pic;
    
    [self presentViewController:webViewVC animated:YES completion:nil];
}

#pragma mark ---上拉加载事件
- (void)pullFromBottom{
    __weak PictureController * weakSelf = self;
    pageNumber ++;
    NSString * picStr =  [NSString stringWithFormat:@"http://api.sina.cn/sinago/list.json?uid=f4e8fd0c674b1f09&loading_ad_timestamp=0&platfrom_version=4.4.2&wm=b207&imei=864502025497611&from=6048195012&connection_type=2&chwm=12030_0001&AndroidID=ec0fd8e3601d5a55dcf7c6ffe0eeaf35&v=1&s=10&IMEI=f10426ec3f30043c6798dae6fe0cbf0d&p=%ld&MAC=c08f509cfc8e818f8482d523edf1ee84&channel=hdpic_toutiao",pageNumber];
    
    AFHTTPRequestOperationManager * JXmanager = [AFHTTPRequestOperationManager manager];
    [JXmanager GET:picStr parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
        NSArray * array = [NSArray array];
        NSLog(@"%ld",array.count);
        array = result[@"data"][@"list"];
        NSLog(@"%ld",array.count);
        for (int i = 0; i < array.count; i ++ ) {
            NSDictionary * tempDict = [NSDictionary new];
            tempDict = array[i];
            HdpicPictures * pictureItem = [HdpicPictures new];
            [pictureItem setValuesForKeysWithDictionary:tempDict];
            [weakSelf.cellMutArray addObject:pictureItem];
        }
        //移除之前的在重画
//        [self.PICStableVIew removeFromSuperview];
//        [self drawTableView];
        [self.PICStableVIew reloadData];
        [weakSelf.PICStableVIew.infiniteScrollingView stopAnimating];
        NSLog(@"---------------%ld",self.cellMutArray.count);
    } failure:^void(AFHTTPRequestOperation * opration, NSError * error) {
        NSLog(@"数据请求出错了");
    }];

    
}


#pragma mark ---lazy load--
- (NSMutableArray *)TitleMutArray{
    if (_TitleMutArray == nil) {
        _TitleMutArray = [[NSMutableArray alloc]initWithCapacity:8];
    }
    return _TitleMutArray;
}

- (NSMutableArray *)cellMutArray{
    if (_cellMutArray == nil) {
        _cellMutArray = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _cellMutArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
