//
//  ZMCTokenResult.h
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCTokenResultItem : NSObject

@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, strong) NSString *refresh_token;

@property (nonatomic, strong) NSString *expire_time;

@end
