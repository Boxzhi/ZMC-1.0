//
//  LocationViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/4/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationMarketModel.h"

@class LocationMarketModel;
typedef void (^ReturnMarketArrayBlock)(LocationMarketModel *model);



@interface ZMCLocationViewController : UIViewController

@property (nonatomic, strong) NSArray *markets;

@property (nonatomic, strong) NSString *provincesStr;
@property (nonatomic, strong) NSString *cityStr;
@property (nonatomic, strong) NSString *countyStr;

@property (nonatomic, copy) ReturnMarketArrayBlock returnMarketArrayBlock;

/**
 *  用block把搜索或者定位出来的菜场数组，传到首页
 *
 *  @param block block传值
 */
- (void)returnMarketArray:(ReturnMarketArrayBlock)block;
@end
