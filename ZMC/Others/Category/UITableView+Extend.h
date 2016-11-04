//
//  UITableView+Extend.h
//  SNS-New
//
//  Created by hexin on 14-9-10.
//  Copyright (c) 2014年 myhexin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReloadDataBlock)();

@interface UITableView(Extend)

- (void)setExtraCellLineHidden;
- (void)initTableView:(UIViewController*)parent;
-(void)setFooterViewNetWorkError:(BOOL)isReachable withBlock:(ReloadDataBlock)block;
@end
