//
//  HttpConfig.h
//  ThailandGo
//
//  Created by Daniel on 15/10/15.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "CommonHttpAPI.h"
#import "CommonRequestModel.h"




//#define ReleaseHost @"http://121.41.101.63:8088"

//#define ReleaseHost @"http://115.159.227.219:8088"
#define ReleaseHost @"http://115.159.227.219:8088" //测试服

//#define ReleaseHost @"http://test.api.ehfarm.com"




/**
 *  登录
 */
#define member_login_url @"/fanfou-api/member/login"

/**
 *  通过名称搜索菜市场
 */
#define market_search_url @"/fanfou-api/market/search"

/**
 *  通过经纬度搜索菜市场
 */
#define market_list_url @"/fanfou-api/market/list"

/**
 *  通过名称搜索商家
 */
#define merchant_search_url @"/fanfou-api/merchant/search"

/**
 *  置换接口调用凭证
 */
#define member_refresh_token_url @"/fanfou-api/member/refresh_token"

/**
 *  首页接口
 */
#define home_main_url @"/fanfou-api/home/main"

/**
 *  全局搜索
 */
#define home_search_url @"/fanfou-api/home/search/list"

/**
 *  活动营养健康列表
 */
#define act_nutrition_list_url @"/fanfou-api/act_nutrition/list"


/**************************   订单部分   *******************************/
/**
 *  获取派送方式
 */
#define order_delivery_url @"/fanfou-api/order/delivery"


/**
 *  下单接口
 */
#define order_save_url @"/fanfou-api/order/save/"

/**
 *  获取支付金额
 */
#define order_price_url @"/fanfou-api/order/get_pay_money"

/**
 *  获取配送时间
 */
#define get_time_url @"/fanfou-api/order/get_time_list"

/**
 *  优惠券校验
 */
#define check_coupon_url @"/fanfou-api/order/check_coupon"

/**
 *  查询优惠券
 */
#define member_coupon_url @"/fanfou-api/member/coupons"


/**************************   收货地址部分   *******************************/
/**
 *  查询默认收货地址
 */
#define address_default_url @"/fanfou-api/member/address/default"


/**************************   商品部分   *******************************/



/**
 *  商品特价列表
 */
#define goods_specials_url @"/fanfou-api/goods/specials"


/**
 *  商品分类列表
 */
#define goods_categories_url @"/fanfou-api/goods/categories"

/**
 *  商品列表
 */
#define goods_list_url @"/fanfou-api/goods/list"

/**
 *  商品详情
 */
#define goods_detail_url @"/fanfou-api/goods/detail"

/**
 *  商品详情
 */
#define goods_detail_url @"/fanfou-api/goods/detail"

/**
 *  商品数量加
 */
#define shopping_cart_increase_url @"/fanfou-api/shopping_cart/increase"

/**
 *  商品数量减
 */
#define shopping_cart_decrease_url @"/fanfou-api/shopping_cart/decrease"

/**
 *  历史商家
 */
#define member_history_url @"/fanfou-api/member/history_merchant"

/**
 *  添加收藏
 */
#define favorite_add_url @"/fanfou-api/favorite/add"

/**
 *  删除收藏
 */
#define favorite_delete_url @"/fanfou-api/favorite/delete"

/**
 *  商品详情
 */
#define goods_detail_url @"/fanfou-api/goods/detail"

/**
 *  购物车商品列表
 */
#define shopping_carts_url @"/fanfou-api/shopping_carts"

/**
 *  订单列表
 */
#define order_list_url @"/fanfou-api/order/list"

/**
 *  取消订单
 */
#define order_cancel_url @"/fanfou-api/order/cancel"

/**
 *  删除订单
 */
#define order_delete_url @"/fanfou-api/order/delete"

/**
 *  订单提醒配送
 */
#define order_reminder_url @"/fanfou-api/order/reminder"

/**
 *  订单详情
 */
#define order_detail_url @"/fanfou-api/order/detail"

/**
 *  新增评论
 */
#define comment_add_url @"/fanfou-api/comment/add"

/**
 *  评论列表
 */
#define comment_list_url @"/fanfou-api/comment/list"

/**
 *  大厨新增评论
 */
#define comment_cook_add_url @"/fanfou-api/comment/cook/add"

/**
 *  大厨评论列表
 */
#define comment_cook_list_url @"/fanfou-api/comment/cook/list"

/**
 *  店铺详情
 */
#define merchant_detail_url @"/fanfou-api/merchant/detail"

/**
 *  确认收货
 */
#define order_finish_url @"/fanfou-api/order/finish"
