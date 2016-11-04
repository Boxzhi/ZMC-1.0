//
//  ZMCURLSecond.h
//  ZMC
//
//  Created by Ljun on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#ifndef ZMCURLSecond_h
#define ZMCURLSecond_h


#endif /* ZMCURLSecond_h */

#pragma market ------------- 商品接口

/* ---------- 今日特价列表 ----------- */
/**
 Get:今日特价,菜场id:market_id=%ld,页码:page=%ld,每页数据量:page_size=%ld
 */
#define uGSpecials @"http://115.159.227.219:8088/fanfou-api/goods/specials?market_id=%@&page=%ld&page_size=%ld"
/**
 Get:热门商品,菜场id:market_id=%ld,页码:page=%ld,每页数据量:page_size=%ld
 */
#define uGHot @"http://115.159.227.219:8088/fanfou-api/goods/hot?market_id=%ld&page=%ld&page_size=%ld"

/* ------------ 商品信息 ----------- */
/**
 Get:商品分类列表
 */
#define uGCategories @"http://115.159.227.219:8088/fanfou-api/goods/categories"
/**
 Get:商品列表,分类编号:category_id=%ld,菜场id:market_id=%ld,页码:page=%ld,每页数量:page_size=%ld,热销排序:sale_sort=%@(传"ASC"或"DESC")
 */
#define uGList @"http://115.159.227.219:8088/fanfou-api/goods/list?category_id=%ld&market_id=%ld&page=%ld&page_size=%ld&sale_sort=%@"
/**
 Get:商品详情,商品id:id=%ld
 */
#define uGDetail @"http://115.159.227.219:8088/fanfou-api/goods/detail/%ld?access_token=%@"

/* ---------------- 购物车接口 ------------- */
/**
 Get:购物车商品列表,页码:page=%ld, 每页数据量:page_size=%ld
 */
#define uGCart @"http://115.159.227.219:8088/fanfou-api/shopping_carts?access_token=%@&page=%ld&page_size=%ld"
/**
 Post:删除商品,商品编号:ids=%ld (可为数组)
 */
#define uGDelete @"http://115.159.227.219:8088/fanfou-api/shopping_cart/delete?access_token=%@"
/**
 Post:添加商品数量,商品(大厨)编号:item_id=%@,变化数量:quantity=%@,类型:type=%@(1 商品 2 大厨）
 */
#define uGIncrease @"http://115.159.227.219:8088/fanfou-api/shopping_cart/increase?access_token=%@"
/**
 Post:商品数量减少,商品(大厨)编号:item_id=%@,变化数量:quantity=%@,类型:type=%@(1 商品 2 大厨)
 */
#define uGDecrease @"http://115.159.227.219:8088/fanfou-api/shopping_cart/decrease?access_token=%@"

/* ---------- 我的收藏 ---------- */
/**
 Get:收藏列表
 */
#define uGFavorite @"http://115.159.227.219:8088/fanfou-api/favorite/list?access_token=%@"
/**
 Post:添加收藏,商品id:fav_id=%ld
 */
#define uGFavoriteAdd @"http://115.159.227.219:8088/fanfou-api/favorite/add?access_token=%@"
/**
 Post:删除收藏,商品id:fav_id=%ld
 */
#define uGFavoriteDelete @"http://115.159.227.219:8088/fanfou-api/favorite/delete?access_token=%@"

/* ----------- 可能喜欢的商品 ------------- */
/**
 Get:可能喜欢
 */
#define uGRecommend @"http://115.159.227.219:8088/fanfou-api/goods/recommend"

/* ------------ 搜索商品 ------------- */
/**
 Get:通过名称搜索商品列表,菜场id:market_id=%ld,名称:name=%@,页码:page=%ld,每页数量:page_size=%ld
 */
#define uGSeach @"http://115.159.227.219:8088/fanfou-api/goods/search?market_id=%@&name=%@&page=%ld&page_size=%ld"
/**
 Get:热门关键字列表
 */
#define uGSeachHot @"http://115.159.227.219:8088/fanfou-api/goods/hot_key"

/**
 *  全局搜索
 */
#define getHomeSearchList @"http://115.159.227.219:8088/fanfou-api/home/search/list?keyword=%@&market_id=%@&search_type=%@&page=%@&page_size=%@"

/* ------------ 商品评论 ----------- */
/**
 Post:新增评论,评论内容:content=%@,商品id:goods_id=%ld,labels=array,评论标签id:id=%@,主评论id:parent_id=%ld(如果在完成订单处评论，parent_id为0),图片集:pics=%@(如:/img/a/4d/4b/a4d4b56a2cc7631515.png,/img/1/3e/c0/13ec056a2cb6035ec5.png),评分:score=%ld
 */
#define uGCommentAdd @"http://115.159.227.219:8088/fanfou-api/comment/add?access_token=%@"
/**
 Get:评论列表,商品id:goods_id=%ld,页码:page=%ld,每页数量:page_size=%ld,评价类型:status=%ld(1:全部;2：好评;3：中评;4：差评;5：晒单)
 */
#define uGCommentList @"http://115.159.227.219:8088/fanfou-api/comment/list/%ld?page=%ld&page_size=%ld&status=%ld"
/**
 Get:标签列表,标签样式:status=%ld(1:"商品存储方式" ;2:"支持服务";3:"商品活动";4:"评论标签")
 */
#define uGLabelList @"http://115.159.227.219:8088/fanfou-api/label/list?status=%ld"

/* ------------- 活动模板 ----------- */
/**
 Get:活动模块列表,页码:page=%ld,每页显示数量:page_size=%ld
 */
