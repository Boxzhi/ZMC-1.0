//
//  ZMCBalanceManger.h
//  ZMC
//
//  Created by Will on 16/5/26.
//  Copyright © 2016年 苏州睿途科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMCBalanceManger : NSObject

+ (void)getbillPage:(NSInteger)page Page_size:(NSInteger)page_size Result:(void(^)(NSDictionary *result))result;

@end
