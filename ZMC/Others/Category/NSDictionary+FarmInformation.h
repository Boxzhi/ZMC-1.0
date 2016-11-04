//
//  NSDictionary+FarmInformation.h
//  YiHaiFarm
//
//  Created by Naive on 15/12/14.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  专门为服务器返回字典 判断是不是正常返回判断的分类
 */
@interface NSDictionary (FarmInformation)

-(BOOL) getTheResultForDic;
-(NSString *)getResultMessage;

@end
