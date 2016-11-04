//
//  CommonHttpAPI.m
//  ThailandGo
//
//  Created by Daniel on 15/10/15.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "CommonHttpAPI.h"
#import "HttpConfig.h"

@implementation CommonHttpAPI


/**
 *  首页接口
 */
+ (void)getHomeMainWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
        [[self sharedManager] defaultGetWithMethod:[self getUrl:home_main_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  全局搜索
 */
+ (void)getHomeSearchListWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:home_search_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  通过名称搜索菜市场
 */
+ (void)getMarketSearchWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:market_search_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  通过经纬度搜索菜市场
 */
+ (void)getMarketListWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:market_list_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  通过名称搜索商家
 */
+ (void)getMerchantSearchWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:merchant_search_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  登陆
 */
+ (void)postMemberLoginInfoWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
{
    [[self sharedManager] defaultPostWithUrl:[self postUrl:member_login_url addEspecid:nil needToken:NO] WithParameters:parameters success:success failure:failure];
}

/**
 *  置换接口调用凭证
 */
+ (void)getLoginRefreshTokenWithMethod:(NSString *)method WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[member_refresh_token_url stringByAppendingString:[NSString stringWithFormat:@"?refresh_token=%@",method]] WithParameters:parameters success:success failure:failure];
}


/**
 *  活动营养健康列表
 */
+ (void)getActNutritionListWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:act_nutrition_list_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  获取派送方式
 */
+ (void)getOrderDeliveryInfoWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
//    [[self sharedManager] defaultPostWithUrl:[self postUrl:order_delivery_url addEspecid:nil needToken:NO] WithParameters:parameters success:success failure:failure];
    [[self sharedManager] defaultGetWithMethod:[self getUrl:order_delivery_url addEspecid:nil needToken:NO params:nil] WithParameters:parameters success:success failure:failure];
}

/**
 *  提交订单
 */
+ (void)postSaveOrderInfoWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self postUrl:order_save_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  获取支付金额
 */
+ (void)getPayMoneyWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:order_price_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  获取配送时间列表
 */
+ (void)getOrderGetTimeWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:get_time_url addEspecid:nil needToken:NO params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 *  查询优惠券
 */
+ (void)getMemberCouponsWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:member_coupon_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  优惠券校验
 */
+ (void)getCheckCouponsWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:check_coupon_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  查询默认收货地址
 */
+ (void)getAddressDefaultWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:address_default_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  商品特价列表
 */
+ (void)getGoodsSpecialsWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:goods_specials_url addEspecid:nil needToken:NO params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 *  商品分类列表
 */
+ (void)getGoodsCategoriesWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSString *strUrl = [NSString stringWithFormat:@"%@?market_id=%@", goods_categories_url, Market_id];
    [[self sharedManager] defaultGetWithMethod:[self getUrl:strUrl addEspecid:nil needToken:NO params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 *  商品列表
 */
+ (void)getGoodsListWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{

        if (![UserInfo isLogin]) {
            [[self sharedManager] defaultGetWithMethod:[self getUrl:goods_list_url addEspecid:nil needToken:NO params:parameters] WithParameters:parameters success:success failure:failure];
        }else{
            [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
                [[self sharedManager] defaultGetWithMethod:[self getUrl:goods_list_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
            }];
        }

    

}

/**
 *  历史商家
 */
+ (void)getMemberHistoryWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:member_history_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  商品数量加
 */
+ (void)postGoodsIncreaseWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self postUrl:shopping_cart_increase_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  商品数量减
 */
+ (void)postGoodsDecreaseWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self postUrl:shopping_cart_decrease_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 * 添加收藏
 */
+ (void)postFavoriteAddWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self postUrl:favorite_add_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 * 删除收藏
 */
+ (void)postFavoriteDeleteWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self postUrl:favorite_delete_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  商品详情
 */
+ (void)getGoodsDetailWithMethod:(NSString *)method WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:goods_detail_url addEspecid:method needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 *  购物车商品列表
 */
+ (void)getShoppingCartsWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:shopping_carts_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  订单列表
 */
+ (void)getOrderListWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultGetWithMethod:[self getUrl:order_list_url addEspecid:nil needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
    }];

}

/**
 *  取消订单
 *
 */
+ (void)postCancelOrderWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self getUrl:order_cancel_url addEspecid:especid needToken:YES params:parameters] WithParameters:nil success:success failure:failure];
//        [[self sharedManager] defaultPostWithUrl:[self postUrl:order_cancel_url addEspecid:especid needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
    
}

/**
 *  删除订单
 *
 */
+ (void)postDeleteOrderWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        [[self sharedManager] defaultPostWithUrl:[self getUrl:order_delete_url addEspecid:especid needToken:YES params:nil] WithParameters:nil success:success failure:failure];
        //        [[self sharedManager] defaultPostWithUrl:[self postUrl:order_cancel_url addEspecid:especid needToken:YES] WithParameters:parameters success:success failure:failure];
    }];
}

/**
 *  订单提醒配送
 *
 */
+ (void)postReminderOrderWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultPostWithUrl:[self postUrl:order_reminder_url addEspecid:especid needToken:YES] WithParameters:parameters success:success failure:failure];
}

/**
 *  订单详情
 */
+ (void)getOrderDetailWithEspecId:(NSString *)especid lWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:order_detail_url addEspecid:especid needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 * 新增评论
 */
+ (void)postCommentAddWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultPostWithUrl:[self postUrl:comment_add_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
}

/**
 * 大厨新增评论
 */
+ (void)postCommentCookAddWithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultPostWithUrl:[self postUrl:comment_cook_add_url addEspecid:nil needToken:YES] WithParameters:parameters success:success failure:failure];
}

/**
 *  评论列表
 */
+ (void)getCommentListWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:comment_list_url addEspecid:especid needToken:NO params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 *  大厨评论列表
 */
+ (void)getCommentCookListWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:comment_cook_list_url addEspecid:especid needToken:NO params:parameters] WithParameters:parameters success:success failure:failure];
}


/**
 *  店铺详情
 */
+ (void)getMercantDetailWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultGetWithMethod:[self getUrl:merchant_detail_url addEspecid:especid needToken:YES params:parameters] WithParameters:parameters success:success failure:failure];
}

/**
 *  确认收货
 *
 */
+ (void)postOrderFinishWithEspecId:(NSString *)especid WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [[self sharedManager] defaultPostWithUrl:[self postUrl:order_finish_url addEspecid:especid needToken:YES] WithParameters:parameters success:success failure:failure];
}

@end
