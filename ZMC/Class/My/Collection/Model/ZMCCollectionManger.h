//
//  ZMCCollectionManger.h
//  ZMC
//
//  Created by Will on 16/5/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCCollectionManger : NSObject


// 收藏列表
+ (void)getCollectList:(void(^)(NSDictionary *result))result;

// 删除收藏
+ (void)deleteFavoriteFav_id:(NSString *)fav_id result:(void(^)(NSString *result)) result;

@end
