//
//  ZMCBalanceTableViewCell.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCBalanceTableViewCell.h"
#import "ZMCBalanceItem.h"

@interface ZMCBalanceTableViewCell()

// 描述
@property (weak, nonatomic) IBOutlet UILabel *useLabel;

// 余额数
@property (weak, nonatomic) IBOutlet UILabel *balLabel;

// 支出数
@property (weak, nonatomic) IBOutlet UILabel *payLabel;

// 日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation ZMCBalanceTableViewCell

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 1;
    
    [super setFrame:frame];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(ZMCBalanceItem *)item{
    _item = item;
    
    NSString *str = [NSString stringWithFormat:@"充值（%@）", item.order_sn];
    
    if ([item.source  isEqual:@1]) {
        self.useLabel.text = str;
    }else if ([item.source isEqual:@2]){
        self.useLabel.text = @"消费";
    }else if ([item.source isEqual:@3]){
        self.useLabel.text = @"人工修改";
    }
    
    self.balLabel.text = [NSString stringWithFormat:@" %.2f元", [item.history_balance floatValue]];
    
    self.payLabel.text = item.money;
    NSRange range = [self.payLabel.text rangeOfString:@"+"];
    if (range.location != NSNotFound) {
        self.payLabel.textColor = RGB(36, 180, 80);
    }else{
        self.payLabel.textColor = RGB(85, 85, 85);
    }
    
    self.dateLabel.text = item.create_time;
    
}

@end
