//
//  MenuDetailTableHeaderView.h
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMCMyDetailHeaderItem;
@interface ZMCMenuDetailTableHeaderView : UIView


+ (ZMCMenuDetailTableHeaderView *)instanceHeaderView;

@property (nonatomic, strong) ZMCMyDetailHeaderItem *item;


@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
