//
//  MycollectVC.m
//  WQNews
//
//  Created by lanou3g on 15/10/18.
//  Copyright © 2015年 齐伟强. All rights reserved.
//

#import "MycollectVC.h"
#import "DataManager.h"
#import "TouTiaoNews.h"
#import "HLoverModel.h"
#import "LoverCell.h"
#import <UIImageView+WebCache.h>
#import "WebViewController.h"

@interface MycollectVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSMutableArray * collectArray;

@end

@implementation MycollectVC
static  NSString * collectCell = @"subjectCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectData];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 25, kScreenWidth, kScreenHeight - 25) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.993 green:1.000 blue:0.914 alpha:1.000];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    //注册自定义cell
    [self.tableView registerNib:[UINib nibWithNibName:@"LoverCell" bundle:nil] forCellReuseIdentifier:collectCell];
    
    [self drawheader];

}

- (void)selectData{
   _collectArray = [[[DataManager shareDataManager]selectAllDataWithTableName:kLoverTable mainKey:kLoverKey title:kLoverTitle URl:kLoverURL type:@"1"] mutableCopy];
}

#pragma mark -- 绘制表头事件
- (void)drawheader{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    headerView.backgroundColor = [UIColor colorWithRed:0.682 green:1.000 blue:0.673 alpha:1.000];
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 20, kScreenWidth - 100, 40)];
    titleLable.text = @"我的收藏";
    titleLable.textAlignment = NSTextAlignmentCenter;
    
    [headerView addSubview:titleLable];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(10, 20, 30, 25);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:backButton];
    [self.view addSubview:headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --tableView的代理事件---
//设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectArray.count;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HLoverModel * model = self.collectArray[indexPath.row];
    LoverCell * cell = [tableView dequeueReusableCellWithIdentifier:collectCell forIndexPath:indexPath];
    cell.lable4Title.text = model.title;
    [cell.imgview4Image sd_setImageWithURL: [NSURL URLWithString:model.picUrl]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   HLoverModel * model = self.collectArray[indexPath.row];
    WebViewController * webView = [WebViewController new];
    webView.Title = model.title;
    webView.URLStr = model.ID;
    webView.picUrl = model.url;
    
    [self presentViewController:webView animated:YES completion:nil];
}

- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --lazy load--
- (NSMutableArray *)collectArray{
    if (_collectArray == nil) {
        _collectArray = [NSMutableArray array];
    }
    return _collectArray;
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
