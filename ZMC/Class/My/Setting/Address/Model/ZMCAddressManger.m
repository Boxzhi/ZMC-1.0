//
//  ZMCAddressManger.m
//  ZMC
//
//  Created by Will on 16/5/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAddressManger.h"
#import "ZMCURL.h"

@implementation ZMCAddressManger

// 查询收货地址
+ (void)getressMgResult:(void(^)(NSDictionary *result))result{
    
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *url = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/member/addresses?access_token=%@&page=1&page_size=20", token];
        
        //    NSDictionary *params = @{
        //                             @"page" : page,
        //                             @"page_size" : page_size
        //                             };
        
        [HYBNetworking getWithUrl:url refreshCache:YES success:^(NSDictionary *response) {
            ZMCLog(@"收货地址查询结果-->%@",response);
            
            if (![response[@"err_msg"] isEqualToString:@"OK"]) {
                [SVProgressHUD showErrorWithStatus:response[@"err_msg"]];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else{
                
                result(response[@"result"]);
            }
            
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
//            NSDictionary *dic = @{@"error" : @"YES"};
//            result(dic);
        }];
    }];
    
    
}


// 编辑收货地址
+ (void)addaddressConsignee:(NSString *)consignee mobile:(NSString *)mobile province_id:(NSNumber *)province_id city_id:(NSNumber *)city_id district_id:(NSNumber *)district_id street_address:(NSString *)street_address is_default:(NSString *)is_default SerialId:(NSNumber *)SerialId result:(void(^)(NSDictionary *result))result
{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *urlStr = [NSString stringWithFormat:uAShippingAddress, token];
        
        NSDictionary *params = @{
                                 @"consignee" : consignee,
                                 @"mobile" : mobile,
                                 @"province_id" : province_id,
                                 @"city_id" : city_id,
                                 @"district_id" : district_id,
                                 @"street_address" : street_address,
                                 @"is_default" : is_default,
                                 @"id" : SerialId
                                 };
        
        [HYBNetworking postWithUrl:urlStr refreshCache:YES params:params success:^(id response) {
            ZMCLog(@"收货地址 -->%@", response);
            result(response);
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
        }];
    }];
    
}



// 添加收货地址
+ (void)addaddressConsignee:(NSString *)consignee mobile:(NSString *)mobile province_id:(NSNumber *)province_id city_id:(NSNumber *)city_id district_id:(NSNumber *)district_id street_address:(NSString *)street_address is_default:(NSString *)is_default result:(void(^)(NSDictionary *result))result
{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *urlStr = [NSString stringWithFormat:uAShippingAddress, token];
        
        NSDictionary *params = @{
                                 @"consignee" : consignee,
                                 @"mobile" : mobile,
                                 @"province_id" : province_id,
                                 @"city_id" : city_id,
                                 @"district_id" : district_id,
                                 @"street_address" : street_address,
                                 @"is_default" : is_default,
                                 };
        
        [HYBNetworking postWithUrl:urlStr refreshCache:YES params:params success:^(id response) {
            ZMCLog(@"收货地址 -->%@", response);
            result(response);
        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
        }];
    }];
    
}


// 删除收货地址
+ (void)deldteAddressId:(NSNumber *)Id result:(void(^)(NSDictionary *result))result{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *urlStr = [NSString stringWithFormat:uARemoveAddress, Id, TOKEN];
        
        [HYBNetworking postWithUrl:urlStr refreshCache:YES params:nil success:^(id response) {
            result(response);
        } fail:^(NSError *error) {
            ZMCLog(@"删除收货地址错误--->%@", error);
        }];
    }];
    
}
@end
