//
//  ZMCRecordTableViewCell.m
//  ZMC
//
//  Created by Will on 16/5/6.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCRecordTableViewCell.h"
#import "ZMCPaymetsItem.h"


@interface ZMCRecordTableViewCell()

// 退款金额
@property (weak, nonatomic) IBOutlet UILabel *rfundMoney;
// 退款时间
@property (weak, nonatomic) IBOutlet UILabel *refundTime;
// 退款状态
@property (weak, nonatomic) IBOutlet UILabel *status;
// 退款状态名称
@property (weak, nonatomic) IBOutlet UILabel *status_name;

@end

@implementation ZMCRecordTableViewCell

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setItem:(ZMCPaymetsItem *)item
{
    _item = item;
    
    self.rfundMoney.text = [NSString stringWithFormat:@"¥ %@", item.refund_money];
    
    self.refundTime.text = item.refund_time;
    
    self.status_name.text = item.status_name;
    
    switch ([item.status integerValue]) {
        case 1:
            self.status.text = @"退款";
            break;
        case 2:
            // 已退
            self.status.text = @"已退";
            break;
            
        default:
            break;
    }
}

@end
