//
//  NSString+Category.m
//  YueDongApp
//
//  Created byDaniel on 14-8-5.
//  Copyright (c) 2014年Daniel. All rights reserved.
//

#import "NSString+Category.h"
#import <objc/runtime.h>
static const void *NameKey = &NameKey;
@implementation NSString (Category)

//昵称表达式
- (BOOL)isValidatePhoneNum
{

    NSString *niChengRegex =[NSString stringWithFormat:@"^(13[0-9]|15[0|1|2|3|5|6|7|8|9]|18[0|5|6|7|8|9])\\d{8}$"];
    
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",niChengRegex];
    
    return [regex evaluateWithObject:self];
}

- (NSString *)priceStringWithUnit:(BOOL)unit
{
    if (self.length == 0) {
        return @"";
    }
    CGFloat price = [self floatValue];
    if (unit) {
        return [NSString stringWithFormat:@"¥%g",price];
    }
    else{
        return [NSString stringWithFormat:@"%g",price];
    }
}

//是否包含特殊字符
- (BOOL)contains:(NSString *)subString
{
    NSRange range = [self rangeOfString:subString];
    return range.location != NSNotFound;
}

+ (NSString *)priceStringWithOneFloat:(NSString *)priceStr
{
    if (priceStr.length == 0) {
        return @"";
    }
    CGFloat price = [priceStr floatValue];
    
    return [NSString stringWithFormat:@"¥%.1f",price];
    
}

- (NSString *)name {
    return objc_getAssociatedObject(self, NameKey);
}

- (void)setName:(NSString *)name{
    objc_setAssociatedObject(self, NameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


/**
 *  拼接图片链接
 *
 *  @param urlPath 后缀
 *
 *  @return 拼接好的链接
 */
+(NSString *)getImgUrl:(NSString *)urlPath{
    NSString *returnUrl =@"";
//    returnUrl =[ImgUrl_Real_host stringByAppendingString:CHECK_VALUE(urlPath)];
    
    return returnUrl;
}


/**
 *  根据当前价格str  返回需要格式的str
 *
 *  @param currentPricestr <#currentPricestr description#>
 *
 *  @return <#return value description#>
 */
+(NSString *)getPriceStr:(NSString *)currentPricestr{
    
    NSString *returnUrl =@"";

    returnUrl = [NSString stringWithFormat:@"%.1f",[currentPricestr floatValue]];
    
    return returnUrl;
}
@end
