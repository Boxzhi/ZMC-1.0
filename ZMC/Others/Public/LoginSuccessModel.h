//
//  LoginSuccessModel.h
//  YHPromotion
//
//  Created by Naive on 16/3/30.
//  Copyright © 2016年 Naive. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginResult;
@interface LoginSuccessModel : NSObject



@property (nonatomic, strong) LoginResult *result;

@property (nonatomic, copy) NSString *err_code;

@property (nonatomic, copy) NSString *err_msg;


@end

@interface LoginResult : NSObject

@property (nonatomic, assign) NSInteger expire_time;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *refresh_token;

@end
