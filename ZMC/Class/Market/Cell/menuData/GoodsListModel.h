//
//  GoodsListModel.h
//  YiHaiFarm
//
//  Created by Naive on 15/12/21.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoodsListResult,GoodsListData,GoodsListActivity_Label;
@interface GoodsListModel : NSObject

@property (nonatomic, strong) GoodsListResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface GoodsListResult : NSObject

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSArray<GoodsListData *> *data;

@property (nonatomic, assign) NSInteger total_pages;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger page_size;

@end

@interface GoodsListData : NSObject

@property (nonatomic, assign) NSInteger unit;

@property (nonatomic, copy) NSString *merchant_name;

@property (nonatomic, assign) NSInteger goods_id;

@property (nonatomic, assign) float price;

@property (nonatomic, assign) NSInteger shop_cart_count;

@property (nonatomic, copy) NSString *thumb;

@property (nonatomic, copy) NSString *short_intro;

@property (nonatomic, copy) NSString *unit_name;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<GoodsListActivity_Label *> *activity_label;

@end

@interface GoodsListActivity_Label : NSObject

@property (nonatomic, assign) NSInteger activity_id;

@property (nonatomic, copy) NSString *name;

@end

