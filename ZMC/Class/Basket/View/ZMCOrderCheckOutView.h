//
//  ZMCOrderCheckOutView.h
//  ZMC
//
//  Created by Naive on 16/7/6.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCOrderCheckOutView : UIView

@property (weak, nonatomic) IBOutlet UILabel *userName_lab;
@property (weak, nonatomic) IBOutlet UILabel *userMobile_lab;
@property (weak, nonatomic) IBOutlet UILabel *userAddress_lab;
@property (weak, nonatomic) IBOutlet UILabel *currentMarket_lab;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumber_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;

@property (weak, nonatomic) IBOutlet UILabel *distributionTime_lab;
@property (weak, nonatomic) IBOutlet UILabel *coupon_lab;
@property (weak, nonatomic) IBOutlet UILabel *points_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsMoney_lab;
@property (weak, nonatomic) IBOutlet UILabel *balance_lab;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney_lab;
@property (weak, nonatomic) IBOutlet UILabel *discountMoney_lab;
@property (weak, nonatomic) IBOutlet UITextField *remark_textField;
@property (weak, nonatomic) IBOutlet UILabel *freight_lab;

@property (weak, nonatomic) IBOutlet UIButton *selectAddress_btn;
@property (weak, nonatomic) IBOutlet UIButton *selectTime_btn;
@property (weak, nonatomic) IBOutlet UIButton *selectCoupon_btn;
@property (weak, nonatomic) IBOutlet UIButton *selectPoint_btn;
@property (weak, nonatomic) IBOutlet UIButton *chongZhi_btn;

@property (weak, nonatomic) IBOutlet UILabel *freight_limit_lab;


@end
