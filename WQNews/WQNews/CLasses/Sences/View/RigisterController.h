//
//  RigisterController.h
//  WQNews
//
//  Created by lanou3g on 15/9/29.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
@interface RigisterController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *text4Name;
@property (weak, nonatomic) IBOutlet UITextField *text4Pwd;
@property (weak, nonatomic) IBOutlet UITextField *text4PwdAgain;
@property (weak, nonatomic) IBOutlet UITextField *text4Emailaddress;

- (IBAction)cancleAction:(UIButton *)sender;

- (IBAction)registerAction:(UIButton *)sender;




@end
