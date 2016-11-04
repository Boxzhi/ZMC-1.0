//
//  ZMCCollectionManger.m
//  ZMC
//
//  Created by Will on 16/5/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCollectionManger.h"
#import "ZMCURLSecond.h"


@implementation ZMCCollectionManger


// 收藏列表
+ (void)getCollectList:(void (^)(NSDictionary *))result{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
    
        NSString *urlStr = [NSString stringWithFormat:uGFavorite, token];
        
        [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
            ZMCLog(@"收藏列表所有数据-->%@ 收藏列表->%@", response, response[@"result"][@"data"]);;
            result(response[@"result"]);
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
        }];
    }];
}


// 删除收藏
+ (void)deleteFavoriteFav_id:(NSString *)fav_id result:(void(^)(NSString *result)) result{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
       
        NSString *urlStr = [NSString stringWithFormat:uGFavoriteDelete, token];
        NSDictionary *params = @{
                                 @"fav_id" : fav_id
                                 };
        
        [HYBNetworking postWithUrl:urlStr refreshCache:YES params:params success:^(id response) {
            result(response[@"err_msg"]);
        } fail:^(NSError *error) {
            ZMCLog(@"删除收藏失败");
        }];
    }];
}

@end
