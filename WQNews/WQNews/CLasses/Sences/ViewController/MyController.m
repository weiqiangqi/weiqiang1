//
//  MyController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MyController.h"
#import "AppDelegate.h"
#import "MoreCell.h"
#import "LoginController.h"


@interface MyController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray * TitleArray;

@end

@implementation MyController

static NSString * moreCell = @"moreCell";


- (instancetype)init
{
    
    self = [super init];
    if (self) {
        self.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"my"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
 
   
    
    [self drawTableView];
    [self drawheader];
//    [self drawMyView];
//    self.tableView
    
}

- (void)drawheader{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    headerView.backgroundColor = [UIColor colorWithRed:0.768 green:1.000 blue:0.572 alpha:1.000]
    ;
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.imgView.image = [UIImage imageNamed:@"login"];
    //打开交互界面
    self.imgView.userInteractionEnabled = YES;
    //创建并添加轻拍手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Loginbysina)];
    [self.imgView addGestureRecognizer:tapGesture];
    
    UIButton * sinaLogIn = [UIButton buttonWithType:UIButtonTypeSystem];
    sinaLogIn.frame = CGRectMake(0, 0, 150, 30) ;
    [sinaLogIn setTitle:@"新浪登陆" forState:UIControlStateNormal];
    sinaLogIn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    sinaLogIn.center =CGPointMake(headerView.center.x, headerView.center.y + 60);
    [sinaLogIn addTarget:self action:@selector(Loginbysina) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:sinaLogIn];
    
    [headerView addSubview:self.imgView];
    self.imgView.center = headerView.center;
    self.imgView.layer.cornerRadius = 40;
    self.imgView.layer.masksToBounds = YES;
    
    [headerView addGestureRecognizer:tapGesture];
    self.tableView.tableHeaderView = headerView;
//    [self.view addSubview:headerView];
    
}


#pragma mark ---按钮点击事件--
- (void)Loginbysina{
    WBAuthorizeRequest * request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyController",@"Other_Info_1":[NSNumber numberWithInt:123],@"Other_Info_2":@[@"obj1", @"obj2"],@"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)drawMyView{
    //绘制姓名按钮
    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4, kScreenHeight / 3, 50, 30)];
    nameLable.backgroundColor = [UIColor colorWithRed:0.997 green:1.000 blue:0.948 alpha:1.000]
    ;
    nameLable.text = @"姓名:";
    nameLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nameLable];
    //绘制密码按钮
    UILabel * pwdLable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth / 4, kScreenHeight / 3 + 50, 50, 30)];
    pwdLable.text = @"密码:";
    pwdLable.backgroundColor = [UIColor colorWithRed:0.997 green:1.000 blue:0.948 alpha:1.000];
    pwdLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:pwdLable];
    //绘制登陆按钮
    UIButton * loginButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth / 3, kScreenHeight / 3 + 90, 50, 30)];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor colorWithRed:0.470 green:1.000 blue:0.258 alpha:1.000];
    loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginButton];
}

#pragma mark --绘制tableView--

- (void)drawTableView{
    
    self.TitleArray = @[@"注册账号",@"登陆",@"离线下载",@"清理缓存",@"收藏",@"应用中心"];
    self.tableView = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 48) style:UITableViewStylePlain];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.677 green:1.000 blue:0.200 alpha:1.000];
       [self.tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:moreCell];
    
    self.tableView.bounces = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

//    self.tableView.
    
    [self.view addSubview:self.tableView];
    
}



#pragma mark --tableView代理事件
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.TitleArray.count;
}

- (UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCell * cell = [tableView dequeueReusableCellWithIdentifier:moreCell forIndexPath:indexPath];
    
    cell.lable4Title.text = self.TitleArray[indexPath.row];
    
//    MoreCell * cell = [tableView dequeueReusableCellWithIdentifier:moreCell forIndexPath:indexPath];
    
    return cell;
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.TitleArray[indexPath.row] isEqualToString:@"登陆"]) {
        LoginController * loginVC = [LoginController new];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark --lazy load---
- (NSArray *)TitleArray{
    if (_TitleArray == nil) {
        _TitleArray = [NSArray array];
    }
    return _TitleArray;
    
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
