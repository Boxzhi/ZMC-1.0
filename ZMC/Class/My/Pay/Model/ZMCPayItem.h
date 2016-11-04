//
//  ZMCPayItem.h
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCPayItem : NSObject

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *give_money;
@property (nonatomic, strong) NSNumber *item_id;
@property (nonatomic, strong) NSNumber *money;
@property (nonatomic, strong) NSNumber *type;

@end
