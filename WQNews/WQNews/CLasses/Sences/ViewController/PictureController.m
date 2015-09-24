//
//  PictureController.m
//  WQNews
//
//  Created by lanou3g on 15/9/19.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "PictureController.h"
#import "NewsListHelper.h"
#import "AFNetworking.h"
#import "HdpicPictures.h"

@interface PictureController ()
//存储板块表头的数组
@property(nonatomic,strong)NSMutableArray * TitleMutArray;
//存储cell信息的数组
@property(nonatomic,strong)NSMutableArray * cellMutArray;

@end

@implementation PictureController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.title = @"图片";
        self.tabBarItem.image = [UIImage imageNamed:@"picture"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //解析数据
    [[NewsListHelper shareNewsListHerlper]getAllURL:^{
        self.TitleMutArray = [[NewsListHelper shareNewsListHerlper].hdpicArray mutableCopy];
        NSString * URLStr;
        for (NSDictionary * titleDict in self.TitleMutArray) {
            if ([titleDict[@"name"] isEqualToString:@"精选"]) {
                URLStr = titleDict[@"url"];
            }
        }
        AFHTTPRequestOperationManager * JXmanager = [AFHTTPRequestOperationManager manager];
       [JXmanager GET:URLStr parameters:nil success:^void(AFHTTPRequestOperation * task, id result) {
           NSArray * array = [NSArray array];
           NSLog(@"%ld",array.count);
          array = result[@"data"][@"list"];
           NSLog(@"%ld",array.count);
           for (int i = 0; i < array.count; i ++ ) {
               NSDictionary * tempDict = [NSDictionary new];
               tempDict = array[i];
                HdpicPictures * pictureItem = [HdpicPictures new];
               [pictureItem setValuesForKeysWithDictionary:tempDict];
               [self.cellMutArray addObject:pictureItem];
           }
           
           
           
           
        } failure:^void(AFHTTPRequestOperation * opration, NSError * error) {
            NSLog(@"数据请求出错了");
        }];
        
        
        
        
    }];
    
    
    
}

#pragma mark ---lazy load--
- (NSMutableArray *)TitleMutArray{
    if (_TitleMutArray == nil) {
        _TitleMutArray = [[NSMutableArray alloc]initWithCapacity:8];
    }
    return _TitleMutArray;
}

- (NSMutableArray *)cellMutArray{
    if (_cellMutArray == nil) {
        _cellMutArray = [[NSMutableArray alloc]initWithCapacity:20];
    }
    return _cellMutArray;
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
