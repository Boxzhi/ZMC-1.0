//
//  GoodsCategoryModel.h
//  YiHaiFarm
//
//  Created by Naive on 15/12/21.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <Foundation/Foundation.h>


@class GoodsCategoryResult,GoodsCategoryChilds,GoodsCategoryChildsChilds;
@interface GoodsCategoryModel : NSObject

@property (nonatomic, strong) NSMutableArray<GoodsCategoryResult *> *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface GoodsCategoryResult : NSObject

@property (nonatomic, assign) NSInteger list_id;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<GoodsCategoryChilds *> *childs;

@end

@interface GoodsCategoryChilds : NSObject

@property (nonatomic, assign) NSInteger child_id;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<GoodsCategoryChildsChilds *> *childs;

@end

@interface GoodsCategoryChildsChilds : NSObject

@property (nonatomic, assign) NSInteger child_id;

@property (nonatomic, copy) NSString *name;

@end
