//
//  LocationMarketModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/9.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LocationMarketModel : NSObject

@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *distance;

@end
