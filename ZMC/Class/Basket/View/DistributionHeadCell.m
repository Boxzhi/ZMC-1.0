//
//  DistributionHeadCell.m
//  YiHaiFarm
//
//  Created by Naive on 15/12/7.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "DistributionHeadCell.h"

@implementation DistributionHeadCell

- (void)headShow
{
    NSString *date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    date = [formatter stringFromDate:[NSDate date]];
    self.headTitle.text = [NSString stringWithFormat:@"今天是%@,当天20:00之后下的订单，后天配送。",date];
}

@end
