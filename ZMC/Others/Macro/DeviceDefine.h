//
//  DeviceDefine.h
//  ThailandGo
//
//  Created by Daniel on 15/9/28.
//  Copyright © 2015年 Daniel. All rights reserved.
//


//判断ios7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
//判断ios8
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//Daniel 专用  平时都有4寸屏幕调 需要用到自动放大的  就这个系数
#define HANGCOEFFICIENT  (SCREEN_SIZE.width/320.0f)
#define GAOCOEFFICIENT (SCREEN_SIZE.height/568.0f)