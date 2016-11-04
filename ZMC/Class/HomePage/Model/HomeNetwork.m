//
//  HomeNetwork.m
//  ZMC
//
//  Created by MindminiMac on 16/5/9.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "HomeNetwork.h"

#import "ZMCURL.h"
#import "AFManegerHelp.h"
#import "HomeLocationItem.h"
#import "LocationMarketModel.h"
#import "CarouselsModel.h"
#import "SpecialGoodsModel.h"
#import "HotGoodsModel.h"

#import "ZMCURLSecond.h"
#import "SpecialTodayModel.h"
#import "GoodsSearchResultModel.h"

#import <MJExtension.h>
#import "HomeModel.h"

#import "HYBNetworking.h"

#import "ACookModel.h"
#import "CookDetailInfoModel.h"
#import "CookBookModel.h"
#import "ZMCListCaipuItem.h"


@implementation HomeNetwork

/**
 *  根据经纬度发送请求，将请求的菜场信息转成model，存到数组中
 *
 *  @return block中传model数组
 */
+ (void)requestNearbyMarketWithCoordinateLatitude:(CGFloat)latitude andLongitude:(CGFloat)longitude andCompleteBlock:(void (^) (NSArray *))complete
{

    NSString *locationStr = [NSString stringWithFormat:@"%f,%f",latitude,longitude];
    ZMCLog(@"经纬度--->>%f  %f", latitude, longitude);
    NSString *urlStr = [NSString stringWithFormat:uHList,locationStr];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO params:nil success:^(id response) {
        
        if ([response getTheResultForDic]) {
            
            NSMutableArray *array = response[@"result"][@"list"];
            [USER_DEFAULT setObject:response[@"result"][@"location"] forKey:@"HomeLocation"];
            [USER_DEFAULT synchronize];
            [LocationMarketModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"ID":@"id"};
            }];

            NSMutableArray *markets = [LocationMarketModel mj_objectArrayWithKeyValuesArray:array];
            complete(markets);
        
        }else {
            [SVProgressHUD showErrorWithStatus:[response getResultMessage]];
        }
        
    } fail:^(NSError *error) {
        ZMCLog(@"home-network-------%@",error);

    }];
}

/**
 *  根据菜场id发送请求，返回首页的所有数据
 *
 *  @param market_id 菜场id
 */
+ (void)requestHomeInfoAndCompleteBlock:(void(^)(HomeModel *))complete
{
    if (!Market_id) {
        return;
    }
    
//    NSString *urlStr = [NSString stringWithFormat:uHMain,[Market_id longValue]];
    
    [HYBNetworking getWithUrl:uHMain refreshCache:NO success:^(id response) {
        [SpecialGoodsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        [HotGoodsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        [HomeModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goodsSpecialsList":@"SpecialGoodsModel",@"goodsHotList":@"HotGoodsModel",@"carousels":@"CarouselsModel"};
        }];
        HomeModel *model = [HomeModel mj_objectWithKeyValues:response[@"result"]];
        complete (model);
    } fail:^(NSError *error) {
        ZMCLog(@"home-network-------%@",error);

    }];
}


/**
 *  发送请求，获取到今日特价的所有商品
 *
 *  market_id 从userdefault里面取出，不用传
 *
 *  @param complete  用block传递模型数组
 */
+ (void)requestSpecialTodayGoodsWithPage:(long)page andPageSize:(long)page_size andCompleteBlock:(void(^)(NSArray *))complete
{
    if (![self isNeedEstimateToken:NO andMarketId:YES]) {
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:uGSpecials,Market_id,page,page_size];

    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        NSArray *array = response[@"result"][@"data"];
        
        NSMutableArray *specials = [SpecialTodayModel mj_objectArrayWithKeyValuesArray:array];
        
        complete(specials);

    } fail:^(NSError *error) {
        ZMCLog(@"home-network-------%@",error);

    }];
    
}


/**
 *  根据名字搜索商品或者商家，返回结果
 *
 *  @param name      商品或商家的名字
 *
 *  @param complete  请求结果封装成model，存入数组，用block传值
 */
