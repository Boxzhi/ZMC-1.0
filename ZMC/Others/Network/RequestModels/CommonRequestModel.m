//
//  CommonRequestModel.m
//  ThailandGo
//
//  Created by Daniel on 15/10/15.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "CommonRequestModel.h"

@implementation CommonRequestModel


/**
 *  首页接口
 */
+ (NSMutableDictionary *)getHomeMainWithMarketId:(NSString *)market_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:CHECK_VALUE(market_id) forKey:@"market_id"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  全局搜索
 */
+ (NSMutableDictionary *)getHomeSearchlistWithMarketId:(NSString *)market_id keyword:(NSString *)keyword page:(NSString *)page page_size:(NSString *)page_size search_type:(NSString *)search_type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:CHECK_VALUE(market_id) forKey:@"market_id"];
    [params setObject:keyword forKey:@"keyword"];
    [params setObject:CHECK_VALUE(page) forKey:@"page"];
    [params setObject:CHECK_VALUE(page_size) forKey:@"page_size"];
    [params setObject:CHECK_VALUE(search_type) forKey:@"search_type"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  通过名称搜索菜市场
 */
+ (NSMutableDictionary *)getMarketSearchWithAddress:(NSString *)address city_id:(NSString *)city_id  county_id:(NSString *)county_id  province_id:(NSString *)province_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:address forKey:@"address"];
    [params setObject:city_id forKey:@"city_id"];
    [params setObject:county_id forKey:@"county_id"];
    [params setObject:province_id forKey:@"province_id"];
    
    return [self baseGetInfoFacory:params];

}


/**
 *  通过经纬度搜索菜市场
 */
+ (NSMutableDictionary *)getMarketListWithLocation:(NSString *)location
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:location forKey:@"location"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  通过名称搜索商家
 */
+ (NSMutableDictionary *)getMerchantSearchWithMarket_id:(NSString *)market_id name:(NSString *)name  page:(NSString *)page  page_size:(NSString *)page_size
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:CHECK_VALUE(market_id) forKey:@"market_id"];
    [params setObject:CHECK_VALUE(name) forKey:@"name"];
    [params setObject:CHECK_VALUE(page) forKey:@"page"];
    [params setObject:CHECK_VALUE(page_size) forKey:@"page_size"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  登录
 */
+ (NSMutableDictionary *)getMarketLoginWithMobile:(NSString *)mobile password:(NSString *)password
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:mobile forKey:@"mobile"];
    [params setObject:password forKey:@"password"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  活动营养健康列表
 */
+ (NSMutableDictionary *)getActNutritionListWithPageNO:(NSString *)page page_size:(NSString *)page_size type:(NSString *)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    [params setObject:type forKey:@"type"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  下单接口
 */
+ (NSMutableDictionary *)getOrderSaveWithAddress_id:(NSString *)address_id cook_info:(NSString *)cook_info coupon_id:(NSString *)coupon_id delivery_date:(NSString *)delivery_date delivery_section:(NSString *)delivery_section delivery_way_id:(NSString *)delivery_way_id goods_list:(NSString *)goods_list market_id:(NSString *)market_id remark:(NSString *)remark use_points:(NSString *)use_points
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:CHECK_VALUE(address_id) forKey:@"address_id"];
    [params setObject:CHECK_VALUE(cook_info) forKey:@"cook_info"];
    [params setObject:CHECK_VALUE(coupon_id) forKey:@"coupon_id"];
    [params setObject:CHECK_VALUE(delivery_date) forKey:@"delivery_date"];
    [params setObject:CHECK_VALUE(delivery_section) forKey:@"delivery_section"];
    [params setObject:CHECK_VALUE(delivery_way_id) forKey:@"delivery_way_id"];
    
    [params setObject:goods_list forKey:@"goods_list"];
    [params setObject:CHECK_VALUE(remark) forKey:@"remark"];
    [params setObject:CHECK_VALUE(market_id) forKey:@"market_id"];
    [params setObject:CHECK_VALUE(use_points) forKey:@"use_points"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  获取支付金额
 */
+ (NSMutableDictionary *)getPayMoneyWithCook_info:(NSString *)cook_info coupon_id:(NSString *)coupon_id delivery_way_id:(NSString *)delivery_way_id goods_list:(NSString *)goods_list use_points:(NSString *)use_points market_id:(NSString *)market_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:CHECK_VALUE(cook_info) forKey:@"cook_info"];
    [params setObject:CHECK_VALUE(coupon_id) forKey:@"coupon_id"];
    [params setObject:CHECK_VALUE(delivery_way_id) forKey:@"delivery_way_id"];
    [params setObject:CHECK_VALUE(use_points) forKey:@"use_points"];
    [params setObject:CHECK_VALUE(market_id) forKey:@"market_id"];
    
    [params setObject:goods_list forKey:@"goods_list"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  查询优惠券
 page_no
 page_size
 *
 */
+ (NSMutableDictionary *)getDiscountListWithPageNO:(NSString *)page page_size:(NSString *)page_size{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    
    
    return [self baseGetInfoFacory:params];
}

/**
 *  优惠劵校验
 */
+ (NSMutableDictionary *)getCheckCouponWithCoupon_id:(NSString *)coupon_id delivery_way_id:(NSString *)delivery_way_id list:(NSString *)list
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:CHECK_VALUE(coupon_id) forKey:@"coupon_id"];
    [params setObject:CHECK_VALUE(delivery_way_id) forKey:@"delivery_way_id"];
    
    [params setObject:list forKey:@"list"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  商品特价列表
 */
+ (NSMutableDictionary *)getGoodsSpecialstWithMarket_id:(NSString *)market_id pageNO:(NSString *)page page_size:(NSString *)page_size
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:market_id forKey:@"market_id"];
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  获取商品列表数据
 */
+ (NSMutableDictionary *)getGoodsListInfoWithPageNO:(NSString *)page page_size:(NSString *)page_size category_id:(NSString *)category_id market_id:(NSString *)market_id merchant_id:(NSString *)merchant_id sale_sort:(NSString *)sale_sort
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    

    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    [params setObject:category_id forKey:@"category_id"];
    [params setObject:CHECK_VALUE(market_id) forKey:@"market_id"];
    [params setObject:merchant_id forKey:@"merchant_id"];
    [params setObject:sale_sort forKey:@"sale_sort"];


    
    
    return [self baseGetInfoFacory:params];
}

