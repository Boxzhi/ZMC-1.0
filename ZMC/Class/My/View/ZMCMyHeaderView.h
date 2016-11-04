//
//  ZMCMyHeaderView.h
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ZMCMyHeaderItem;
@interface ZMCMyHeaderView : UIView

// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// 签名
@property (weak, nonatomic) IBOutlet UILabel *autographLabel;
// 会员图标
@property (weak, nonatomic) IBOutlet UIImageView *memberImage;
// 余额
@property (weak, nonatomic) IBOutlet UIView *balanceView;
// 积分
@property (weak, nonatomic) IBOutlet UIView *myIntegralView;
// 待配送
@property (weak, nonatomic) IBOutlet UIView *AdistributionView;
// 配送中
@property (weak, nonatomic) IBOutlet UIView *BdistributionView;
// 已收货
@property (weak, nonatomic) IBOutlet UIView *CdistributionView;
// 我的订单
@property (weak, nonatomic) IBOutlet UIView *allOrder;

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

// 余额
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

// 冻结金额
@property (weak, nonatomic) IBOutlet UILabel *frozenLabel;
// 积分
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;

@property (nonatomic, strong) ZMCMyHeaderItem *item;

// 登录注册
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


// 头像昵称所在的View
@property (weak, nonatomic) IBOutlet UIView *totlView;

// 会员图标所在的View
//@property (weak, nonatomic) IBOutlet UIView *memBerView;


+ (instancetype)myHeaderView;
@end
