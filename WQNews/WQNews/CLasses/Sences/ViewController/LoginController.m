//
//  LoginController.m
//  WQNews
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "LoginController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)loginAction:(UIButton *)sender {
    
    [AVUser logInWithUsernameInBackground:self.text4Name.text password:self.text4Pwd.text block:^(AVUser *user, NSError *error) {
        if (user != nil) {

            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"登录成功" message:@"已经登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            
        }
    }];
    
}

- (IBAction)cancelAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
