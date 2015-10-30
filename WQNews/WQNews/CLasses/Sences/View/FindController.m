//
//  FindController.m
//  WQNews
//
//  Created by QWQ on 15/9/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import "FindController.h"

@interface FindController ()

@end

@implementation FindController

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

- (IBAction)findBackAction:(UIButton *)sender {
    [AVUser requestPasswordResetForEmailInBackground:self.text4Emailaddress.text block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"找回成功" message:@"请到邮箱根据链接重置密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertView * alert =[ [UIAlertView alloc]initWithTitle:@"找回失败" message:@"输入的邮箱有误\n请重新输入邮箱" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
