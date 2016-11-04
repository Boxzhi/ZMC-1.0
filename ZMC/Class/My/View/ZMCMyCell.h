//
//  ZMCMyCell.h
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZMCMyItem.h"
#import "ZMCMyArrowItem.h"
#import "ZMCMyGroupItem.h"
@interface ZMCMyCell : UITableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView;

+ (instancetype)cellWithTabelView:(UITableView *)tableView style:(UITableViewCellStyle)style;

/** 行模型*/
@property (nonatomic ,strong)ZMCMyItem *item;
@end
