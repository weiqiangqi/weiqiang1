//
//  MyController.m
//  Wobo_lian
//
//  Created by lanou3g on 15/9/11.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "MyController.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"
#import <AVFoundation/AVFoundation.h>
//快速导入模块
//@import AVFoundation ;

@interface MyController ()
{
    
  
}
@property (weak, nonatomic) IBOutlet UIButton *get4Registr;

@property (weak, nonatomic) IBOutlet UIButton *shareMaseges;
@property (weak, nonatomic) IBOutlet UIButton *carAbout4;




@end

@implementation MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    // Do any additional setup after loading the view.
}

- (IBAction)request4Rgister:(UIButton *)sender {
    WBAuthorizeRequest * request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From":@"MyController",@"Other_Info_1":[NSNumber numberWithInt:123],@"Other_Info_2":@[@"obj1", @"obj2"],@"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
    
}

- (IBAction)shareMesegesAction:(UIButton *)sender {
    AppDelegate * mydelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    WBAuthorizeRequest * authRequest = [WBAuthorizeRequest request];
    authRequest.scope = @"all";
    WBSendMessageToWeiboRequest * requet = [WBSendMessageToWeiboRequest requestWithMessage:[self  messageToshare] authInfo:authRequest access_token:mydelegate.wbtoken];
    requet.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    [WeiboSDK sendRequest:requet];
    
    
}

- (IBAction)careAbout4Mesege:(UIButton *)sender {
}

- (WBMessageObject *)messageToshare
{
    
    WBMessageObject * message = [WBMessageObject message];
message.text = @"测试通过";
    return message;
    
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
