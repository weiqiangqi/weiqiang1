//
//  PlayingController.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/15.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "PlayingController.h"
#import <AudioUnit/AudioUnit.h>
#import "UIImageView+WebCache.h"
#import "MusicHelp.h"
#import "MusicItem.h"
#import "AudioPlayer.h"
#import "LyricHelp.h"
#import "LyricModel.h"
@interface PlayingController ()<AudioPlayerDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property(nonatomic,strong)MusicItem * currentModel;

@property(nonatomic,assign)NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UITableView *lyricTableView;



@end

@implementation PlayingController

+(PlayingController *)sharePlayingController{
    static PlayingController * playingVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playingVC = [PlayingController new];
    });
    return playingVC ;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PlayingController * playingVC = [sb  instantiateViewControllerWithIdentifier:@"playingVC"];
        self = playingVC;
        _currentIndex = -1;
    }
    
    return  self;
}

//当界面将要出现时执行的方法
-(void)viewWillAppear:(BOOL)animated{
 
    if(_index == _currentIndex){
        return ;
    }
    
    _currentIndex = _index;
    [self startPlay];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.img4Picture.layer.cornerRadius = 100;
    self.img4Picture.layer.masksToBounds = YES;
   
    [self.slider4Playing addTarget:self action:@selector(timeSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.lyricTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    
    
    
        
    // Do any additional setup after loading the view.
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
#pragma mark --公开方法--

- (void)startPlay{
    [self upUI];
    [[AudioPlayer sharePlayer] setPrepareMusicWithURL:self.currentModel.mp3Url];
   [AudioPlayer sharePlayer].delegate = self;
    
    [[LyricHelp shareLyric]initWithLyricString:self.currentModel.lyric];
    //在开始播放后去重新去加载数据
    [self.lyricTableView reloadData];
    
}

#pragma mark --私有的方法--
- (void)upUI{
   //如果换歌的话,就让图片重新归位
    self.img4Picture.transform = CGAffineTransformMakeRotation(0);
    
    [self.img4Picture sd_setImageWithURL:[NSURL URLWithString:self.currentModel.picUrl]];
    //更新进度条的最大值
    self.slider4Playing.maximumValue = [self.currentModel.duration floatValue]/ 1000;
}

//滑动滑条拖动时间
- (void)timeSliderAction:(UISlider*)sender{
    
    [[AudioPlayer sharePlayer]seekToTime:sender.value];
    
}



- (IBAction)button4NextAction:(UIButton *)sender {
    _currentIndex ++;
    if (_currentIndex >=  [MusicHelp shareMusicHelp].mutArray.count ) {
        _currentIndex = 0;
    }
    [self startPlay];
    }

- (IBAction)back4ListVC:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)button4PreviorAction:(UIButton *)sender {
    _currentIndex --;
    if (_currentIndex < 0   ) {
        _currentIndex = [MusicHelp shareMusicHelp].mutArray.count - 1;
    }
    [self startPlay];
}
//暂停播放按钮
- (IBAction)buttont4StartAndPause:(UIButton *)sender {
    UIButton * btm = sender;
    if ([AudioPlayer sharePlayer].isPlaying) {
        [[AudioPlayer sharePlayer]pause];
        [btm setTitle:@"播放" forState:UIControlStateNormal];
        
    }else{
        [[AudioPlayer sharePlayer]play];
         [btm setTitle:@"暂停" forState:UIControlStateNormal];
    }
    
    
}

#pragma mark --AudioPlayerDelegate
- (void)audioPlayerPlayingWith:(AudioPlayer *)audiopPlayer Progress:(float)progress{
    self.img4Picture.transform = CGAffineTransformRotate(self.img4Picture.transform, M_PI /80);
    //更新时间
    //已经播放时间
    int minute = (int)progress / 60;
    int seconds = (int)progress % 60 ;
    float last = [_currentModel.duration floatValue] / 1000 - progress;
    //剩余时间
    int minit2 = (int)last / 60 ;
    int second2 = (int)last % 60;
    self.label4PlayedTime.text = [NSString stringWithFormat:@"%d:%d",minute,seconds];
    self.label4PlayedTime.textAlignment = NSTextAlignmentRight;
    self.label4LastrTime.text = [NSString stringWithFormat:@"%d:%d",minit2,second2];
    //更新进度条
    self.slider4Playing.value = progress;
    //确定歌曲的行
    NSIndexPath * index = [NSIndexPath indexPathForRow:[[LyricHelp shareLyric] getIndexWithTime:progress]inSection:0];
    
    [self.lyricTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    
}

- (void)audioPlayerDidfinishItem:(AudioPlayer *)audioPlayer{
    
    [self button4NextAction:nil];
}

#pragma mark ---UITableViewDataSource---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return [LyricHelp shareLyric].lyricArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
 
    LyricModel * lyricModel = [LyricHelp shareLyric].lyricArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = lyricModel.lyricStr;
    cell.backgroundColor = [UIColor colorWithRed:0.891 green:1.000 blue:0.778 alpha:1.000];
    
    return cell;
}


#pragma mark --lazy load--
- (MusicItem *)currentModel{
    
         _currentModel = [MusicHelp shareMusicHelp].mutArray[_currentIndex];

    return _currentModel;
}


@end
