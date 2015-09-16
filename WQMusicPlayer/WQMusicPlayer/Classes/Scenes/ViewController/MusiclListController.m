//
//  MusiclListController.m
//  WQMusicPlayer
//
//  Created by lanou3g on 15/9/14.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MusiclListController.h"
#import "MusiclItemCell.h"
#import "MusicHelp.h"
#import "PlayingController.h"


@interface MusiclListController ()

@property(nonatomic,strong)PlayingController * playingVC;



@end

@implementation MusiclListController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
     [self.tableView registerNib:[UINib nibWithNibName:@"MusiclItemCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    [[MusicHelp shareMusicHelp]requestAllMusicWithFinish:^{
        
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MusicHelp shareMusicHelp].mutArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MusiclItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.model = [[MusicHelp shareMusicHelp]itemWithIndex:indexPath.row];
    return cell;
}

//点击cell会触发的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.playingVC.index = indexPath.row;
    
    [self showDetailViewController:self.playingVC sender:nil];
    
}

#pragma mark --lazy load--
- (PlayingController *)playingVC{
    if (_playingVC == nil) {
        _playingVC = [PlayingController sharePlayingController];
    }
    return _playingVC;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
