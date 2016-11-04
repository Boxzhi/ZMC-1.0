//
//  ZMCURL.h
//  ZMC
//
//  Created by Ljun on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#ifndef ZMCURL_h
#define ZMCURL_h


#endif /* ZMCURL_h */

#define urlString @"http://115.159.227.219:8088/fanfou-api"

//extern NSString *urlLinkStr = @"http://115.159.227.219:8088/fanfou-api";

#pragma market ------- 会员管理接口

/*-----------个人中心--------------*/

/**
 Get:置换接口调用凭证,refresh_token=%@
 */
#define uURefresh_token @"http://115.159.227.219:8088/fanfou-api/member/refresh_token?refresh_token=%@"
#define uURefresh_token @"http://115.159.227.219:8088/fanfou-api/member/refresh_token?refresh_token=%@"
/**
 Post请求:登录,登录账号:account=%@,密码:password=%@,客户端注册id:push_token=%ld
 "access_token": "3a1d935f8fb28560c687220b47134cf0",
 "refresh_token": "6b6866dabbdf7635ed5620a2f6185b73"
 "expire_time": 7200
 */

#define uULogin @"http://115.159.227.219:8088/fanfou-api/member/login"
/**
 Post请求:发送短信验证码,手机号:account=%@,Content-Type=application/json
 */
#define uUCaptcha @"http://115.159.227.219:8088/fanfou-api/member/captcha"
/**
 Post请求:保存更新客户端pushToken,唯一凭证:registration_id=%@   ???
 */
#define uUPushToken @"http://115.159.227.219:8088/fanfou-api/token/add?access_token=%@"
/**
 Get请求:注册协议接口
 */
#define uURegistration @"http://115.159.227.219:8088/fanfou-api/agreement/registration"
/**
 Get:获取用户收支记录,assess_token=%@,page=%ld,page_size=%ld
 */
#define uUMoney @"http://115.159.227.219:8088/fanfou-api/member/bill?access_token=%@&page=%ld&page_size=%ld"
/**
 Get:获取用户历史站点
 */
#define uUHistory @"http://115.159.227.219:8088/fanfou-api/member/station?access_token=%@"
/**
 Get:获取会员信息
 */
#define uUUserMassege @"http://115.159.227.219:8088/fanfou-api/member?access_token=%@"
/**
 Post:注册(第一步)手机号:account=%@,短信验证:verification=%@ 5%CaBVyiKa
 */
#define uURegister @"http://115.159.227.219:8088/fanfou-api/member/register"
/**
 Post:注册(第二步)密码:password=%@,重复密码:repeat_passwd=%@,调用凭证:token=%@
 */

#define uURegisterPassword @"http://115.159.227.219:8088/fanfou-api/member/register/password"

/* -------------收货地址------------- */
/**
 Post:编辑收货地址,access_token=%@
 */
#define uAShippingAddress @"http://115.159.227.219:8088/fanfou-api/member/address?access_token=%@"
/**
 Post:默认收货地址,access_token=%@
 */
#define uADefaultAddress @"http://115.159.227.219:8088/fanfou-api/member/address/default/{id}?access_token=%@"
/**
 Post:删除收货地址,access_token=%@
 */
#define uARemoveAddress @"http://115.159.227.219:8088/fanfou-api/member/address/delete/%@?access_token=%@"
/**
 Get:查询收货地址,access_token=%@,page=%ld,page_size=%ld
 */
#define uADemandAddress @"http://115.159.227.219:8088/fanfou-api/member/addresses?access_token=%@&page=%ld&page_size=%ld"
/**
 Get:根据经纬度查询周边,address=%@,latitude=%@,longitude=%@,radius=%@
 */
#define uANearAddress @"http://115.159.227.219:8088/fanfou-api/member/address/near?address=%@&latitude=%@&longitude=%@&radius=%@"

/* ---------- 优惠券 ---------- */
/**
 Get:查询优惠券
 */
