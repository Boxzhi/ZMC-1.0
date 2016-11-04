//
//  ZMCMyintegralManger.m
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyintegralManger.h"
#import "ZMCURL.h"

@implementation ZMCMyintegralManger

//会员签到
+ (void)is_signin:(NSString *)signin andResult:(void(^)(NSDictionary *result))result{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
    
        NSNumber *signinNum = @([signin integerValue]);
        NSString *url = [NSString stringWithFormat:uMMember, token, signinNum];
        ZMCLog(@"签到--->>%@", signinNum);
        
        [HYBNetworking postWithUrl:url refreshCache:YES params:nil success:^(NSDictionary *response) {
            ZMCLog(@"%@", response);
            result(response[@"result"]);
            [SVProgressHUD dismiss];
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
        }];
    }];
    
}

/**
 *  获取积分规则
 */
+(void)getMemberPoints:(void (^)(NSDictionary *))result{
    
    [HYBNetworking getWithUrl:uMRule refreshCache:YES success:^(id response) {
        result(response);
    } fail:^(NSError *error) {
        
    }];
    
}

@end
