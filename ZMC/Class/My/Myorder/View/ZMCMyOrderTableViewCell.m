//
//  ZMCMyOrderTableViewCell.m
//  ZMC
//
//  Created by MindminiMac on 16/5/10.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyOrderTableViewCell.h"
#import "PublishCommentsVC.h"

@implementation ZMCMyOrderTableViewCell

- (void)setOrderInfo:(OrderListOrderBizs *)model WithOrderStatus:(NSInteger)order_status WithOrderId:(NSInteger)order_id WithCreate_time:(NSString *)create_time WithNavigationController:(UINavigationController *)navigationController{
    
    self.shopName.text = model.merchant_name;
    self.orderNum.text = [NSString stringWithFormat:@"订单号:%@",model.biz_order_sn];
    
    UIView *view = self.headView;
    
    for (int i=0; i < model.goods.count; i++) {

        
        orderGoodsView = (OrderGoodsView *)[[[NSBundle mainBundle] loadNibNamed:@"OrderGoodsView" owner:nil options:nil]lastObject];
//        orderGoodsView.frame = CGRectMake(0, 40+110*i, self.contentView.frame.size.width, 110);
        [orderGoodsView.goodsName_imgView sd_setImageWithURL:GET_IMAGEURL_URL(model.goods[i].thumb) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
        orderGoodsView.goodsName_lab.text = model.goods[i].name;
        orderGoodsView.goodsNum_lab.text = [NSString stringWithFormat:@"X%ld",(long)model.goods[i].quantity];
        orderGoodsView.goodsPrice_lab.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2f",model.goods[i].price] unit:ChangeNSIntegerToStr(model.goods[i].unit) unitName:model.goods[i].unit_name leftColor:ThemeGreenColor rightClor:nil];
        orderGoodsView.goodsTotalPrice_lab.text = [NSString stringWithFormat:@"总价:%.2f",model.goods[i].actual_price];
        
//        if (model.status == 3) {
//            
//            [orderGoodsView.cancelBtn setTitle:@"已取消" forState:UIControlStateNormal];
//            orderGoodsView.cancelBtn.userInteractionEnabled = NO;
//        }else {
//            [orderGoodsView.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
//            orderGoodsView.cancelBtn.userInteractionEnabled = YES;
//        }
        
//        [[orderGoodsView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//            
//            [CommonHttpAPI postCancelOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)order_id] WithParameters:[CommonRequestModel getOrderCancelWithCook_id:@"" merchant_id:ChangeNSIntegerToStr(model.merchant_id)] success:^(NSURLSessionDataTask *task, id responseObject) {
//                
//                NSLog(@"%@",responseObject);
//                if ([responseObject getTheResultForDic]) {
//                    
//                    [OMGToast showWithText:@"订单已取消"];
//                    [orderGoodsView.cancelBtn setTitle:@"已取消" forState:UIControlStateNormal];
//                    orderGoodsView.cancelBtn.userInteractionEnabled = NO;
//                    
//                }else {
//                    
//                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
//                    
//                }
//                
//            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                NSLog(@"%@",error);
//            }];
//        }];
        
        [[orderGoodsView.commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            PublishCommentsVC *vc = [[PublishCommentsVC alloc] initWithNibName:@"PublishCommentsVC" bundle:nil];
            vc.goodsName = model.goods[i].name;
            vc.goodsImg = model.goods[i].thumb;
            vc.goodsPrice = [NSString stringWithFormat:@"%.2f",model.goods[i].price];
            vc.goodsUnit =ChangeNSIntegerToStr(model.goods[i].unit);
            vc.goodsUnitName = model.goods[i].unit_name;
            vc.goodsTime = create_time;
            vc.order_id = ChangeNSIntegerToStr(order_id);
            vc.goods_id =ChangeNSIntegerToStr(model.goods[i].goods_id);
            [navigationController pushViewController:vc animated:YES];
            
        }];
        
        if (order_status == 5) {
            if (model.goods[i].has_comment == 1) {
                orderGoodsView.commentBtn.hidden = YES;
            }else
                orderGoodsView.commentBtn.hidden = NO;
        }
        
        [self.contentView addSubview:orderGoodsView];
        
        [orderGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom);
            make.left.equalTo(view);
            make.right.equalTo(view);
            make.height.equalTo(@110);
        }];
        
        view = orderGoodsView;
    }
    
    cancel_btn = [[UIButton alloc] init];
    [cancel_btn setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancel_btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    cancel_btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if (model.status == 3) {
        
        [cancel_btn setTitle:@"已取消" forState:UIControlStateNormal];
        cancel_btn.userInteractionEnabled = NO;
    }else {
        [cancel_btn setTitle:@"取消订单" forState:UIControlStateNormal];
        cancel_btn.userInteractionEnabled = YES;
    }
//    if (order_status != 2) {
//        [cancel_btn setTitle:@"已完成" forState:UIControlStateNormal];
//        cancel_btn.userInteractionEnabled = NO;
//    }
    if (order_status == 1) {
        [cancel_btn setTitle:@"已取消" forState:UIControlStateNormal];
        cancel_btn.userInteractionEnabled = NO;
    }else if (order_status == 3) {
        [cancel_btn setTitle:@"配送中" forState:UIControlStateNormal];
        cancel_btn.userInteractionEnabled = NO;
    }else if (order_status == 4) {
        [cancel_btn setTitle:@"待收货" forState:UIControlStateNormal];
        cancel_btn.userInteractionEnabled = NO;
    }else if (order_status == 5) {
        [cancel_btn setTitle:@"已完成" forState:UIControlStateNormal];
        cancel_btn.userInteractionEnabled = NO;
    }
    
    [self.contentView addSubview:cancel_btn];
    [cancel_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(8);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(87);
    }];
