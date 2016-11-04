//
//  ZMCPayManger.m
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import "ZMCPayManger.h"
#import "ZMCURLSecond.h"

@implementation ZMCPayManger

+ (void)getPayPrepaid:(void(^)(NSArray *result))result{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
    
        NSString *urlStr = [NSString stringWithFormat:uORechargePrepaid, token];
        
        [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
            ZMCLog(@"%@", response[@"result"][@"list"]);
            result(response[@"result"][@"list"]);
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
            
        }];
    }];
    
}


+(void)getPayRecharge:(NSNumber *)money andResult:(void (^)(NSDictionary *))result{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
       
        NSString *urlStr = [NSString stringWithFormat:uORechargeGetChange, token, money];
        
        [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
            ZMCLog(@"%@", response);
            result(response[@"result"][@"recharge"]);
        } fail:^(NSError *error) {
            
        }];
//        [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
//            result(response[@"result"][@"recharge"]);
//        } fail:^(NSError *error) {
//            
//        }];
        
    }];
}

@end
