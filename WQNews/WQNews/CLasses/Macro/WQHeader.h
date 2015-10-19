//
//  WQHeader.h
//  WQNews
//
//  Created by lanou3g on 15/10/17.
//  Copyright © 2015年 齐伟强. All rights reserved.
//

#ifndef WQHeader_h
#define WQHeader_h

#define kAppKey @"3998436771"
#define kRedirectURL @"https://api.weibo.com/oauth2/default.html"
//宏定义
#define kLoginNotice @"loginSuccess"
#define kLoginState  @"loginState"
#define kUserName  @"userName"
#define kUserPwd  @"userPwd"
#define kUserEmailAddress  @"emailAddress"
#define kRegisterSucces @"registerSuccess"
#define kChooseInterest  @"ChooseInterest"
#define kSinaLogin  @"SinaLogin"
//定义沙河路径
#define kDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"myDataBAse"]

//创建数据库需要的值
#define kLoverKey @"loverKey"
#define kLoverTitle @"loverTitle"
#define kLoverTable @"loverTable"
#define kLoverURL @"loverUrl"
#define kLoverType @"loverType"




#endif /* WQHeader_h */
