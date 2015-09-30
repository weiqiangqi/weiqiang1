//
//  FindController.h
//  WQNews
//
//  Created by lanou3g on 15/9/30.
//  Copyright (c) 2015年 齐伟强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

@interface FindController : UIViewController
- (IBAction)findBackAction:(UIButton *)sender;

- (IBAction)cancelAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *text4Emailaddress;



@end
