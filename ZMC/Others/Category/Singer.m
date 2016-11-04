//
//  Singer.m
//  YiHaiFarm
//
//  Created by Daniel on 15/12/4.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "Singer.h"

#define LeftColor [UIColor redColor]
#define RightColor [UIColor grayColor]

@implementation Singer

/**
 单例
 @returns
 */
+(Singer *)share {
    static dispatch_once_t pred;
    static Singer *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[Singer alloc] init];
    });
    return shared;
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

- (NSString *)getImageUrlWithStr:(NSString *)str{
    
    NSString *tmpStr = CHECK_VALUE(str);
    
    if ([tmpStr contains:@"http"]) {
        return tmpStr;
    }else{
//        return [ImageHost stringByAppendingString:tmpStr];
        return tmpStr;
    
    
    }
}

/**
 *  商品详情页跟菜市场专用
 */
- (NSMutableAttributedString *)getGoodsMutStrWithLeftStr:(NSString *)leftStr leftColor:(UIColor *)leftClor leftFont:(NSInteger)leftFont rightStr:(NSString *)rightStr rightClor:(UIColor *)rightClor rightFont:(NSInteger)rightFont{
    
    NSString *currencyStr = @"¥";
    //    ¥20.0
    NSString *priceStr =leftStr;
    //    /200g
    NSString *desStr =rightStr;
    //    ¥20.0/200g
    NSString *str =[NSString stringWithFormat:@"%@ %@%@", currencyStr, priceStr,desStr];
    NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc] initWithString:str];
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, [currencyStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:leftClor range:NSMakeRange(0, [currencyStr length])];
    
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:leftFont] range:NSMakeRange([currencyStr length] + 1,[priceStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:leftClor range:NSMakeRange([currencyStr length] + 1,[priceStr length])];
    
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:rightFont] range:NSMakeRange([priceStr length] + 2,[desStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:rightClor range:NSMakeRange([priceStr length] + 2,[desStr length])];
    
    return PriceStr;
}

- (NSMutableAttributedString *)getGoodsMutStrWithPrice:(NSString *)price unit:(NSString *)unit unitName:(NSString *)unitName leftColor:(UIColor *)leftClor rightClor:(UIColor *)rightClor leftFont:(NSInteger)leftFont rightFont:(NSInteger)rightFont {
    
    if ([unit integerValue] == 0 || unit == nil) {
        unit = @"";
    }
    
    return [self getGoodsMutStrWithLeftStr:[NSString stringWithFormat:@"%@",price] leftColor:leftClor ==  nil ?LeftColor : leftClor leftFont:leftFont == 0 ? 20 : leftFont rightStr:[NSString stringWithFormat:@"/%@%@",unit,unitName] rightClor:rightClor == nil ? RightColor : rightClor rightFont:rightFont == 0 ? 12 : rightFont];
    
}


/**
 *  全局方法
 返回￥20/200g  样式
 */
- (NSMutableAttributedString *)getMutStrWithLeftStr:(NSString *)leftStr leftColor:(UIColor *)leftClor rightStr:(NSString *)rightStr rightClor:(UIColor *)rightClor{
    
    //    ¥20.0
    NSString *priceStr =leftStr;
    //    /200g
    NSString *desStr =rightStr;
    //    ¥20.0/200g
    NSString *str =[NSString stringWithFormat:@"%@%@", priceStr,desStr];
    NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0,[priceStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:leftClor range:NSMakeRange(0,[priceStr length])];
    
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange([priceStr length],[desStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:rightClor range:NSMakeRange([priceStr length],[desStr length])];
    
    return PriceStr;
}

- (NSMutableAttributedString *)getMutStrWithPrice:(NSString *)price unit:(NSString *)unit unitName:(NSString *)unitName leftColor:(UIColor *)leftClor rightClor:(UIColor *)rightClor{
    
    if ([unit integerValue] == 0 || unit == nil) {
        unit = @"";
    }
    
    return [self getMutStrWithLeftStr:[NSString stringWithFormat:@"¥ %@",price] leftColor:leftClor ==  nil ?LeftColor : leftClor rightStr:[NSString stringWithFormat:@"/%@%@",unit,unitName] rightClor:rightClor == nil ? RightColor : rightClor];
    
}

- (NSMutableAttributedString *)getMutStrWithPrice:(NSString *)price unit:(NSString *)unit unitName:(NSString *)unitName leftColor:(UIColor *)leftClor rightClor:(UIColor *)rightClor font:(float)font{
    
    return [self getMutStrWithLeftStr:[NSString stringWithFormat:@"¥ %@",price] leftColor:leftClor ==  nil ?LeftColor : leftClor rightStr:[NSString stringWithFormat:@"/%@%@",unit,unitName] rightClor:rightClor == nil ? RightColor : rightClor font:font];
}

- (NSMutableAttributedString *)getMutStrWithLeftStr:(NSString *)leftStr leftColor:(UIColor *)leftClor rightStr:(NSString *)rightStr rightClor:(UIColor *)rightClor font:(float)font{
    
    //    ¥20.0
    NSString *priceStr =leftStr;
    //    /200g
    NSString *desStr =rightStr;
    //    ¥20.0/200g
    NSString *str =[NSString stringWithFormat:@"%@%@",priceStr,desStr];
    NSMutableAttributedString *PriceStr = [[NSMutableAttributedString alloc] initWithString:str];
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0,[priceStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:leftClor range:NSMakeRange(0,[priceStr length])];
    
    [PriceStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange([priceStr length],[desStr length])];
    [PriceStr addAttribute:NSForegroundColorAttributeName value:rightClor range:NSMakeRange([priceStr length],[desStr length])];
    
    return PriceStr;
}

@end
