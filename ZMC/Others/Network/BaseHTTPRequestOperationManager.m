//
//  BaseHTTPrequestManger.m
//  ThailandGo
//
//  Created by Daniel on 15/9/28.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "BaseHTTPRequestOperationManager.h"
#import "LoginSuccessModel.h"
#import "HttpConfig.h"

static const NSString *Host_URL = ReleaseHost;


@implementation BaseHTTPRequestOperationManager



+ (BaseHTTPRequestOperationManager *)sharedManager
{
    static BaseHTTPRequestOperationManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self manager]initWithBaseURL:nil];
        _sharedManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sharedManager.requestSerializer setValue:CLIENT_VERSION forHTTPHeaderField:@"version"];
        [_sharedManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"source"];
//        [_sharedManager.requestSerializer setValue:@"" forHTTPHeaderField:@"Content-Type"];
        [_sharedManager.responseSerializer setStringEncoding:NSUTF8StringEncoding];
        [_sharedManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil]];
        [_sharedManager.requestSerializer setTimeoutInterval:10];
    });
    return _sharedManager;
}


- (void)defaultGetWithMethod:(NSString *)method WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    ZMCLog(@"\n请求链接%@",method);
    ZMCLog(@"\n请求参数%@",parameters);
    
    //请求类型 get
    [[BaseHTTPRequestOperationManager sharedManager] GET:[[Host_URL stringByAppendingString:method] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id result =  [self getResult:responseObject];
        
        success(task,result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZMCLog(@"%@",error);
        failure(task, error);
    }];
//    [[BaseHTTPRequestOperationManager sharedManager] GET:[[Host_URL stringByAppendingString:method] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        
//       id result =  [self getResult:responseObject];
//
//        success(task,result);
//
//        
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        failure(task, error);
//    }];
//    [[BaseHTTPRequestOperationManager sharedManager] GET:[@"http://v.juhe.cn/weather/index?format=2&cityname=苏州&key=af5a3721915b6e3a3016fe694f47b0de" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//        id result =  [self getResult:responseObject];
//        
//        success(operation,result);
//        
//        
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        failure(operation, error);
//    }];
    
}

- (void)defaultPostWithUrl:(NSString *)urlString WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    ZMCLog(@"\n请求链接%@",urlString);
    ZMCLog(@"\n请求参数%@",parameters);
    
    //请求类型 post
    [[BaseHTTPRequestOperationManager sharedManager] POST:[Host_URL stringByAppendingString:urlString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id result =  [self getResult:responseObject];
        //        if ([TokenToolShared checkValidToken:[result objectForKey:@"errcode"]]) {
        //            //登录
        //
        //            return ;
        //        }
        //        [[WLNetworkErrorView shared] networkErrorRemove];
        //        NSLog(@"%@",returnValue);
        success(task,result);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ZMCLog(@"%@",error);
        failure(task, error);
        
    }];
//    [[BaseHTTPRequestOperationManager sharedManager] POST:[Host_URL stringByAppendingString:urlString] parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        
//        id result =  [self getResult:responseObject];
////        if ([TokenToolShared checkValidToken:[result objectForKey:@"errcode"]]) {
////            //登录
////            
////            return ;
////        }
////        [[WLNetworkErrorView shared] networkErrorRemove];
//        //        NSLog(@"%@",returnValue);
//        success(operation,result);
//        
//        
//    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        failure(operation, error);
//    }];
    
    
}


- (id)getResult:( id )restr{
    if (restr == nil) {
        return nil;
    }
    NSString *retStr = [[NSString alloc] initWithData:restr encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id returnValue = [NSJSONSerialization JSONObjectWithData:[retStr dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    if(error) ZMCLog(@"JSON Parsing Error: %@", error);
    return returnValue;
}

/**
 *  为链接添加token
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)addAccessToken:(NSString *)url{
    
    return [url stringByAppendingString:[NSString stringWithFormat:@"?access_token=%@",TOKEN]];
//    return nil;

}


/**
 *  get方法专用 拼接链接信息
 *
 *  @param compose 带入信息字典
 *  @param url     链接地址
 *
 *  @return 拼接完成链接  xxxx/xxx?xxx=xxx&yy=yy&zzzz=zzzzz
 */
+ (NSString *)getUrlCompose:(NSMutableDictionary *)compose withUrl:(NSString *)url{
    
    NSArray *valuseAry = [compose allValues];
    NSArray *keysAry = [compose allKeys];
    
    
    NSString *resultStr = @"";
    if ([url contains:@"?"]) {
        
        for (NSInteger i=0; i<keysAry.count; i++) {
            
           resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",CHECK_VALUE(keysAry[i]),CHECK_VALUE(valuseAry[i])]];
            
        }
        
    }else{

        
        url = [url stringByAppendingString:@"?"];
        
        for (NSInteger i=0; i<keysAry.count; i++) {
            
           resultStr = [resultStr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",CHECK_VALUE(keysAry[i]),CHECK_VALUE(valuseAry[i])]];
            
        }
    
        if (resultStr.length >0 ) {
            resultStr = [resultStr substringToIndex:resultStr.length-1];
        }
        
        
        
        
        
    }

    
    
    return [url stringByAppendingString:resultStr];

    
}


/**
 *  拼接特殊id
 *
 *  @param especid 信息id
 *
 *  @return 拼接字符串
 */
+ (NSString *)getUrl:(NSString *)url addEspecid:(NSString *)especid{
    
    return [url stringByAppendingString:especid];
    
}


+ (NSString *)getUrl:(NSString *)url addEspecid:(NSString *)especid needToken:(Boolean) need params:(id)params{
    
    
    
    if (need) {
        
        return [self getUrlCompose:params withUrl:[self addAccessToken:[url stringByAppendingString:CHECK_VALUE(especid)]]];
        
    }else{
        
        return [self getUrlCompose:params withUrl:[url stringByAppendingString:CHECK_VALUE(especid)]];
        
    }
    
    return nil;
    
}


+ (NSString *)postUrl:(NSString *)url addEspecid:(NSString *)especid needToken:(Boolean) need{
    
    if (need) {
        
        return [self addAccessToken:[url stringByAppendingString:CHECK_VALUE(especid)]];
        
    }else{
        
        return [url stringByAppendingString:CHECK_VALUE(especid)];
        
    }
    return nil;
}


//- (NSString *)checkLastCharter:(NSString *)url{
//    
//    
//    
//}


@end
