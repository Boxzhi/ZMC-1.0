//
//  DistributionTimeCell.m
//  YiHaiFarm
//
//  Created by Naive on 15/12/7.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "DistributionTimeCell.h"

@implementation DistributionTimeCell

- (void)setDistributionTime:(DistributionTimeModel *)model
{
    self.dateLable.text = model.date;
    self.weekLable.text = model.week;
//    self.dayLable.text = model.day;
    self.shangWuLable.text = [NSString stringWithFormat:@"上午%@",CHECK_VALUE(model.shangWuTime)];
    
//    if (model.button1 == -1) {
//        self.shangWuButton.hidden = YES;
//    }else{
//       self.shangWuButton.hidden = NO;
//    }
    
    if (model.button1 == 1) {
        self.shangWuLable.textColor = ThemeGreenColor;
        [self.shangWuButton setImage:[UIImage imageNamed:@"choose_pre"] forState:UIControlStateNormal];
    }else {
        self.shangWuLable.textColor = [UIColor darkGrayColor];
        [self.shangWuButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    }
    self.xiaWuLable.text = [NSString stringWithFormat:@"下午%@",model.xiaWuTime];
    
    
    if (model.button2 == 1) {
        self.xiaWuLable.textColor = ThemeGreenColor;
        [self.xiaWuButton setImage:[UIImage imageNamed:@"choose_pre"] forState:UIControlStateNormal];
    }else {
        self.xiaWuLable.textColor = [UIColor darkGrayColor];
        [self.xiaWuButton setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    }
    
    
    if (model.button1 == 1 || model.button2 == 1) {
        self.dateLable.textColor = ThemeGreenColor;
        self.weekLable.textColor = ThemeGreenColor;
//        self.dayLable.textColor = ORANGE_COLOR;
        self.bgView.backgroundColor = CELL_ORANGE_COLOR;
    }else {
        self.dateLable.textColor = [UIColor darkGrayColor];
        self.weekLable.textColor = [UIColor darkGrayColor];
//        self.dayLable.textColor = [UIColor darkGrayColor];
        self.bgView.backgroundColor = WHITE_COLOR;
    }
}

@end
