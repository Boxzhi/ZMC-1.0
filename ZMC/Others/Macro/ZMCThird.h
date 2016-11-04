//
//  ZMCThird.h
//  ZMC
//
//  Created by Ljun on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#ifndef ZMCThird_h
#define ZMCThird_h

//115.159.221.106:8080
//115.159.221.106:8080   测试服
#endif /* ZMCThird_h */

#pragma market ------------ 菜谱接口
/* ------------- 菜谱 ----------- */
/**
 *Get:菜谱分类
 */
#define uCCate @"http://115.159.227.219:8088/fanfou-api/cookbook/cate"
/**
 Get:通过名称搜索菜谱,菜谱名:name=%@,当前页码:page=%ld,每页显示数目:page_size=%ld
 */
#define uCSearch @"http://115.159.227.219:8088/fanfou-api/cookbook/search?name=%@&page=%ld&page_size=%ld"
/**
 Get:菜单详情,菜谱id:id=%ld
 */
#define uCMyDetail @"http://115.159.227.219:8088/fanfou-api/cookbook/my/detail/%@?access_token=%@"
/**
 * Get:菜谱列表,分类id:cat_id=%ld,当前页码:page=%ld,每页显示数目:page_size=%ld
 */
#define uCList @"http://115.159.227.219:8088/fanfou-api/cookbook/list/%@?page=%@&page_size=%@"
/**
 Get:查看分享的菜谱列表,菜谱分类id:cat_id=%ld,当前页码:page=%ld,每页显示数目:page_size=%ld,分享菜单的id:share_id=%ld
 */
#define uCShareList @"http://115.159.227.219:8088/fanfou-api/cookbook/share/list/%ld?page=%ld&page_size=%ld&share_id=%ld"
/**
 Get:菜谱详情,菜谱id:id=%ld
 */
#define uCDetail @"http://115.159.227.219:8088/fanfou-api/cookbook/detail/%ld"
/**
 Get:用户菜单列表,当前页码:page=%ld,每页显示数目:page_size=%ld
 */
#define uCMyList @"http://115.159.227.219:8088/fanfou-api/cookbook/my/list?access_token=%@&page=%@&page_size=%@"
/**
 Post:分享菜谱,晚宴时间:dinner_time=%@,介绍:intro=%@,标题:title=%@
 */
#define uCShare @"http://115.159.227.219:8088/fanfou-api/cookbook/share?access_token=%@"

#pragma market -------------- 商家接口
/* ------------- 商家接口 ------------- */
/**
 Get:商家个人中心
 */
#define uMerchantInfo @"http://115.159.227.219:8088/fanfou-api/merchant/info?access_token=%@"












