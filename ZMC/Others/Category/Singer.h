//
//  Singer.h
//  YiHaiFarm
//
//  Created by Daniel on 15/12/4.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "UITabbarCommonViewController.h"
@interface Singer : NSObject

+(Singer *) share ;
/**
 *  自定义的tabbar
 */
//@property(nonatomic,strong) UITabbarCommonViewController *customTabbr;

//sd_setImageWithURL
- (id)getResult:( id )restr;


- (NSString *)getImageUrlWithStr:(NSString *)str;

/**
 *  专为怎么吃项目写的
 price + unit + unitName
 
 */
- (NSMutableAttributedString *)getMutStrWithPrice:(NSString *)price unit:(NSString *)unit unitName:(NSString *)unitName leftColor:(UIColor *)leftClor rightClor:(UIColor *)rightClor;

- (NSMutableAttributedString *)getMutStrWithPrice:(NSString *)price unit:(NSString *)unit unitName:(NSString *)unitName leftColor:(UIColor *)leftClor rightClor:(UIColor *)rightClor font:(float)font;

// 商品详情页跟菜场专用
- (NSMutableAttributedString *)getGoodsMutStrWithPrice:(NSString *)price unit:(NSString *)unit unitName:(NSString *)unitName leftColor:(UIColor *)leftClor rightClor:(UIColor *)rightClor leftFont:(NSInteger)leftFont rightFont:(NSInteger)rightFont;

@end
