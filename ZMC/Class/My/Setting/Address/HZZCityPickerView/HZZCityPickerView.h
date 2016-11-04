//
//  HZZCityPickerView.h
//  Diamond
//
//  Created by HZZ on 16/5/25.
//  Copyright (c) 2016年 HZZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZZCityPickerView;

@protocol HZZCityPickerViewDelegate <NSObject>

/**
 *  告诉代理，用户选择了省市区
 *
 *  @param picker   picker
 *  @param province 省
 *  @param city     市
 *  @param district 区
 */
- (void)cityPickerView:(HZZCityPickerView *)picker
    finishPickProvince:(NSString *)province
                  city:(NSString *)city
              district:(NSString *)district;

/**
 *  传省市区的ID给代理
 *
 *  @param picker     picker
 *  @param provinceId 省ID
 *  @param cityId     市ID
 *  @param districtId 区ID   
 */
- (void)cityPickerViewID:(HZZCityPickerView *)picker
    finishPickProvinceId:(NSNumber *)provinceId
                  cityId:(NSNumber *)cityId
              districtId:(NSNumber *)districtId;

@end


@interface HZZCityPickerView : UIPickerView

@property (nonatomic, weak) id<HZZCityPickerViewDelegate> cityPickerDelegate;

@end
