//
//  LoginController.h
//  WQNews
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *text4Name;

@property (weak, nonatomic) IBOutlet UITextField *text4Pwd;

- (IBAction)loginAction:(UIButton *)sender;

- (IBAction)cancelAction:(UIButton *)sender;






@end