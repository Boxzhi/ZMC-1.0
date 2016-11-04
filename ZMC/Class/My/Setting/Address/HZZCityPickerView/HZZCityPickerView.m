//
//  HZZCityPickerView.m
//  Diamond
//
//  Created by HZZ on 16/5/25.
//  Copyright (c) 2016年 HZZ. All rights reserved.
//

#import "HZZCityPickerView.h"
#import "HZZPccItem.h"


#define PS_CITY_PICKER_COMPONENTS 3
#define PROVINCE_COMPONENT        0
#define CITY_COMPONENT            1
#define DISCTRCT_COMPONENT        2
#define FIRST_INDEX               0


#define COMPONENT_WIDTH 100 //每一列的宽度

@interface HZZCityPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>


@property (nonatomic, copy, readwrite) NSString *province;/**< 省名称*/
@property (nonatomic, copy, readwrite) NSString *city;/**< 市名称*/
@property (nonatomic, copy, readwrite) NSString *district;/**< 区名称*/
@property (nonatomic, assign) BOOL needReloadText;

@property (nonatomic, copy, readwrite) NSNumber *provinceId;/**< 省ID*/
@property (nonatomic, copy, readwrite) NSNumber *cityId;/**< 市ID*/
@property (nonatomic, copy, readwrite) NSNumber *districtId;/**< 区ID*/

//@property (nonatomic, copy) NSDictionary *allCityInfo;
@property (nonatomic, copy) NSArray *provinceArr;/**< 省名称数组*/
@property (nonatomic, copy) NSArray *cityArr;/**< 市名称数组*/
@property (nonatomic, copy) NSArray *districtArr;/**< 区名称数组*/

@property (nonatomic, copy) NSArray *provinceArrId;/**< 省ID数组*/
@property (nonatomic, copy) NSArray *cityArrId;/**< 市ID数组*/
@property (nonatomic, copy) NSArray *districtArrId;/**< 区ID数组*/


// 保存省份模型的数组
@property (nonatomic, copy) NSArray *provinceArray;
// 保存城市模型的数组
@property (nonatomic, copy) NSArray *cityArray;
// 保存区县模型的数组
@property (nonatomic, copy) NSArray *countryArray;



@end

@implementation HZZCityPickerView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self loadProvinceData];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}


#pragma mark - 省份数据请求
- (void)loadProvinceData{
    
    [HYBNetworking getWithUrl:@"http://115.159.227.219:8088/fanfou-api/area/province" refreshCache:YES success:^(id response) {
        
        [HZZPccItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"item_id":@"id"};
        }];
        
        // 省份模型数组
        _provinceArray = [HZZPccItem mj_objectArrayWithKeyValuesArray:response[@"result"]];
        
        [self reloadComponent:0];
        
        HZZPccItem *item = _provinceArray[0];
        [self loadCityDataId:item.item_id];
        
    } fail:^(NSError *error) {
        NSLog(@"错误信息--->>>%@", error);
    }];
}

#pragma mark - 城市数据请求
- (void)loadCityDataId:(NSNumber *)Id{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/area/city/%@", Id];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
        
        [HZZPccItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"item_id":@"id"};
        }];
        
        
        
        NSMutableArray *array = response[@"result"];
        if (array.count == 0) {
            _cityArr = @[@"暂未开通"];
            _districtArr = @[@"暂未开通"];
            _cityArrId = @[@"00000000"];
            _districtArrId = @[@"00000000"];
            if (_needReloadText) {
                self.city = _cityArr[0];
                self.district = _districtArr[0];
                self.cityId = _cityArrId[0];
                self.districtId = _districtArrId[0];
                [self reloadCityPickViewText];
                [self reloadAllComponents];
            }
        }else{
            // 城市模型数组
            _cityArray = [HZZPccItem mj_objectArrayWithKeyValuesArray:response[@"result"]];
            NSMutableArray *tmp = [NSMutableArray array];
            //
            NSMutableArray *tmpId = [NSMutableArray array];
            for (HZZPccItem *item in _cityArray) {
                [tmp addObject:item.name];
                [tmpId addObject:item.item_id];
            }
            _cityArr = tmp;
            _cityArrId = tmpId;
            self.city = _cityArr[0];
            self.cityId = _cityArrId[0];
            [self reloadAllComponents];
            HZZPccItem *item = _cityArray[0];
            [self loadCountryDataId:item.item_id];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"错误信息--->>>%@", error);
    }];
    
}