#define uGActivityList @"http://115.159.227.219:8088/fanfou-api/activity/list?page=%ld&page_size=%ld"
/**
 Get:活动商品接口,页码:page=%ld,每页显示数量:page_size=%ld
 */
#define uGActivityGoods @"http://115.159.227.219:8088/fanfou-api/activity/goods/%ld?page=%ld&page_size=%ld"
/**
 Get:搜索关键字列表
 */
#define uGSeachList @"http://115.159.227.219:8088/fanfou-api/search/list"
/**
 Post:保存关键字,商品id:goods_id=%ld
 */
#define uGSeachAdd @"http://115.159.227.219:8088/fanfou-api/search/add/%ld"


#pragma market -------------- 订单接口

/* ---------------- 订单 -------------- */
/**
 Get:订单列表查询,订单状态:order_status=%ld,当前页码:page=%ld,分页数:page_size=%ld
 */
#define uOOrderList @"http://115.159.227.219:8088/fanfou-api/order/list?access_token=%@&order_status=%ld&page=%ld&page_size=%ld"
/**
 Get:订单状态流程,订单id:order_id=%ld
 */
#define uOOrderLog @"http://115.159.227.219:8088/fanfou-api/order/log/%ld?access_token=%@"
/**
 Post:取消订单,订单id:id=%ld
 */
#define uOOrderCancel @"http://115.159.227.219:8088/fanfou-api/order/cancel/%ld?access_token=%@"
/**
 Post:删除订单,订单id:id=%ld
 */
#define uOOrderDelete @"http://115.159.227.219:8088/fanfou-api/order/delete/%ld?access_token=%@"
/**
 Get:获取派送方式
 */
#define uOOrderDelivery @"http://115.159.227.219:8088/fanfou-api/order/delivery"
/**
 Post:提交订单,用户地址:address_id=%ld,厨师信息:cook_info=%@(数据格式：厨师id,小时),优惠券id:coupon_id=%ld(非必填),配送日期:delivery_date=%@,配送时间段:delivery_section=%@,配送方式id:delivery_way_id=%ld,list格式:goods_list=%@(商品数据格式: 商家id,商品id,商品数量; 商家id,商品id,商品数量),菜场ID:market_id=%ld,备注:remark=%@,使用积分:use_points=%ld(使用的积分)
 */
#define uOOrderSave @"http://115.159.227.219:8088/fanfou-api/order/save?access_token=%@"
/**
 Get:获取支付金额,厨师信息:cook_info=%@(拼装格式: 厨师id,小时(100,3)),优惠券id:coupon_id=%ld(非必填),派送方式id:delivery_way_id=%ld(非必填),商品信息:goods_list=%@(拼装格式: 商家id,商品id,个数; 商家id,商品id,个数(2001,121,3;2002,122,4)),使用积分:use_points=%ld(非必填)
 */
#define uOOrderGetPay @"http://115.159.227.219:8088/fanfou-api/order/get_pay_money?access_token=%@&cook_info=%@&coupon_id=%ld&delivery_way_id=%ld&goods_list=%@&use_points=%ld"
/**
 Get:优惠券校验,优惠券id:coupon_id=%ld(必填),派送方式id:delivery_way_id=%ld(必填),list格式:list=%@(必填,商品id,个数; 商品id,个数)
 */
#define uOOrderCheck @"http://115.159.227.219:8088/fanfou-api/order/check_coupon?access_token=%@&coupon_id=%ld&delivery_way_id=%ld&list=%@"
/**
 Get:获取配送时间
 */
#define uOOrderGetTime @"http://115.159.227.219:8088/fanfou-api/order/get_time_list"
/**
 Get:订单详情
 */
#define uOOrderGetDetail @"http://115.159.227.219:8088/fanfou-api/order/detail/{id}?access_token=%@"

/* --------------- 充值接口 -------------*/
/**
 Get:获取充值金额列表
 */
#define uORechargePrepaid @"http://115.159.227.219:8088/fanfou-api/recharge/prepaid?access_token=%@"
/**
 Get:获取充值数据,用户id:memberId=%ld,充值金额:money=%ld
 */

#define uORechargeGetChange @"http://115.159.227.219:8088/fanfou-api/recharge/get_recharge?access_token=%@&money=%@"
/**
 Get:根据经纬度搜索柜子,传"lat,lng":location=%@(比如:31.294453,120.748546)
 */
#define uOOrderCabinet @"http://115.159.227.219:8088/fanfou-api/order/cabinet_list?location=%@"
/**
 Get:通过名称搜索柜子,地址:address=%@
 */
#define uOOrderSeach_cabinet @"http://115.159.227.219:8088/fanfou-api/order/search_cabinet?address=%@"

/* ------------ 人工接口 ----------- */
/**
 Get:物流人工订单查询,订单状态:delivery_status=%ld(若为空,则查询所有的订单(不包含已删除的) 1:待打包 2:待接单 3: 待配送 4: 配送中 5: 已配送 6: 已完成),当前页码:page=%ld(默认1),分页数:page_size=%ld(默认15条)
 */
#define uOPOrderList @"http://115.159.227.219:8088/fanfou-api/order/list?access_token=%@&delivery_status=%ld&page=%ld&page_size=%ld"
/**
 Post:人工接单,订单id:id=%ld
 */
#define uOWorkerOrder @"http://115.159.227.219:8088/fanfou-api/worker/order/accept/%ld?access_token=%@"
/**
 Post:人工派单,订单id:id=%ld
 */
#define uOWorkerOrderDelivery @"http://115.159.227.219:8088/fanfou-api/worker/order/delivery/{order_id}/{bar_code}?access_token=***"





