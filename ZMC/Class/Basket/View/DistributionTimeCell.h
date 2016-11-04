//
//  DistributionTimeCell.h
//  YiHaiFarm
//
//  Created by Naive on 15/12/7.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DistributionTimeModel.h"

@interface DistributionTimeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
/**
 *  日期
 */
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
/**
 *  星期
 */
@property (weak, nonatomic) IBOutlet UILabel *weekLable;
/**
 *  天
 */
//@property (weak, nonatomic) IBOutlet UILabel *dayLable;
/**
 *  上午时间
 */
@property (weak, nonatomic) IBOutlet UILabel *shangWuLable;
/**
 *  下午时间
 */
@property (weak, nonatomic) IBOutlet UILabel *xiaWuLable;
/**
 *  按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *shangWuButton;
@property (weak, nonatomic) IBOutlet UIButton *xiaWuButton;

- (void)setDistributionTime:(DistributionTimeModel *)model;
@end