//    if (order_status == 2) {
//        cancel_btn.hidden = NO;
//    }else {
//        cancel_btn.hidden = YES;
//    }

    [[cancel_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        select_orderID = order_id;
        select_id = model.merchant_id;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                    message:@"是否取消订单"
                                   delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil];
        [alertView show];
        alertView.tag = 6;
        
        
    }];
    
}

- (void)setOrderCookInfo:(OrderListOrderCook *)model WithOrderStatus:(NSInteger)order_status WithOrderId:(NSInteger)order_id WithNavigationController:(UINavigationController *)navigationController
{
    self.shopName.text = @"大厨到家";
    self.orderNum.text = @"";
    
    orderGoodsView = (OrderGoodsView *)[[[NSBundle mainBundle] loadNibNamed:@"OrderGoodsView" owner:nil options:nil]lastObject];
    //        orderGoodsView.frame = CGRectMake(0, 40+110*i, self.contentView.frame.size.width, 110);
    [orderGoodsView.goodsName_imgView sd_setImageWithURL:GET_IMAGEURL_URL(model.avatar_url) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
    orderGoodsView.goodsName_lab.text = model.cook_name;
    orderGoodsView.goodsNum_lab.text = [NSString stringWithFormat:@"X%ld",(long)model.quantity];
    orderGoodsView.goodsPrice_lab.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2f",model.price] unit:@"" unitName:model.unit leftColor:ThemeGreenColor rightClor:nil];
    orderGoodsView.goodsTotalPrice_lab.text = [NSString stringWithFormat:@"总价:%.2f",model.price * model.quantity];
    
    if (model.status == 2) {
        
        [orderGoodsView.cancelBtn setTitle:@"已取消" forState:UIControlStateNormal];
        orderGoodsView.cancelBtn.userInteractionEnabled = NO;
    }else {
        [orderGoodsView.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        orderGoodsView.cancelBtn.userInteractionEnabled = YES;
    }
    
    [[orderGoodsView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        select_orderID = order_id;
        select_id = model.cook_id;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"是否取消订单"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定",nil];
        [alertView show];
        alertView.tag = 7;
        
    }];
    
    [[orderGoodsView.commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        PublishCommentsVC *vc = [[PublishCommentsVC alloc] initWithNibName:@"PublishCommentsVC" bundle:nil];
        vc.is_cook = @"1";
        vc.goodsName = model.cook_name;
        vc.goodsImg = model.avatar_url;
        vc.goodsPrice = [NSString stringWithFormat:@"%.2f",model.price];
        vc.goodsUnit = model.unit;
//        vc.goodsUnitName = ;
        //            vc.goodsTime =
        vc.order_id = ChangeNSIntegerToStr(order_id);
        vc.goods_id =ChangeNSIntegerToStr(model.cook_id);
        [navigationController pushViewController:vc animated:YES];
        
    }];
    
    if (order_status == 2) {
        orderGoodsView.cancelBtn.hidden = NO;
    }else {
        orderGoodsView.cancelBtn.hidden = YES;
        if (order_status == 5) {
            if (model.has_comment == 1) {
                orderGoodsView.commentBtn.hidden = YES;
            }else
                orderGoodsView.commentBtn.hidden = NO;

        }
    }
    
    [self.contentView addSubview:orderGoodsView];
    
    [orderGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.left.equalTo(self.headView);
        make.right.equalTo(self.headView);
        make.height.equalTo(@110);
    }];
}

#pragma mark -UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        if (alertView.tag == 6) {
            [CommonHttpAPI postCancelOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)select_orderID] WithParameters:[CommonRequestModel getOrderCancelWithCook_id:@"" merchant_id:ChangeNSIntegerToStr(select_id)] success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                if ([responseObject getTheResultForDic]) {
                    
                    [OMGToast showWithText:@"订单已取消"];
                    [cancel_btn setTitle:@"已取消" forState:UIControlStateNormal];
                    cancel_btn.userInteractionEnabled = NO;
                    
                    //发送消息
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"refresh" object:nil userInfo:nil]];
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
            }];
        }else if(alertView.tag == 7) {
            [CommonHttpAPI postCancelOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)select_orderID] WithParameters:[CommonRequestModel getOrderCancelWithCook_id:ChangeNSIntegerToStr(select_id) merchant_id:@""] success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                if ([responseObject getTheResultForDic]) {
                    
                    [OMGToast showWithText:@"订单已取消"];
                    [orderGoodsView.cancelBtn setTitle:@"已取消" forState:UIControlStateNormal];
                    orderGoodsView.cancelBtn.userInteractionEnabled = NO;
                    
                    //发送消息
                    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"refresh" object:nil userInfo:nil]];
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
            }];
        }
    }
}

@end
