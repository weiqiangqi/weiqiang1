//
//  ChooseController.m
//  WQNews
//
//  Created by lanou3g on 15/9/28.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "ChooseController.h"
#import "TItleCell.h"

@interface ChooseController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation ChooseController
static NSString * titleCell = @"titleCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    [self drawHeader];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TItleCell" bundle:nil] forCellReuseIdentifier:titleCell];

    
    [self.view addSubview:self.tableView];
}

- (void)drawHeader{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, 150, 25)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.center = headerView.center;
    titleLable.text = @"编辑";
    [headerView addSubview:titleLable];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, 20, 60, 30);
    [backButton setTitle:@"确定" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToMainScreen) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:backButton];
    
    [self.view addSubview:headerView];
    
}

- (void)backToMainScreen{
    //发出通知
    [self.likingArray addObject:@"hahha"];
    [[NSNotificationCenter defaultCenter]postNotificationName:kChooseInterest object:nil userInfo:@{@"likingArray":self.likingArray}];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}






#pragma mark --dlegate , datasouse 事件---

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.titleArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TItleCell * cell = [tableView dequeueReusableCellWithIdentifier:titleCell];
    TouTiaoNews * modelTitle = self.titleArray[indexPath.row];
    [cell setCellWithTitleItem:modelTitle];
    
//    cell.textLabel.text = @"测试一下";
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}





//懒加载
- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
    
}

- (NSMutableArray *)likingArray{
    if (_likingArray == nil) {
        _likingArray = [NSMutableArray array];
    }
    return _likingArray;
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