+ (void)requestGoodsWithName:(NSString *)name andPage:(long)page andPageSize:(long)page_size andCompleteBlock:(void(^)(NSMutableArray *))complete
{
    if (![self isNeedEstimateToken:NO andMarketId:YES]) {
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:uGSeach,Market_id,name,page,page_size];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        NSArray *array = response[@"result"][@"data"];
        
        NSMutableArray *goods = [GoodsSearchResultModel mj_objectArrayWithKeyValuesArray:array];
        complete(goods);
        ZMCLog(@"搜索成功1");
    } fail:^(NSError *error) {
        ZMCLog(@"home-network-------%@",error);

    }];
    
}


/**
 *  全局搜索
 */
+ (void)getHomeSearchListWithKeyword:(NSString *)keyword search_type:(NSNumber *)search_type page:(NSNumber *)page page_size:(NSNumber *)page_size listBlock:(void(^)(NSDictionary *))result{
    
//    http://115.159.227.219:8088/fanfou-api/home/search/list?keyword=%@&market_id=%@&search_type=%@&page=%@&page_size=%@
    if (![self isNeedEstimateToken:NO andMarketId:YES]) {
        return;
    }
    NSString *urlStr = [NSString stringWithFormat:getHomeSearchList ,keyword, Market_id, search_type, page, page_size];
    
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
        
        result(response);
        ZMCLog(@"%@", response[@"result"][@"data"]);
        ZMCLog(@"搜索成功2");
    } fail:^(NSError *error) {
        ZMCLog(@"全局搜索--->>%@", error);
    }];
    
}


/**
 *  请求省份列表
 *
 *  @param complete 把请求道的省份列表数组传过去
 */
+ (void)requestProvinceAndCompleteBlock:(void(^)(NSArray *))complete
{
    [HYBNetworking getWithUrl:GetProvince refreshCache:NO success:^(id response) {
        NSArray *array = response[@"result"];
        
        complete(array);
    } fail:^(NSError *error) {
        ZMCLog(@"home_network-------%@",error);

    }];
}

/**
 *  请求城市列表
 *
 *  @param province_id 省份id
 *  @param complete    城市数组
 */
+ (void)requestCityListWithProvince:(long)province_id andCompleteBlock:(void(^)(NSArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:GetCity,province_id];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        NSArray *array = response[@"result"];
        complete(array);

    } fail:^(NSError *error) {
        ZMCLog(@"home_network-------%@",error);

    }];
    }

/**
 *  请求区域列表
 *
 *  @param city_id  城市id
 *  @param complete 区域数组
 */
+ (void)requestCountryListWithCity:(long)city_id andCompleteBlock:(void(^)(NSArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:GetCountry,city_id];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        NSArray *array = response[@"result"];
        complete(array);
        
    } fail:^(NSError *error) {
        ZMCLog(@"home---network--------%@",error);

    }];

}


/**
 *  根据省市区id和名称搜索菜场
 *
 *  @param province_id 省id
 *  @param city_id     市id
 *  @param coutry_id   区id
 *  @param address     名称
 *  @param complete    菜场model数组
 */
+ (void)requestMarketWithProvince:(long)province_id andCity:(long)city_id andCountry:(long)coutry_id andAddress:(NSString *)address andCompleteBlock:(void(^)(NSArray *))complete
{
    NSString *urlStr = [NSString stringWithFormat:uHSearch,address,city_id,coutry_id,province_id];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        
        [LocationMarketModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        
        NSMutableArray *models = [LocationMarketModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"list"]];
        complete(models);
        
    } fail:^(NSError *error) {
        ZMCLog(@"home--network----------%@",error);

    }];
}


/**
 *  请求历史菜场记录
 *
 *  @param page     页数
 *  @param complete 请求到的历史菜场数组
 */
+ (void)requestHistoryMarketsWithPage:(long)page andCompleteBlock:(void(^)(NSArray *))complete
{
    if (!TOKEN) {
        return;
    }

    NSString *urlStr = [NSString stringWithFormat:uHHistory,TOKEN,page,(long)15];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        
//        ZMCLog(@"========%@",response);
        
        [LocationMarketModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        
        NSMutableArray *models = [LocationMarketModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"data"]];
        
        complete(models);
    } fail:^(NSError *error) {
        ZMCLog(@"home_---network---------%@",error);
    }];
}


