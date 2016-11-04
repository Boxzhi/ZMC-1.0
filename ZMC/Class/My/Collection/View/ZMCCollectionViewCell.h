//
//  ZMCCollectionViewCell.h
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMCCollectionItem;
@interface ZMCCollectionViewCell : UITableViewCell

@property (nonatomic, strong) ZMCCollectionItem *item;

@end
