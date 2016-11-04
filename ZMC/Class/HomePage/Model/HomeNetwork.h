//
//  HomeNetwork.h
//  ZMC
//
//  Created by MindminiMac on 16/5/9.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeModel;
@class CookDetailInfoModel;
@interface HomeNetwork : NSObject

/**
 *  根据经纬度发送请求，将请求的菜场信息转成model，存到数组中
 *
 *  @return block中传model数组
 */
+ (void)requestNearbyMarketWithCoordinateLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude andCompleteBlock:(void (^) (NSArray *))complete;

/**
 *  根据菜场id发送请求，返回首页的所有数据
 *
 *  @param market_id 菜场id
 */
+ (void)requestHomeInfoAndCompleteBlock:(void(^)(HomeModel *))complete;

/**
 *  发送请求，获取到今日特价的所有商品
 *
 *  market_id 从userdefault里面取出，不用传
 *
 *  @param complete  用block传递模型数组
 */
+ (void)requestSpecialTodayGoodsWithPage:(long)page andPageSize:(long)page_size andCompleteBlock:(void(^)(NSArray *))complete;

/**
 *  根据名字搜索商品或者商家，返回结果
 *
 *  @param name      商品或商家的名字
 *
 *  @param complete  请求结果封装成model，存入数组，用block传值
 */
+ (void)requestGoodsWithName:(NSString *)name andPage:(long)page andPageSize:(long)page_size andCompleteBlock:(void(^)(NSMutableArray *))complete;


/**
 *  请求省份列表
 *
 *  @param complete 把请求道的省份列表数组传过去
 */
+ (void)requestProvinceAndCompleteBlock:(void(^)(NSArray *))complete;


/**
 *  请求城市列表
 *
 *  @param province_id 省份id
 *  @param complete    城市数组
 */
+ (void)requestCityListWithProvince:(long)province_id andCompleteBlock:(void(^)(NSArray *))complete;


/**
 *  请求区域列表
 *
 *  @param city_id  城市id
 *  @param complete 区域数组
 */
+ (void)requestCountryListWithCity:(long)city_id andCompleteBlock:(void(^)(NSArray *))complete;


/**
 *  根据省市区id和名称搜索菜场
 *
 *  @param province_id 省id
 *  @param city_id     市id
 *  @param coutry_id   区id
 *  @param address     名称
 *  @param complete    菜场model数组
 */
+ (void)requestMarketWithProvince:(long)province_id andCity:(long)city_id andCountry:(long)coutry_id andAddress:(NSString *)address andCompleteBlock:(void(^)(NSArray *))complete;



/**
 *  请求历史菜场记录
 *
 *  @param page     页数
 *  @param complete 请求到的历史菜场数组
 */
+ (void)requestHistoryMarketsWithPage:(long)page andCompleteBlock:(void(^)(NSArray *))complete;


/**
 *  查询大厨列表，根据token和marketid
 *
 *  @param page     页数
 *  @param complete 请求结束，把历史大厨数组和推荐大厨数组，传过去
 */
+ (void)requestCookListWithPage:(long)page andCompleteBlock:(void(^)(NSArray *,NSArray *))complete;


/**
 *  请求大厨详情
 *
 *  @param cook_id  大厨id
 *  @param complete 大厨详情的model，传过去
 */
+ (void)requestCookDetailWithCook:(NSNumber *)cook_id andCompleteBlock:(void(^)(CookDetailInfoModel *))complete;

/**
 * 获取拿手菜
 */
+ (void)getCookerOfHisCook_books:(NSNumber *)cookId andComplockBlock:(void(^)(NSArray *)) array;

/**
 *
 * 雇佣大厨
 *
 */
+ (void)sureOfTheCookerToHome:(NSDictionary *)dict andCompleteBlock:(void(^)(NSString *))complete;

/**
 *  全局搜索
 */
+ (void)getHomeSearchListWithKeyword:(NSString *)keyword search_type:(NSNumber *)search_type page:(NSNumber *)page page_size:(NSNumber *)page_size listBlock:(void(^)(NSDictionary *))result;


@end
