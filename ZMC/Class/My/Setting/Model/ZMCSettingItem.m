//
//  ZMCSettingItem.m
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCSettingItem.h"
#import "ZMCURL.h"


@implementation ZMCSettingItem


// 编辑用户信息
+ (void)setavatar_url:(NSString *)avatar_url nick_name:(NSString *)nack_name signature:(NSString *)signature{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *url = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/member/saveMember?access_token=%@", token];
        
        ZMCLog(@"需要的TOKEN----->>>>>%@", token);
        
        NSDictionary *params = @{
                                 @"avatar_url" : avatar_url,
                                 @"nick_name" : nack_name,
                                 @"signature" : signature
                                 };
        
        [HYBNetworking postWithUrl:url refreshCache:YES params:params success:nil fail:nil];
    }];
}

@end
