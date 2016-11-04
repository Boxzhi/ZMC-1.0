//
//  ZMCCollectionItem.h
//  ZMC
//
//  Created by Will on 16/5/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCCollectionItem : NSObject

// 图片
@property (nonatomic, strong) NSString *pic;
// 名称
@property (nonatomic, strong) NSString *name;
// 已收藏人数
@property (nonatomic, assign) NSInteger collection_count;
// 商品ID
@property (nonatomic, assign) NSInteger fav_id;
// 收藏ID
@property (nonatomic, assign) NSInteger item_id;
// 菜市场名称
@property (nonatomic, strong) NSString *market_name;
// 类型
@property (nonatomic, assign) NSInteger type;

@end
