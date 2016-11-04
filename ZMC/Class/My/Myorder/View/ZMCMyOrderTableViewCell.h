//
//  ZMCMyOrderTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/5/10.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListModel.h"
#import "OrderGoodsView.h"

@interface ZMCMyOrderTableViewCell<UIAlertViewDelegate> : UITableViewCell {
    
    NSInteger select_orderID;
    NSInteger select_id;
    
    OrderGoodsView *orderGoodsView;
    
    UIButton *cancel_btn;
}
@property (weak, nonatomic) IBOutlet UIView *headView;

/**
 *  店铺名称
 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;

/**
 *  订单号
 */
@property (weak, nonatomic) IBOutlet UILabel *orderNum;

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;

/**
 *  商品名字
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

/**
 *  商品数量
 */
@property (weak, nonatomic) IBOutlet UILabel *count;

/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *price;

/**
 *  商品单位和单位名称
 */
@property (weak, nonatomic) IBOutlet UILabel *unitAndunitName;

/**
 *  订单金额
 */
@property (weak, nonatomic) IBOutlet UILabel *money;

/**
 *  取消订单
 */
@property (weak, nonatomic) IBOutlet UIButton *cancelOrder;

//@property (nonatomic,assign) int order_status;

- (void)setOrderInfo:(OrderListOrderBizs *)model WithOrderStatus:(NSInteger)order_status WithOrderId:(NSInteger)order_id WithCreate_time:(NSString *)create_time WithNavigationController:(UINavigationController *)navigationController;

- (void)setOrderCookInfo:(OrderListOrderCook *)model WithOrderStatus:(NSInteger)order_status WithOrderId:(NSInteger)order_id WithNavigationController:(UINavigationController *)navigationController;

@end
