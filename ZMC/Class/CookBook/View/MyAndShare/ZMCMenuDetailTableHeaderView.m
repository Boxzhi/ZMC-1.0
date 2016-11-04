//
//  MenuDetailTableHeaderView.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMenuDetailTableHeaderView.h"
#import "ZMCMyDetailHeaderItem.h"

@interface ZMCMenuDetailTableHeaderView()

/**
 *  宴会的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *activityName;

/**
 *  宴会的菜的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *activityNumber;

/**
 *  宴会开始时间
 */
@property (weak, nonatomic) IBOutlet UILabel *activityStart;


/**
 *  宴会结束时间
 */
@property (weak, nonatomic) IBOutlet UILabel *activityEnd;

@end

@implementation ZMCMenuDetailTableHeaderView


+ (ZMCMenuDetailTableHeaderView *)instanceHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ZMCMenuDetailTableHeaderView" owner:nil options:nil][0];
}


- (void)setItem:(ZMCMyDetailHeaderItem *)item{
    _item = item;
    
    self.activityName.text = item.title;
    
    self.activityNumber.text = [NSString stringWithFormat:@"共有 %@ 道菜", item.total_count];
    
    self.activityStart.text = item.start_time;
    
    self.activityEnd.text = item.end_time;
}

@end
