//
//  ZMCSearchResultViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/5/12.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LocationMarketModel;
typedef void(^returnMarketModelBlock)(LocationMarketModel *model);


@interface ZMCSearchResultViewController : UIViewController



@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *searchText;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) NSDictionary *pccInfo;

//@property (nonatomic, strong) returnMarketModelBlock returnMarketModelBlock;
//用的属性传值，没用block


@end
