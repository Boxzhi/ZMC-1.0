//
//  NSString+Category.h
//  YueDongApp
//
//  Created byDaniel on 14-8-5.
//  Copyright (c) 2014年Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

/*
 *@prama 价格规范化 以元为单位
 *unit YES:带¥符号 NO:不带
 */
- (NSString *)priceStringWithUnit:(BOOL)unit;

/**
 *  是否包含substring字符
 */
- (BOOL)contains:(NSString *)subString;

//手机号码表达式
- (BOOL)isValidatePhoneNum;

+ (NSString *)priceStringWithOneFloat:(NSString *)priceStr;


/**
 *  拼接图片链接
 *
 *  @param urlPath 后缀
 *
 *  @return 拼接好的链接
 */
+(NSString *)getImgUrl:(NSString *)urlPath;

/**
 *  根据当前价格str  返回需要格式的str
 *
 *  @param currentPricestr <#currentPricestr description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)getPriceStr:(NSString *)currentPricestr;


@property(nonatomic,strong)   NSString *name;
@end
