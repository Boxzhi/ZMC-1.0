//
//  ZMCMarketViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "RefreshTableViewController.h"
#import "MenuData.h"
#import "MenuItemCell.h"


@interface ZMCMarketViewController : RefreshTableViewController

@property (nonatomic, copy) void (^callBack) (NSString *currentNum);

@property (nonatomic,strong)NSIndexPath *myIndexPath;
@property (nonatomic,strong)MenuData *menuData;

@end
