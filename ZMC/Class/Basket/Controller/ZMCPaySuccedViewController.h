//
//  ZMCPaySuccedViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCPaySuccedViewController : UIViewController


@property(nonatomic,strong) NSString *money;

@property(nonatomic,strong) NSString *frozen;

@property(nonatomic,strong) NSString *order_id;

/**
 *  支付结果的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;

/**
 *  支付结果的文字提示
 */
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

/**
 *  支付的钱
 */
//@property (weak, nonatomic) IBOutlet UILabel *payMoneyLabel;

/**
 *  冻结的钱
 */
//@property (weak, nonatomic) IBOutlet UILabel *frozenMoney;

/**
 *  查看详情label
 */
//@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
