//
//  MyController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MyController.h"


@interface MyController ()
//登陆头像
@property(nonatomic,strong)UIImageView * imgView;



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
    
    
}

- (void)drawheader{
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
  
    
    
    [self.view addSubview:headerView];
    
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
