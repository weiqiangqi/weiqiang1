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
@interface PlayingController ()

@property(nonatomic,strong)MusicItem * currentModel;

@property(nonatomic,assign)NSInteger currentIndex;

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
  
}

#pragma mark --私有的方法--
- (void)upUI{
   //如果换歌的话,就让图片重新归位
    self.img4Picture.transform = CGAffineTransformMakeRotation(0);
    
    [self.img4Picture sd_setImageWithURL:[NSURL URLWithString:self.currentModel.picUrl]];
    
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

- (IBAction)buttont4StartAndPause:(UIButton *)sender {
    UIButton * btm = sender;
    
    
    
}



#pragma mark --lazy load--
- (MusicItem *)currentModel{
    
         _currentModel = [MusicHelp shareMusicHelp].mutArray[_currentIndex];

    return _currentModel;
}


@end