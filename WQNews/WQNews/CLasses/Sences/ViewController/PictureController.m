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
#import "Pictures3HCell.h"

@interface PictureController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//存储板块表头的数组
@property(nonatomic,strong)NSMutableArray * TitleMutArray;
//存储cell信息的数组
@property(nonatomic,strong)NSMutableArray * cellMutArray;
@property(nonatomic,strong)UITableView * PICStableVIew;

@end

@implementation PictureController
static NSString * picturesCell = @"picturesCell";
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
           
           [self drawTableView];
        } failure:^void(AFHTTPRequestOperation * opration, NSError * error) {
            NSLog(@"数据请求出错了");
        }];
        
    }];
}
#pragma mark ---绘制TableView-----
- (void)drawTableView
{
    self.PICStableVIew = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 113)];
    self.PICStableVIew.delegate = self;
    self.PICStableVIew.dataSource = self;
    //注册自定义cell
    [self.PICStableVIew registerNib:[UINib nibWithNibName:@"Pictures3HCell" bundle:nil] forCellReuseIdentifier:picturesCell];
    
    
    [self.view addSubview:self.PICStableVIew];
    
}

//设置分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//设置行数

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellMutArray.count;
}

//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HdpicPictures * picturesItem = self.cellMutArray[indexPath.row];
    Pictures3HCell * cell = [tableView dequeueReusableCellWithIdentifier:picturesCell forIndexPath:indexPath];
    [cell setCellWithPicturesItem:picturesItem];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 440;
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
