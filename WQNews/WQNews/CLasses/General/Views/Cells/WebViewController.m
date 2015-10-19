//
//  WebViewController.m
//  WQNews
//
//  Created by lanou3g on 15/9/24.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "WebViewController.h"
#import "DataManager.h"

@interface WebViewController ()<UIWebViewDelegate>
{
    NSInteger index;
    NSInteger collectIndex;
}
@property(nonatomic,strong)UIWebView * webView;
@property(nonatomic,strong)UIButton * collectButton;
@property(nonatomic,strong)UIAlertView * alert;

@end

@implementation WebViewController

- (void)viewDidLoad {
    collectIndex = 0;
    [super viewDidLoad];
    
    self.view .backgroundColor = [UIColor colorWithRed:0.631 green:1.000 blue:0.367 alpha:1.000]
    ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView  = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.URLStr]]];
    //设置代理
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    //绘制返回按钮
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 60)];
    headerView.backgroundColor = [UIColor colorWithRed:0.819 green:1.000 blue:0.576 alpha:1.000];
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(15, 20, 30, 25);
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backButton];
    //绘制收藏按钮
    self.collectButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectButton.frame = CGRectMake(kScreenWidth - 40, 20, 30, 30);
     index = [[DataManager shareDataManager]selectLengthOfMainKey:self.URLStr fromTable:kLoverTable];
    if (index > 0) {
         [self.collectButton setImage:[UIImage imageNamed:@"Collected"] forState:UIControlStateNormal];
    }else{
    [self.collectButton setImage:[UIImage imageNamed:@"lovew"] forState:UIControlStateNormal];
    }
    [self.collectButton addTarget:self action:@selector(collectAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:self.collectButton];
    //绘制title
    UILabel * titleLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 20, kScreenWidth - 60, 30)];
    titleLable.text = self.Title;
    titleLable.font = [UIFont systemFontOfSize:17];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:titleLable];
    [self.webView addSubview:headerView];
    //
    [[DataManager shareDataManager]selectAllDataWithTableName:kLoverTable mainKey:kLoverKey title:kLoverTitle URl:kLoverURL type:kLoverType];
}
//返回方法
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark --UIWebViewDelegate的代理方法----
- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    //去除广告
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('sinaHead')[0].style.display = 'none'"];
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('j_sax tj_art_baner')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('aside')[0].style.display = 'none'"];
    
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('extend-module')[0].style.display = 'none'"];
    
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('extend-module')[2].style.display = 'none'"];
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('extend-module')[3].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('extend-module')[4].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('extend-module')[5].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('footer')[0].style.display = 'none'"];
      [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('down_news')[0].style.display = 'none'"];
        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('j_appentrance move')[0].style.display = 'none'"];
}

//- (NSInteger)testcollectAction{
//    
//    
//}

#pragma mark---收藏事件---
- (void)collectAction{
    if (index > 0) {
        index = 0 ;
        UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"取消收藏成功" message:@"取消收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [[DataManager shareDataManager]clearTableCollectWithTableName:kLoverTable mainKey:self.URLStr];
        [self.collectButton setImage:[UIImage imageNamed:@"lovew"] forState:UIControlStateNormal];
        
    }else{
        index = 10;
        [self.collectButton setImage:[UIImage imageNamed:@"Collected"] forState:UIControlStateNormal];
        [[DataManager shareDataManager]creatTableWithTableName:kLoverTable mainKey:kLoverKey title:kLoverTitle URl:kLoverURL type:kLoverType];
        [[DataManager shareDataManager]InsertIntoTableName:kLoverTable WithMainKey:self.URLStr title:self.Title URL:self.picUrl type:@"1"];
        _alert =[ [UIAlertView alloc]initWithTitle:@"您已经收藏过" message:@"您已经收藏过\n可以到我的界面\n我的收藏进行查看" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(dismissView) userInfo:nil repeats:NO];
        [_alert show];
    
    }
    
    
    
    
}

-(void)dismissView{
    [_alert dismissWithClickedButtonIndex:0 animated:YES];
}

//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
//        return NO;
//    }
//    return YES;
//}


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
