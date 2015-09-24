//
//  WebViewController.m
//  WQNews
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView * webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view .backgroundColor = [UIColor colorWithRed:1.000 green:0.954 blue:0.450 alpha:1.000]
    ;
    
    self.webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 40)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLStr]]];
    //设置代理
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    //绘制返回按钮
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    headerView.backgroundColor = [UIColor greenColor];
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(0, 20, 20, 15);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    [self.webView addSubview:headerView];
    
    
    
    
    
}
//返回fangfa
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark --UIWebViewDelegate的代理方法----
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---lazy load--
//重写webVIew的get方法
//- (UIWebView *)webView{
//    if (_webView == nil) {
//        _webView = [UIWebView new];
//    }
//    return _webView;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