#define uCCoupons @"http://115.159.227.219:8088/fanfou-api/member/coupons?access_token=%@&page=%ld&page_size=%ld"

/* ----------- 投诉意见 ---------- */
/**
 Post:投诉反馈,投诉反馈意见:content=%@
 */
#define uFFeedback @"http://115.159.227.219:8088/fanfou-api/feedback?access_token=%@"


/* ----------- 退款记录 ---------- */
/**
 get: 查询退款记录
 */
#define uMRefund @"http://115.159.227.219:8088/fanfou-api/member/refund/list?access_token=%@"



/* ------------ 会员积分 ----------- */
/**
 Post:会员签到,是否签到:is_signin=%ld,标记用来区分查询和签到 1：执行签到操作 0：仅用于查询签到情况
 */
#define uMMember @"http://115.159.227.219:8088/fanfou-api/member/signin?access_token=%@&is_signin=%@"
/**
 Get:积分明细,access_token=%@
 */
#define uMList @"http://115.159.227.219:8088/fanfou-api/member/points/list?access_token=%@"
/**
 Get:积分规则
 */
#define uMRule @"http://115.159.227.219:8088/fanfou-api/member/points/rule"
/**
 Get:兑换比率,access_token=%@
 */
#define uMRatio @"http://115.159.227.219:8088/fanfou-api/member/points/ratio?access_token=%@"


#pragma market ----------- 首页接口

/* ------------ 首页接口 ----------- */
/**
 Get:首页接口,菜市场id:market_id=%ld
 */
//#define uHMain @"http://115.159.227.219:8088/fanfou-api/home/main?market_id=%ld"
#define uHMain @"http://115.159.227.219:8088/fanfou-api/home/main?market_id=1"
/**
 Get:常见的接口问题
 */
#define uHFaq @"http://115.159.227.219:8088/fanfou-api/faq/list"
/**
 Get:查询开通城市列表
 */
#define uHOpenCity @"http://115.159.227.219:8088/fanfou-api/home/open_area"
/**
 *  GET:获取省份列表
 */
//#define GetProvince @"http://115.159.227.219:8088/fanfou-api/area/province"
#define GetProvince @"http://115.159.227.219:8088/fanfou-api/area/province/open"
/**
 *  GET:获取城市列表
 */
//#define GetCity @"http://115.159.227.219:8088/fanfou-api/area/city/%ld"
#define GetCity @"http://115.159.227.219:8088/fanfou-api/area/city/open/%ld"
/**
 *  GET:获取区县列表
 */
//#define GetCountry @"http://115.159.227.219:8088/fanfou-api/area/country/%ld"
#define GetCountry @"http://115.159.227.219:8088/fanfou-api/area/country/open/%ld"


/* ------------- 菜场接口 -------------- */
/**
 Get:历史菜场,第几页:page=%ld,第几页截止:page_size=%ld
 */
#define uHHistory @"http://115.159.227.219:8088/fanfou-api/market/history/list?access_token=%@&page=%ld&page_size=%ld"
/**
 Get:通过经纬度搜索菜市场,location=%@
 */
#define uHList @"http://115.159.227.219:8088/fanfou-api/market/list?location=%@"
/**
 Get:通过名称搜索菜场,address=%@,city_id=%ld,county_id=%ld,province_id=%ld
 */
#define uHSearch @"http://115.159.227.219:8088/fanfou-api/market/search?address=%@&city_id=%ld&county_id=%ld&province_id=%ld"

/* ---------========大厨接口==============*/
/*
 Get：获取大厨列表，需要传token，market_id,page,page_size
 返回的有历史大厨列表和推荐大厨列表
 */
#define GetCookList @"http://115.159.227.219:8088/fanfou-api/cooks?access_token=%@&market_id=%@&page=%ld&page_size=%ld"

/**
 *  Get：查询大厨的详细信息，需要cook_id
 *
 */
#define GetCookDetail @"http://115.159.227.219:8088/fanfou-api/cook/%ld"


