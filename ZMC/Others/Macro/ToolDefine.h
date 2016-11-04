//
//  ToolDefine.h
//  ThailandGo
//
//  Created by Daniel on 15/10/15.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#define LocationMangerTool [LocationManger locationShared]
//#import "UserInfo.h"
//#import "NSString+Category.h"

//在release版本禁止输出NSLog内容
//发布版本时注释 #define IOS_DEBUG
#define IOS_DEBUG
#ifdef IOS_DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

//检查登录
#define Check_Login \
if ([UserInfo isLogin])\
{\
}\
else\
{\
[self presentLoginVCAction];\
return ;\
}\



#define Check_Login_Objc \
if ([UserInfo isLogin])\
{\
}\
else\
{\
[[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:[RegisterViewController navigationControllerContainSelf] animated:YES completion:nil];\
return ;\
}\


#define NOTIFICATION_REFRAME                          @"NOTIFICATION_REFRAME"     //重绘界面用

#define NOTIFICATION_ALIPAY                          @"NOTIFICATION_ALIPAY"     //支付宝支付完成回调
#define NOTIFICATION_WEIXINPAY                          @"NOTIFICATION_WEIXINPAY"    //微信支付
/**
 *  检查数据有效性
 */
#define CHECK_VALUE(value) NSStringExchangeTheReturnValueToString(value)

#define ChangeNSIntegerToStr(value) [CommonMethod changeNsinterToStr:value]

#define NOTIFICATION_LoadLocation                     @"LoadLocation" //重新定位
#define NOTIFICATION_LoadLocationGetResult                     @"NOTIFICATION_LoadLocationGetResult" //拿到定位


#define GET_IMAGEURL_URL(value) [NSURL URLWithString:[[Singer share] getImageUrlWithStr:value]]

#define TokenToolShared [TotalAccessTokenTool shared]

//#define ACCESSTOKEN @"ACCESSTOKEN"
//#define REFRESHTOKEN @"REFRESHTOKEN"
//#define EXPIRETIME @"EXPIRETIME"
//#define LOGINTIME @"LOGINTIME"
//
#define ISLOGIN @"ISLOGIN"

//===============支付宝支付================
#define ALI_PARTNER                                  @"2088221846698385"
#define ALI_SELLTER                                  @"286166462@qq.com"

#define ALI_PRIVATE_KEY                           @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKHytC+P/ulLon7wbuESqEFqykebguPddMztYECwOsJ0C9u4NRgFSO4hXzWDCR/N0q+N8I40rVuSsgNhRhknxiS0uyuQ8DZN6LszF2N1pa/4SEv0PG9TWnLhzt2+GY/9qzVF+3AvY/m/AWtvRh/nNbpyQT9Hti7bedilMVxf3CH/AgMBAAECgYAVFBPjxOg20UNbJkwoO1du/ElLvK/ynJZhPdwzTzy2pogMlxNCBx4Q8IMF4gJEA3QSqXTP7YdKzfMhgX2wNH8TfuOswqfbWHBftQVnb4YlLvlcCG2Fy8x5WBVGe/4XSshaTmIzVptk3hnG3Xe/da30t3187Vtn2CEokpxx5GPkwQJBANeCUqKOxsBNHqUPsMq69++Q0ys1Hxg/5DZwOg9TNY4q0ZiVCCWClaE96bT2fEwoVNO+CDu8ZJX34Jg0AIyintECQQDAYCxalZiZrlWgEFPc3nPvEgRYnjSj9ONn4n5uHL+b3pfvh9kJ28O/sAe5CD5No75pFeZZk3lftTU4t1szJgfPAkBhKGXs14WPKLWKINrJayVgIeCx+A7+tb9DM7FZO2BHqdI4gefcUVT4DpuQdBdxljU4CNJZbAPFAK2GsNsWjDIhAkA5w+ctoCP9aaLeeGimNsn7LJ7PeVn3LY6nYBR0vf8vL6zRySn70ti5k4MOJZKHv7ZqWaAcn7LfcUs056Hj/vRzAkEAiSCUJ48CXT+ZFj/jwXvQULcyH1PUns5seQF91SouBk5nvEWdcUrI5xELe9qw5FWhfkPvFTFoSkBAVTZv+ZMsBw=="

#define ALI_CALLBACK_URL                             @"http://115.159.227.219:8088/fanfou-api/alinotify"
//=======================================


static NSString * const ServiceTel = @"";//客服400电话


#define AppDownLoadUrl @"https://itunes.apple.com/us/app/zen-me-chi/id1125326330?l=zh&ls=1&mt=8" //appStroe下载该应用信息地址
//appStroe评论该应用信息地址
#define APPCOMMEMTURL @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=961496539"