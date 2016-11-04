//
//  CommonRequestModel.h
//  ThailandGo
//
//  Created by Daniel on 15/10/15.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "BaseRequestParamsModel.h"

@interface CommonRequestModel : BaseRequestParamsModel

/**
 *  首页接口
 */
+ (NSMutableDictionary *)getHomeMainWithMarketId:(NSString *)market_id;

/**
 *  全局搜索
 */
+ (NSMutableDictionary *)getHomeSearchlistWithMarketId:(NSString *)market_id keyword:(NSString *)keyword page:(NSString *)page page_size:(NSString *)page_size search_type:(NSString *)search_type;

/**
 *  通过名称搜索菜市场
 */
+ (NSMutableDictionary *)getMarketSearchWithAddress:(NSString *)address city_id:(NSString *)city_id  county_id:(NSString *)county_id  province_id:(NSString *)province_id;

/**
 *  通过经纬度搜索菜市场
 */
+ (NSMutableDictionary *)getMarketListWithLocation:(NSString *)location;

/**
 *  通过名称搜索商家
 */
+ (NSMutableDictionary *)getMerchantSearchWithMarket_id:(NSString *)market_id name:(NSString *)name  page:(NSString *)page  page_size:(NSString *)page_size;

/**
 *  登录
 */
+ (NSMutableDictionary *)getMarketLoginWithMobile:(NSString *)mobile password:(NSString *)password;


/**
 *  活动营养健康列表
 */
+ (NSMutableDictionary *)getActNutritionListWithPageNO:(NSString *)page page_size:(NSString *)page_size type:(NSString *)type;

/**
 *  下单接口
 */
+ (NSMutableDictionary *)getOrderSaveWithAddress_id:(NSString *)address_id cook_info:(NSString *)cook_info coupon_id:(NSString *)coupon_id delivery_date:(NSString *)delivery_date delivery_section:(NSString *)delivery_section delivery_way_id:(NSString *)delivery_way_id goods_list:(NSString *)goods_list market_id:(NSString *)market_id remark:(NSString *)remark use_points:(NSString *)use_points;

/**
 *  获取支付金额
 */
+ (NSMutableDictionary *)getPayMoneyWithCook_info:(NSString *)cook_info coupon_id:(NSString *)coupon_id delivery_way_id:(NSString *)delivery_way_id goods_list:(NSString *)goods_list use_points:(NSString *)use_points market_id:(NSString *)market_id;

/**
 *  查询优惠券
 page_no
 page_size
 *
 */
+ (NSMutableDictionary *)getDiscountListWithPageNO:(NSString *)page page_size:(NSString *)page_size;

/**
 *  优惠劵校验
 */
+ (NSMutableDictionary *)getCheckCouponWithCoupon_id:(NSString *)coupon_id delivery_way_id:(NSString *)delivery_way_id list:(NSString *)list;

/**
 *  商品特价列表
 */
+ (NSMutableDictionary *)getGoodsSpecialstWithMarket_id:(NSString *)market_id pageNO:(NSString *)page page_size:(NSString *)page_size;


/**
 *  获取商品列表数据
 */
+ (NSMutableDictionary *)getGoodsListInfoWithPageNO:(NSString *)page page_size:(NSString *)page_size category_id:(NSString *)category_id market_id:(NSString *)market_id merchant_id:(NSString *)merchant_id sale_sort:(NSString *)sale_sort;

/**
 *  历史商家
 */
+ (NSMutableDictionary *)getMemberHistoryWithPageNO:(NSString *)page page_size:(NSString *)page_size;

/**
 *  商品数量加
 */
+ (NSMutableDictionary *)getGoodsIncreaseryWithItem_id:(NSString *)item_id quantity:(NSString *)quantity start_time:(NSString *)start_time type:(NSString *)type;

/**
 *  商品数量减
 */
+ (NSMutableDictionary *)getGoodsDecreaseryWithItem_id:(NSString *)item_id quantity:(NSString *)quantity type:(NSString *)type;

/**
 *  添加收藏
 */
+ (NSMutableDictionary *)getFavoriteAddWithFav_id:(NSString *)fav_id type:(NSString *)type;

/**
 *  删除收藏
 */
+ (NSMutableDictionary *)getFavoriteDeleteWithFav_id:(NSString *)fav_id;

/**
 *  购物车商品列表
 */
+ (NSMutableDictionary *)getShoppongCartsWithPageNO:(NSString *)page page_size:(NSString *)page_size;

/**
 *  订单列表
 */
+ (NSMutableDictionary *)getOrderListWithOrder_status:(NSString *)order_status pageNO:(NSString *)page page_size:(NSString *)page_size;

/**
 *  取消订单
 */
+ (NSMutableDictionary *)getOrderCancelWithCook_id:(NSString *)cook_id merchant_id:(NSString *)merchant_id ;

/**
 *  新增评论
 */
+ (NSMutableDictionary *)getommentAddInfoWithContent:(NSString *)content WithGoodsID:(NSString *)goods_id WithLabels:(NSArray *)labels WithParentID:(NSString *)parent_id WithPics:(NSString *)pics WithScore:(NSString *)score WithOrderID:(NSString *)order_id;

/**
 *  大厨新增评论
 */
+ (NSMutableDictionary *)getommentCookAddInfoWithContent:(NSString *)content WithCookID:(NSString *)cook_id WithLabels:(NSArray *)labels WithParentID:(NSString *)parent_id WithPics:(NSString *)pics WithScore:(NSString *)score WithOrderID:(NSString *)order_id;

/**
 *  评论列表
 */
+ (NSMutableDictionary *)getCommentListWithPageNO:(NSString *)page page_size:(NSString *)page_size status:(NSString *)status;

/**
 *  大厨评论列表
 */
+ (NSMutableDictionary *)getCommentCookListWithPageNO:(NSString *)page page_size:(NSString *)page_size status:(NSString *)status;

@end
