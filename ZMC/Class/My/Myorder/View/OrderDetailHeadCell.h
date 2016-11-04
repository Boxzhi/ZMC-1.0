//
//  OrderDetailHeadCell.h
//  ZMC
//
//  Created by Naive on 16/6/2.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *address_lab;
@property (weak, nonatomic) IBOutlet UILabel *mobile_lab;
@property (weak, nonatomic) IBOutlet UILabel *orderSn_lab;
@property (weak, nonatomic) IBOutlet UILabel *orderTime_lab;
@property (weak, nonatomic) IBOutlet UILabel *selectTime_lab;
@property (weak, nonatomic) IBOutlet UILabel *consignee_lab;

@end
