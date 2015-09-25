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


@interface NewsListController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//头条信息数组
@property(nonatomic,strong)NSMutableArray * mutArray;
//轮播图信息
@property(nonatomic,strong)NSMutableArray * LBMutArray;
//存储cell的数组
@property(nonatomic,strong)NSMutableArray * cellMutArray;

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
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     [self drawButton];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    
    
    //实现block
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
        //解析数据
//        NSArray * newsArray = [NewsListHelper shareNewsListHerlper].newsAray;
//        NewsListItem * toutiaoItem = newsArray[0];
//        NSString * toutiaoUrl = toutiaoItem.url;
        
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
            [self drawmainScrollView];
            [self drawTableView];
            
        } failure:^void(AFHTTPRequestOperation * operation, NSError * error) {
            NSLog(@"错误是:%@",error);
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --绘制ScrollView----
- (void)drawScrollView{
    IanScrollView * scrollView = [[IanScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , 188)];
    NSMutableArray * LmutArray = [[NSMutableArray alloc]initWithCapacity:20];
    //取轮播图数组
    for (TouTiaoNews * news in self.mutArray) {
        //FIXME: 网络提供的数据有问题
        if (news.is_focus && ([news.category isEqualToString:@"hdpic"] || [news.category isEqualToString:@"plan"])) {
            [self.LBMutArray addObject:news];
            [LmutArray addObject:news.kpic];
        }
    }
       scrollView.slideImagesArray = LmutArray;
    scrollView.withoutAutoScroll = YES;
    //点击转到详细轮播
    scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
        LBViewController * LBItem =[LBViewController new];
        LBItem.LBnews = self.LBMutArray[i];
        LBItem.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:LBItem animated:YES completion:nil];
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
    //解析数组
    for (TouTiaoNews  * CellNews in self.mutArray) {
        if ([CellNews.category isEqualToString:@"subject"] || [CellNews.category isEqualToString:@"video"] || [CellNews.category isEqualToString:@"cms"] || ([CellNews.category isEqualToString:@"hdpic"] &&  (!(CellNews.is_focus))) || [CellNews.category isEqualToString:@"consice"] ) {
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
//cell数组
- (NSMutableArray *)cellMutArray{
    if (_cellMutArray == nil) {
        _cellMutArray = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _cellMutArray;
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
