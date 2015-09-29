//
//  MyController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MyController.h"
#import "AppDelegate.h"


@interface MyController ()
//登陆头像
//@property(nonatomic,strong)UIImageView * imgView;



@end

@implementation MyController
static   NSString *  videolistCell = @"videolistCell";

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
    [self drawheader];
    
    
}

- (void)drawheader{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    headerView.backgroundColor = [UIColor colorWithRed:0.768 green:1.000 blue:0.572 alpha:1.000]
    ;
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.imgView.image = [UIImage imageNamed:@"login"];
    
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
    
    [self.view addSubview:headerView];
}


#pragma mark ---按钮点击事件--
- (void)Loginbysina{
    WBAuthorizeRequest * request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyController",@"Other_Info_1":[NSNumber numberWithInt:123],@"Other_Info_2":@[@"obj1", @"obj2"],@"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];

    
    
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
