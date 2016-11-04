//
//  ZMCPaymentsManger.m
//  ZMC
//
//  Created by Will on 16/5/23.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCPaymentsManger.h"
#import "ZMCURL.h"

@implementation ZMCPaymentsManger

//查询用户退款记录
+ (void)getPayMentRelust:(void(^)(NSDictionary *result))result{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
    
        [SVProgressHUD showWithStatus:@"正在加载..."];
        
        NSString *urlstr = [NSString stringWithFormat:uMRefund, token];
        
        [HYBNetworking getWithUrl:urlstr refreshCache:YES success:^(id response) {

            result(response);
            [SVProgressHUD dismiss];
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
            [SVProgressHUD dismiss];
        }];
    }];
}



// 申请退款
+ (void)postPayMentMonsy:(NSNumber *)money relust:(void(^)(NSDictionary *result))result{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
       
        if (![money  isEqual: @0]) {
            NSString *urlStr = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/member/refund?access_token=%@&refund_money=%@", token, money];
            
            [HYBNetworking postWithUrl:urlStr refreshCache:NO params:nil success:^(id response) {
                
                result(response);
            } fail:^(NSError *error) {
                
            }];
        }else{
            [SVProgressHUD showInfoWithStatus:@"无可退余额"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
}
@end
