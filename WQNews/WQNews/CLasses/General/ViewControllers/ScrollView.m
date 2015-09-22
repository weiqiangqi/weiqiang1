//
//  ScrollView.m
//  WQNews
//
//  Created by lanou3g on 15/9/21.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView ()<UIScrollViewDelegate>

@end

@implementation ScrollView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self drawScrollView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//画scrollView
- (void)drawScrollView
{
    self.ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.ScrollView.contentSize = CGSizeMake(kScreenWidth * self.array.count, 200) ;
    self.ScrollView.bounces = NO;
    self.ScrollView.backgroundColor = [UIColor greenColor];
    for (int i = 0; i < self.array.count; i ++) {
        
    }
    
    
    
    [self.view addSubview:self.ScrollView];
}

#pragma mark ---lazy load--
- (NSArray *)array{
    if (_imageArray == nil) {
        _imageArray = [NSArray array];
    }
    return _imageArray;
}

- (UIScrollView *)ScrollView{
    if (_ScrollView == nil) {
        _ScrollView = [[UIScrollView   alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    }
    _ScrollView.pagingEnabled = YES;
    
    
    return _ScrollView;
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
