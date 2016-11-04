//
//  ZMCCouponManger.m
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCouponManger.h"
#import "ZMCURL.h"

@implementation ZMCCouponManger

+ (void)queCouponResult:(void(^)(NSDictionary *result))result{
    
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
    
        [SVProgressHUD showWithStatus:@"正在加载..."];
        
        NSString *str = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/member/coupons?access_token=%@&page=1&page_size=50", token];
        
        [HYBNetworking getWithUrl:str refreshCache:YES success:^(id response) {
            result(response[@"result"]);
            [SVProgressHUD dismiss];
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
            [SVProgressHUD dismiss];
        }];
    }];
}
@end
