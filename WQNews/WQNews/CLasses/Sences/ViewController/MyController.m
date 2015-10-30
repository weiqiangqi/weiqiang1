//
//  MyController.m
//  WQNews
//
//  Created by QWQ on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MyController.h"
#import "AppDelegate.h"
#import "MoreCell.h"
#import "LoginController.h"
#import "RigisterController.h"
#import "FindController.h"
#import "UserManager.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "WebViewController.h"
#import "DataManager.h"
#import "MycollectVC.h"


@interface MyController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)NSArray * TitleArray;

//登录按钮
@property(nonatomic,strong) UIButton * loginButton;

//退出登录的提醒
@property(nonatomic,strong )UIAlertView * alertLG;
@property(nonatomic,strong)UIAlertView * alert;

@end

@implementation MyController

static NSString * moreCell = @"moreCell";


- (instancetype)init
{
    
    self = [super init];
    if (self) {
        self.title = @"我的";
        self.tabBarItem.image = [UIImage imageNamed:@"my"];
        
//        注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessAction:) name:@"loginSuccess" object:nil];
//        注册另一通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccessAction:) name:kRegisterSucces object:nil];
        //注册新浪登陆成功按钮
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sinaLoginSuccess:) name:kSinaLogin object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawTableView];
    [self drawheader];

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
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginAction)];
    [self.imgView addGestureRecognizer:tapGesture];
    
     _loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginButton.frame = CGRectMake(0, 0, 150, 30) ;
    [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    _loginButton.tag = 1000;

    _loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _loginButton.center =CGPointMake(headerView.center.x, headerView.center.y + 60);
    [_loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:_loginButton];
    
    [headerView addSubview:self.imgView];
    self.imgView.center = headerView.center;
    self.imgView.layer.cornerRadius = 40;
    self.imgView.layer.masksToBounds = YES;
    
    [headerView addGestureRecognizer:tapGesture];
    self.tableView.tableHeaderView = headerView;
}


#pragma mark ---登录点击事件--

- (void)loginAction{
    NSString * userName = [[UserManager shareUserManager]userName];
    if ([_loginButton.titleLabel.text isEqualToString:userName]) {
        _alertLG = [[UIAlertView alloc]initWithTitle:@"退出登录" message:@"你确定退出登录吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [_alertLG show];

    }else{
    LoginController * loginVC = [LoginController new];
    [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    UIAlertView * alerLG = (UIAlertView *)[self.view viewWithTag:1001];
    if (buttonIndex == 0 && [_alertLG.title isEqualToString:alertView.title] ) {
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [[UserManager shareUserManager] setLoginState:NO];
         self.imgView.image = [UIImage imageNamed:@"login"];
    }
}



#pragma mark --绘制tableView--

- (void)drawTableView{
    
    self.TitleArray = @[@"注册账号",@"找回密码",@"第三方新浪登录",@"我的收藏",@"清除缓存"];
    self.tableView = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, kScreenWidth, kScreenHeight - 48) style:UITableViewStylePlain];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.677 green:1.000 blue:0.200 alpha:1.000];
       [self.tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:nil] forCellReuseIdentifier:moreCell];
    
    self.tableView.bounces = NO;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
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
    

    
    return cell;
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.TitleArray[indexPath.row] isEqualToString:@"第三方新浪登录"]) {
        WBAuthorizeRequest * request = [WBAuthorizeRequest request];
        request.redirectURI = kRedirectURL;
        request.scope = @"all";
        request.userInfo = @{@"SSO_From":@"MyController",@"Other_Info_1":[NSNumber numberWithInt:123],@"Other_Info_2":@[@"obj1", @"obj2"],@"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        [WeiboSDK sendRequest:request];

        
    }else if ([self.TitleArray[indexPath.row] isEqualToString:@"注册账号"] ){
        RigisterController * rigisterVC = [[RigisterController alloc]init];
        [self presentViewController:rigisterVC animated:YES completion:nil];
    }else if ([self.TitleArray[indexPath.row] isEqualToString:@"找回密码"]){
        FindController * findVC = [[FindController alloc]init];
        [self presentViewController:findVC animated:YES completion:nil];
    }else if ([self.TitleArray[indexPath.row] isEqualToString:@"我的收藏" ]){
        MycollectVC * collectVC = [MycollectVC new];
        [self presentViewController:collectVC animated:YES completion:nil];
    }else if ([self.TitleArray[indexPath.row] isEqualToString:@"清除缓存" ]){
       BOOL result = [[DataManager shareDataManager]clearAllDataTableName:kLoverTable];
        if (result) {
            _alert = [[UIAlertView alloc]initWithTitle:@"清除缓存成功" message:@"清除缓存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [_alert show];
            [NSTimer scheduledTimerWithTimeInterval:0.7f target:self selector:@selector(DismisAlert) userInfo:nil repeats:NO];
            
        }
    }
    
}
//alertView提醒事件
- (void)DismisAlert{
    
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ---通知事件
- (void)loginSuccessAction:(NSNotification *)notice{
    NSString * userName = [[UserManager shareUserManager]userName];
    UIButton * loginbutton = (UIButton *)[self.view viewWithTag:1000];
    [loginbutton setTitle:userName forState:UIControlStateNormal];
  
    self.imgView.image = [UIImage imageNamed:@"login"];
}

- (void)registerSuccessAction:(NSNotification *)notice{
    [self loginSuccessAction:notice];
    
    UIAlertView * alertRG = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"恭喜您注册成功\n已经登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertRG show];
    
    self.imgView.image = [UIImage imageNamed:@"login"];
  
}
- (void)sinaLoginSuccess:(NSNotification *)notice{
    NSString * URL = notice.userInfo[@"sinaURL"];
    AFHTTPRequestOperationManager * sinaManager = [AFHTTPRequestOperationManager manager];
   [ sinaManager GET:URL parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
       NSString * name = result[@"name"];
       NSString * picURL = result[@"profile_image_url"];
       [[UserManager shareUserManager]setUserName:name];
       [[UserManager shareUserManager]setLoginState:YES];
       
       [self.loginButton setTitle:name forState:UIControlStateNormal];
       [self.imgView sd_setImageWithURL:[NSURL URLWithString:picURL]];
       
       UIAlertView * alertRG = [[UIAlertView alloc]initWithTitle:@"新浪登陆成功" message:@"恭喜您用第三方新浪登陆成功\n已经登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
       [alertRG show];
    } failure:^void(AFHTTPRequestOperation * oparation, NSError * error) {
        NSLog(@"%@",error);
        
        UIAlertView * alertRG = [[UIAlertView alloc]initWithTitle:@"登陆失败" message:@"登陆失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertRG show];
        
    }];
    
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
