//
//  ReceiptAddressCell.h
//  ZMC
//
//  Created by Naive on 16/5/25.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptAddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName_lab;
@property (weak, nonatomic) IBOutlet UILabel *userMobile_lab;
@property (weak, nonatomic) IBOutlet UILabel *userAddress_lab;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

- (void)setReceiptAddress;

@end