#pragma mark - 区县数据请求
- (void)loadCountryDataId:(NSNumber *)Id{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/area/country/%@", Id];
    
    [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
        
        [HZZPccItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"item_id":@"id"};
        }];
        
        NSMutableArray *array = response[@"result"];
        if (array.count == 0) {
            _districtArr = @[@"暂未开通"];
            _districtArrId = @[@"00000000"];
            if (_needReloadText) {
                self.district = _districtArr[0];
                self.districtId = _districtArrId[0];
                [self reloadCityPickViewText];
                [self reloadComponent:2];
            }
        }else{
            // 区县模型数组
            _countryArray = [HZZPccItem mj_objectArrayWithKeyValuesArray:response[@"result"]];
            NSMutableArray *tmp = [NSMutableArray array];
            //
            NSMutableArray *tmpId = [NSMutableArray array];
            for (HZZPccItem *item in _countryArray) {
                [tmp addObject:item.name];
                [tmpId addObject:item.item_id];
            }
            _districtArr = tmp;
            _districtArrId = tmpId;
            if (_needReloadText) {
                
                self.district = _districtArr[0];
                self.districtId = _districtArrId[0];
                [self reloadCityPickViewText];
                
                [self reloadComponent:2];
            }
            
        }
        
    } fail:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
}


#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    //包含3列
    return PS_CITY_PICKER_COMPONENTS;
}

//该方法返回值决定该控件指定列包含多少个列表项
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component)
    {
        case PROVINCE_COMPONENT: return [self.provinceArr count];
        case CITY_COMPONENT:     return [self.cityArr count];
        case DISCTRCT_COMPONENT: return [self.districtArr count];
        
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *titleLabel = (UILabel *)view;
    if (!titleLabel)
    {
        titleLabel = [self labelForPickerView];
    }
    titleLabel.text = [self titleForComponent:component row:row];
    return titleLabel;
}

#pragma mark - 选择指定列、指定列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT)
    {
        HZZPccItem *item = _provinceArray[row];
        _needReloadText = YES;
        [self loadCityDataId:item.item_id];
        
        
        self.province = _provinceArr[row];
        self.provinceId = item.item_id;
        self.city = _cityArr[0];
        self.cityId = _cityArrId[0];
        self.district = _districtArr[0];
        self.districtId = _districtArrId[0];
        
    
        [pickerView selectRow:FIRST_INDEX inComponent:CITY_COMPONENT animated:YES];
        [pickerView selectRow:FIRST_INDEX inComponent:DISCTRCT_COMPONENT animated:YES];
        [pickerView reloadAllComponents];
    }
    else if (component == CITY_COMPONENT)
    {
        HZZPccItem *item = _cityArray[row];
        _needReloadText = YES;
        [self loadCountryDataId:item.item_id];
        
        self.city = _cityArr[row];
        self.cityId = item.item_id;
        self.district = _districtArr[0];
        self.districtId = _districtArrId[0];

        [pickerView selectRow:FIRST_INDEX inComponent:DISCTRCT_COMPONENT animated:YES];
        [pickerView reloadComponent:DISCTRCT_COMPONENT];
    }
    else if (component == DISCTRCT_COMPONENT)
    {

        self.district = _districtArr[row];
        self.districtId = _districtArrId[row];
        [self reloadCityPickViewText];

    }
}

#pragma mark - 刷新代理方法
- (void)reloadCityPickViewText {
    if ([self.cityPickerDelegate respondsToSelector:@selector(cityPickerView:
                                                              finishPickProvince:
                                                              city:
                                                              district:)])
    {
        [self.cityPickerDelegate cityPickerView:self
                             finishPickProvince:self.province
                                           city:self.city
                                       district:self.district];
    }
    
    if ([self.cityPickerDelegate respondsToSelector:@selector(cityPickerViewID:
                                                              finishPickProvinceId:
                                                              cityId:
                                                              districtId:)])
    {
        [self.cityPickerDelegate cityPickerViewID:self
                             finishPickProvinceId:self.provinceId
                                           cityId:self.cityId
                                       districtId:self.districtId];
    }
    
}

//指定列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    // 宽度
    return COMPONENT_WIDTH;
}


#pragma mark - Private
- (UILabel *)labelForPickerView
{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor colorWithRed:85/255 green:85/255 blue:85/255 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    return label;
}

- (NSString *)titleForComponent:(NSInteger)component row:(NSInteger)row;
{
    switch (component)
    {
        case PROVINCE_COMPONENT: return [self.provinceArr objectAtIndex:row];
        case CITY_COMPONENT:     return [self.cityArr objectAtIndex:row];
        case DISCTRCT_COMPONENT: return [self.districtArr objectAtIndex:row];

    }
    
    return @"";
    
}


#pragma mark - Getter and Setter
- (NSArray *)provinceArr
{
    if (!_provinceArr)
    {
        NSMutableArray *tmp = [NSMutableArray array];
        for (HZZPccItem *item in _provinceArray) {
            [tmp addObject:item.name];
        }
        _provinceArr = tmp;
    }
    return _provinceArr;
}


@end
