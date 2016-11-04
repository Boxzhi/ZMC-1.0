//
//  ZMCHomePageViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "RefreshTableViewController.h"

@class LocationMarketModel;
@interface ZMCHomePageViewController : RefreshTableViewController

- (void)startLocationService;

@property (nonatomic, strong) NSArray *markets;

@property (nonatomic, strong) LocationMarketModel *locationModel;

@end
