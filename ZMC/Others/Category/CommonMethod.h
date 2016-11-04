//
//  CommonMethod.h
//
//  Created by Daniel on 14-8-2.
//  Copyright (c) 2014年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

//把返回字段转换成string类型
NSString * NSStringExchangeTheReturnValueToString(id value);

//把返回字段转换成NSArray类型
NSArray * NSArrayexchangeTheReturnValueToArray(id value);

//把返回字段转换成float类型
CGFloat FloatexchangeTheReturnValueToFloat(CGFloat value);

/**
 @method 获取字符串value的宽度
 @param value 待计算的字符串
 @param fontSize 字体的大小
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的宽度
 */
float HeightForString(NSString *value,float fontSize,float width);

/**
 *  显示用户手机号，中间几位用星号代替
 *
 *  @param value 手机全号码
 *
 *  @return 显示用户手机号，中间几位用星号代替
 */
NSString * NSStringShowUserPhoneNumber(NSString *numString);

/**
 *  调整图片大小
 *
 *  @param img  选取的图片
 *  @param size 上传的尺寸
 *
 *  @return 返回一张上传到图片
 */
UIImage * UIImageScaleToSize(UIImage *img, CGSize size);

@interface CommonMethod : NSObject

+(CommonMethod *)share;
/**
 *  本地保存有记录过经期
 */
- (void)saveTheRecordKey:(NSString *)recordKey;
- (NSString *)getTheLocalAddressKey;

/**
 *  获取当前月份的天数
 *
 *  @param year  当前年数
 *  @param month 当前月数
 *
 *  @return 当前月份的天数
 */
- (NSInteger)getDayNumberWithYear:(NSInteger)year month:(NSInteger)month;


/**
 *  检查最新版本 如果存在跟新则返回yes  不是则返回no
 *
 *  @param resultBlock 结果  yes 代表有跟新
 */
+(void)checkNewVersionBlock:(void(^)(BOOL result))resultBlock;

+ (NSString *)changeNsinterToStr:(NSInteger )inter;

@end
