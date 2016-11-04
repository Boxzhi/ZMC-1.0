//
//  NSDictionary+FarmInformation.m
//  YiHaiFarm
//
//  Created by Naive on 15/12/14.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "NSDictionary+FarmInformation.h"
//#import "LoginVC.h"
@implementation NSDictionary (FarmInformation)

/**
 *  请求成功返回 yes  失败返回 NO
 *
 *  @return <#return value description#>
 */
-(BOOL)getTheResultForDic{
    
    
    if ([@"0" isEqualToString:CHECK_VALUE([self objectForKey:@"err_code"])]) {
        
//        if ([@"0" isEqualToString:CHECK_VALUE([[self objectForKey:@"result"] objectForKey:@"optStatus"])]) {
//            return YES;
//        }else{
//            return NO;
//        }
        return YES;
        
    }else{
        if ([CHECK_VALUE([self objectForKey:@"err_code"]) isEqualToString:@"20002"]) {

//            [[[[[UIApplication sharedApplication] delegate] window] rootViewController] presentViewController:[LoginVC navigationControllerContainSelf] animated:YES completion:nil];
            
//            [[Singer share].customTabbr.currentController.navigationController presentViewController: animated:YES completion:nil];
            
            
        }
        
        return NO;
    }
    
}
-(NSString *)getResultMessage{
    
//    if ([@"0" isEqualToString:[self objectForKey:@"err_code"]]) {
    
//        if ([@"1" isEqualToString:CHECK_VALUE([[self objectForKey:@"result"] objectForKey:@"optStatus"])]) {
//            return CHECK_VALUE([[self objectForKey:@"result"] objectForKey:@"optMsg"]);
//        }else{
//            return @"服务器忙!";
//        }
    if ([CHECK_VALUE([self objectForKey:@"err_code"]) isEqualToString:@"20002"]) {
        
        return @"验证失效,请重新登录";
        
    }else{
        
        return CHECK_VALUE([self objectForKey:@"err_msg"]);
        
    }
    
    
    
//    }else{
//        return @"服务器忙!";
//    }
    
    
}


@end
