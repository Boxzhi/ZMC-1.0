//
//  ZMCBalanceManger.m
//  ZMC
//
//  Created by Will on 16/5/26.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import "ZMCBalanceManger.h"
#import "ZMCURL.h"

@implementation ZMCBalanceManger

+ (void)getbillPage:(NSInteger)page Page_size:(NSInteger)page_size Result:(void(^)(NSDictionary *result))result{
 
    NSString *urlStr = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/member/bill?access_token=%@&page=%ld&page_size=%ld", TOKEN, page, page_size];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
        result(response);
    } fail:^(NSError *error) {
        ZMCLog(@"%@", error);
    }];
}

@end
