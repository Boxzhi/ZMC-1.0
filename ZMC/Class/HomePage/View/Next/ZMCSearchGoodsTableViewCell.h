//
//  ZMCSearchGoodsTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/5/11.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCSearchGoodsTableViewCell : UITableViewCell

/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsPicture;

/**
 *  商品名字
 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;

/**
 *  商品价格
 */
@property (weak, nonatomic) IBOutlet UILabel *price;

/**
 *  单位和单位名字
 */
@property (weak, nonatomic) IBOutlet UILabel *unitAndName;

/**
 *  店铺的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *shopName;



@end