/**
 *  查询大厨列表，根据token和marketid
 *
 *  @param page     页数
 *  @param complete 请求结束，把历史大厨数组和推荐大厨数组，传过去
 */
+ (void)requestCookListWithPage:(long)page andCompleteBlock:(void(^)(NSArray *,NSArray *))complete
{
    if (![self isNeedEstimateToken:NO andMarketId:YES]) {
        return;
    }
    
    NSString *urlStr = [NSString stringWithFormat:GetCookList,TOKEN,Market_id,page,(long)30];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        
        [ACookModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        if ([response getTheResultForDic]) {
            
            NSMutableArray *array1 = [ACookModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"history_cooks"]];
            
            NSMutableArray *array2 = [ACookModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"recommend_cooks"][@"data"]];
            
            complete(array1,array2);
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[response getResultMessage]];
            
        }
        

    } fail:^(NSError *error) {
        ZMCLog(@"home_-----network--------%@",error);
    }];
}


/**
 *  请求大厨详情
 *
 *  @param cook_id  大厨id
 *  @param complete 大厨详情的model，传过去
 */
+ (void)requestCookDetailWithCook:(NSNumber *)cook_id andCompleteBlock:(void(^)(CookDetailInfoModel *))complete
{
    NSString *urlStr = [NSString stringWithFormat:GetCookDetail,[cook_id longValue]];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
       
        [CookDetailInfoModel  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        
        CookDetailInfoModel *model = [CookDetailInfoModel mj_objectWithKeyValues:response[@"result"]];
        
        NSLog(@"%@", response);
        
        complete(model);

    } fail:^(NSError *error) {
        ZMCLog(@"home_-----network-----------%@",error);
    }];
}

/**
 * 获取拿手菜
 */
+ (void)getCookerOfHisCook_books:(NSNumber *)cookId andComplockBlock:(void(^)(NSArray *)) array {
    
    NSString *urlStr = [NSString stringWithFormat:GetCookDetail,[cookId longValue]];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
        
//        NSDictionary *dict = [NSDictionary new];
        
        NSDictionary *dict = response[@"result"];
        NSArray *cooksArray = dict[@"cook_books"];
//        NSArray *cookArray;
//        for (NSDictionary *dic in cooksArray) {
//            CookBookModel *cookModel = [CookBookModel new];
//            [cookModel setValuesForKeysWithDictionary:dic];
//            NSMutableArray *cookNsmuArray = [NSMutableArray arrayWithCapacity:0];
//            [cookNsmuArray addObject:cookModel];
//            cookArray = cookNsmuArray;
//        }
        array(cooksArray);
        
    } fail:^(NSError *error) {
        
         ZMCLog(@"home_-----network--------%@",error);
    }];
    
}

/**
 *  判断是否需要token或者marketid
 *
 *  @param a 是否需要token
 *  @param b 是否需要marketid
 *
 *  @return 如果返回值是no，就不发送请求
 */
+ (BOOL)isNeedEstimateToken:(BOOL)a andMarketId:(BOOL)b
{
    if (a) {
        if (TOKEN) {
            
        } else {
            ALERT_MSG(@"温馨提示", @"未查到可用的token信息，请重新登录！");
            return NO;
        }
    }
    if (b) {
        if (Market_id) {
            
        } else {
            ALERT_MSG(@"温馨提示", @"请先选择周边的菜场！");
            return NO;
        }
    }
    return YES;
}

/**
 *
 * 雇佣大厨
 *
 */
+ (void)sureOfTheCookerToHome:(NSDictionary *)dict andCompleteBlock:(void(^)(NSString *))complete {
    
    NSString *urlStr = [NSString stringWithFormat:uGIncrease,TOKEN];
    
    [HYBNetworking postWithUrl:urlStr refreshCache:YES params:dict success:^(id response) {
        
        NSString *string = [NSString stringWithFormat:@"%@", response[@"err_msg"]];
        
        complete (string);
        
        NSLog(@"%@", response);
        
    } fail:^(NSError *error) {
        
        NSLog(@"%@", error);
    }];
}

@end
