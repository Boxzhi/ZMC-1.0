//
//  ZMCTokenTool.h
//  ZMC
//
//  Created by Will on 16/5/24.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^getToken)(NSString *token);

@class ZMCTokenResultItem;
@interface ZMCTokenTool : NSObject
+ (ZMCTokenTool *) shared;


@property (nonatomic, strong) ZMCTokenResultItem *tokenItem;

- (void)getAccess_tokenWithRefresh_token:(getToken)tokenBlock;


@end
