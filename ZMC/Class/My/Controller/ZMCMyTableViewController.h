//
//  ZMCMyTableViewController.h
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCBaseTableViewController.h"

@interface ZMCMyTableViewController : ZMCBaseTableViewController
- (void)presentRegisterVCAction;
+ (ZMCMyTableViewController *)shared;
@end
