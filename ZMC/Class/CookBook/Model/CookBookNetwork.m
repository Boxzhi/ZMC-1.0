//
//  CookBookNetwork.m
//  ZMC
//
//  Created by MindminiMac on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "CookBookNetwork.h"
#import "ZMCThird.h"
#import "AFManegerHelp.h"
#import "CookBookCategoryModel.h"
#import "BottomCookBookModel.h"
#import "BottomCookBookDetailModel.h"

#import <MJExtension.h>
#import "HYBNetworking.h"

@implementation CookBookNetwork

/**
 *  发送请求，获取菜谱的种类
 */
+ (void)requestCookBookCategoryComplete:(void(^)(NSArray *))complete
{
    [HYBNetworking getWithUrl:uCCate refreshCache:YES success:^(id response) {
        [CookBookCategoryModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        
        NSMutableArray *categories = [CookBookCategoryModel mj_objectArrayWithKeyValuesArray:response[@"result"]];
        
        complete(categories);
        
    } fail:^(NSError *error) {
        ZMCLog(@"cookbook-network------%@",error);

    }];
    
    
}


/**
 *  根据菜谱分类的id，页数，发送请求，获取该分类下的菜谱列表
 *
 *  @param cateID   菜谱分类的id
 *  @param page     页数
 *  @param pageSize 每一页容量
 *  @param complete 请求结果block传值
 */
+ (void)requestDishListWithCategory:(NSNumber *)cateID andPage:(NSNumber *)page andPageSize:(NSNumber *)pageSize andComplete:(void(^)(NSMutableDictionary *))complete
{
    NSString *urlStr = [NSString stringWithFormat:uCList, cateID, page, pageSize];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
        [BottomCookBookModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        
        if (![response[@"err_msg"] isEqualToString:@"OK"]) {
            [SVProgressHUD showErrorWithStatus:response[@"err_msg"]];
        }else{
//            NSMutableArray *bottoms = [BottomCookBookModel mj_objectArrayWithKeyValuesArray:response[@"result"][@"data"]];
            
            complete (response[@"result"]);
        }

    } fail:^(NSError *error) {
        ZMCLog(@"cookbook-network-------%@",error);

    }];
    
}


/**
 *  根据菜谱的id，请求菜谱详情
 *
 *  @param dishID   菜谱id
 *  @param complete 菜谱的详情model
 */
+ (void)requestDishDetailWithDish:(long)dishID andComplete:(void(^)(BottomCookBookDetailModel *))complete
{
    NSString *urlStr = [NSString stringWithFormat:uCDetail,dishID];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
        [BottomCookBookDetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"ID":@"id"};
        }];
        [BottomCookBookDetailModel  mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"foodmaterials":@"CookBookDetailFoodMaterialModel"};
        }];
        
        BottomCookBookDetailModel *model = [BottomCookBookDetailModel mj_objectWithKeyValues:response[@"result"]];
        
        complete(model);

    } fail:^(NSError *error) {
        ZMCLog(@"cookbook-network-------%@",error);

    }];
    }
@end
