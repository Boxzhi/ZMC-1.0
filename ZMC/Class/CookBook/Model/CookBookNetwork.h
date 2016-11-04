//
//  CookBookNetwork.h
//  ZMC
//
//  Created by MindminiMac on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BottomCookBookDetailModel;
@interface CookBookNetwork : NSObject

/**
 *  发送请求，获取菜谱的种类
 */
+ (void)requestCookBookCategoryComplete:(void(^)(NSArray *))complete;


/**
 *  根据菜谱分类的id，页数，发送请求，获取该分类下的菜谱列表
 *
 *  @param cateID   菜谱分类的id
 *  @param page     页数
 *  @param pageSize 每一页容量
 *  @param complete 请求结果block传值
 */
+ (void)requestDishListWithCategory:(NSNumber *)cateID andPage:(NSNumber *)page andPageSize:(NSNumber *)pageSize andComplete:(void(^)(NSMutableDictionary *))complete;


/**
 *  根据菜谱的id，请求菜谱详情
 *
 *  @param dishID   菜谱id
 *  @param complete 菜谱的详情model
 */
+ (void)requestDishDetailWithDish:(long)dishID andComplete:(void(^)(BottomCookBookDetailModel *))complete;
@end
