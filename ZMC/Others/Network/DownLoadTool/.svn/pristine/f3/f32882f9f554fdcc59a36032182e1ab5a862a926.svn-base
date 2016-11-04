//
//  DownLoadTool.h
//  ThailandGo
//
//  Created by Daniel on 15/10/9.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPRequestOperation.h>
@interface DownLoadTool : NSObject

/**
 *  利用网络框架实现多任务下载以及断点续传
 *
 *  @param url     链接
 *  @param file    文件名
 *  @param block   过程回调
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)startDownloadwithurl:(NSString *)url andfile:(NSString *)file ProgressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead ,float progress))block CompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;




@end
