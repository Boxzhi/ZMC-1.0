//
//  FrameDefine.h
//  ThailandGo
//
//  Created by Daniel on 15/10/12.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#define NAVHEIGHT 64
//Daniel 专用  平时都有4寸屏幕调 需要用到自动放大的  就这个系数
#define HANGCOEFFICIENT  (SCREEN_SIZE.width/320.0f)
#define GAOCOEFFICIENT (SCREEN_SIZE.height/568.0f)
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
//#define NAV_H self.navigationController.navigationBar.frame.size.height
#define NAV_H 44


//所有的leftBtn都用一个尺寸
#define LEFTBARITEMRECT CGRectMake(25, 0, 20, 20)

//所有的rightBtn都用一个尺寸
#define RIGHTBARITEMRECT CGRectMake(60, 0, 20, 20)


//当前屏幕大小
#define SCREEN_SIZE   [[UIScreen mainScreen] bounds].size
//底部Tab高度
#define TABBAR_HEIGHT 50
#define padAirScreen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)

#define pad2Screen ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)

#define RETINA_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define RETINA_6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断设备为4寸屏幕
#define RETINA_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define RETINA_3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