/**
 *  历史商家
 */
+ (NSMutableDictionary *)getMemberHistoryWithPageNO:(NSString *)page page_size:(NSString *)page_size
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (Market_id == nil) {
        [params setObject:page forKey:@"page"];
        [params setObject:page_size forKey:@"page_size"];
        
    }else{
        
        [params setObject:Market_id forKey:@"market_id"];
        [params setObject:page forKey:@"page"];
        [params setObject:page_size forKey:@"page_size"];
    }
    
    
    return [self baseGetInfoFacory:params];
}

/**
 *  商品数量加
 */
+ (NSMutableDictionary *)getGoodsIncreaseryWithItem_id:(NSString *)item_id quantity:(NSString *)quantity start_time:(NSString *)start_time type:(NSString *)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:item_id forKey:@"item_id"];
    [params setObject:quantity forKey:@"quantity"];
    [params setObject:start_time forKey:@"start_time"];
    [params setObject:type forKey:@"type"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  商品数量减
 */
+ (NSMutableDictionary *)getGoodsDecreaseryWithItem_id:(NSString *)item_id quantity:(NSString *)quantity type:(NSString *)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:item_id forKey:@"item_id"];
    [params setObject:quantity forKey:@"quantity"];
    [params setObject:type forKey:@"type"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  添加收藏
 */
+ (NSMutableDictionary *)getFavoriteAddWithFav_id:(NSString *)fav_id type:(NSString *)type
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:fav_id forKey:@"fav_id"];
    [params setObject:type forKey:@"type"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  删除收藏
 */
+ (NSMutableDictionary *)getFavoriteDeleteWithFav_id:(NSString *)fav_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:fav_id forKey:@"fav_id"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  购物车商品列表
 */
+ (NSMutableDictionary *)getShoppongCartsWithPageNO:(NSString *)page page_size:(NSString *)page_size
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (Market_id == nil) {
        
        [params setObject:page forKey:@"page"];
        [params setObject:page_size forKey:@"page_size"];
        
    }else{
        
        [params setObject:Market_id forKey:@"market_id"];
        [params setObject:page forKey:@"page"];
        [params setObject:page_size forKey:@"page_size"];
    }
    

    return [self baseGetInfoFacory:params];
}

/**
 *  订单列表
 */
+ (NSMutableDictionary *)getOrderListWithOrder_status:(NSString *)order_status pageNO:(NSString *)page page_size:(NSString *)page_size
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:order_status forKey:@"order_status"];
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  取消订单
 */
+ (NSMutableDictionary *)getOrderCancelWithCook_id:(NSString *)cook_id merchant_id:(NSString *)merchant_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:cook_id forKey:@"cook_id"];
    [params setObject:merchant_id forKey:@"merchant_id"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  新增评论
 */
+ (NSMutableDictionary *)getommentAddInfoWithContent:(NSString *)content WithGoodsID:(NSString *)goods_id WithLabels:(NSArray *)labels WithParentID:(NSString *)parent_id WithPics:(NSString *)pics WithScore:(NSString *)score WithOrderID:(NSString *)order_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:content forKey:@"content"];
    [params setObject:goods_id forKey:@"goods_id"];
    [params setObject:labels forKey:@"labels"];
    [params setObject:parent_id forKey:@"parent_id"];
    [params setObject:pics forKey:@"pics"];
    [params setObject:score forKey:@"score"];
    [params setObject:order_id forKey:@"order_id"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  大厨新增评论
 */
+ (NSMutableDictionary *)getommentCookAddInfoWithContent:(NSString *)content WithCookID:(NSString *)cook_id WithLabels:(NSArray *)labels WithParentID:(NSString *)parent_id WithPics:(NSString *)pics WithScore:(NSString *)score WithOrderID:(NSString *)order_id
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:content forKey:@"content"];
    [params setObject:cook_id forKey:@"cook_id"];
    [params setObject:labels forKey:@"labels"];
    [params setObject:parent_id forKey:@"parent_id"];
    [params setObject:pics forKey:@"pics"];
    [params setObject:score forKey:@"score"];
    [params setObject:order_id forKey:@"order_id"];
    
    return [self baseGetInfoFacory:params];

}

/**
 *  评论列表
 */
+ (NSMutableDictionary *)getCommentListWithPageNO:(NSString *)page page_size:(NSString *)page_size status:(NSString *)status
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:status forKey:@"status"];
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    
    return [self baseGetInfoFacory:params];
}

/**
 *  大厨评论列表
 */
+ (NSMutableDictionary *)getCommentCookListWithPageNO:(NSString *)page page_size:(NSString *)page_size status:(NSString *)status
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:status forKey:@"status"];
    [params setObject:page forKey:@"page"];
    [params setObject:page_size forKey:@"page_size"];
    
    return [self baseGetInfoFacory:params];
}

@end
