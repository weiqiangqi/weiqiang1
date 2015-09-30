//
//  RigisterController.m
//  WQNews
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "RigisterController.h"

@interface RigisterController ()

@end

@implementation RigisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
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

- (IBAction)cancleAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registerAction:(UIButton *)sender {
    if ((!([self.text4Name.text isEqualToString:@""] || [self.text4Pwd.text isEqualToString:@""] ))  && [self.text4Pwd.text isEqualToString:self.text4PwdAgain.text]  ) {
        //判断并存储用户信息
        AVUser *user = [AVUser user];
        if (!([self.text4Name.text isEqualToString:@""] || [self.text4Pwd.text isEqualToString:@""] || [self.text4Emailaddress.text isEqualToString:@""] ) ) {
            
            user.username = self.text4Name.text;
            user.password =  self.text4Pwd.text;
            user.email = self.text4Emailaddress.text;
        }else{
            user.username = self.text4Name.text;
            user.password =  self.text4Pwd.text;
        }
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSUserDefaults * userDefaut = [NSUserDefaults standardUserDefaults];
                [userDefaut setObject:self.text4Name.text forKey:@"userName"];
                [userDefaut setObject:self.text4Pwd.text forKey:@"userPwd"];
                [userDefaut setObject:self.text4Emailaddress.text forKey:@"userEmailAddress"];
            } else {
                
                
            }
        }];
        
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"已经登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if ([self.text4Name.text isEqualToString:@""] || [self.text4Pwd.text isEqualToString:@""]){
        UIAlertView * alert1 = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"姓名或密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert1 show];
    }else if (![self.text4Pwd.text isEqualToString:self.text4PwdAgain.text]){
        UIAlertView * alert2 = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"密码和确认密码不同" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert2 show];
        
    }
    
    
    
}
@end
