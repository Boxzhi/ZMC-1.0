//
//  BaseHTTPrequestManger.h
//  ThailandGo
//
//  Created by Daniel on 15/9/28.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "AFHTTPSessionManager.h"
//#import "HttpConfig.h"

@class BaseRequestParamsModel;
#define HttpOperation NSURLSessionDataTask
//#define JsonFromDic(vaule) [NSString dictionaryToJson:vaule]

@interface BaseHTTPRequestOperationManager : AFHTTPSessionManager

//+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

+ (BaseHTTPRequestOperationManager *)sharedManager;

- (void)defaultGetWithMethod:(NSString *)method WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)defaultPostWithUrl:(NSString *)urlString WithParameters:(id)parameters success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

//- (void)defaultPostWithMethod:(NSString *)method WithParameters:(id)parameters WithBodyParameters:(id)bodyParameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  为链接添加token
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)addAccessToken:(NSString *)url;

/**
 *  get方法专用 拼接链接信息
 *
 *  @param compose 带入信息字典
 *  @param url     链接地址
 *
 *  @return 拼接完成链接  xxxx/xxx?xxx=xxx&yy=yy&zzzz=zzzzz
 */
+ (NSString *)getUrlCompose:(NSMutableDictionary *)compose withUrl:(NSString *)url;

/**
 *  拼接特殊id
 *
 *  @param especid 信息id
 *
 *  @return 拼接字符串
 */
+ (NSString *)getUrl:(NSString *)url addEspecid:(NSString *)especid;



/***************   Get方法链接拼接方法 start  *************************/
+ (NSString *)getUrl:(NSString *)url addEspecid:(NSString *)especid needToken:(Boolean) need params:(id)params;






/***************   Post方法链接拼接方法 start  *************************/
+ (NSString *)postUrl:(NSString *)url addEspecid:(NSString *)especid needToken:(Boolean) need;




@end
