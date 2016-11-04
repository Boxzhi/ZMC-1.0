//
//  GoodsCell.h
//  ZMC
//
//  Created by Naive on 16/5/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface GoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsMerchantName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumber_lab;
@property (weak, nonatomic) IBOutlet UIButton *goodsReduce_btn;
@property (weak, nonatomic) IBOutlet UIButton *goodsIncrease_btn;

- (void)setGoodsInfo:(GoodsListData *)data;

@end
