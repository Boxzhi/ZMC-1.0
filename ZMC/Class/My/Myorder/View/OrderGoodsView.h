//
//  OrderGoodsView.h
//  ZMC
//
//  Created by Naive on 16/5/31.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderGoodsView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *goodsName_imgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsTotalPrice_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum_lab;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@end
