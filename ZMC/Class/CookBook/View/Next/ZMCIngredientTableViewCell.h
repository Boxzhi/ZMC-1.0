//
//  IngredientTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCIngredientTableViewCell : UITableViewCell

/**
 *  主料的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *ingredientPicture;

/**
 *  主料的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *ingredientName;

/**
 *  主料的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *ingredientPrice;

/**
 *  添加主料到购物车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *addBasketButton;

/**
 *  主料的数量和单位
 */
@property (weak, nonatomic) IBOutlet UILabel *ingredientCount;

/**
 *  单位和单位名字
 */
@property (weak, nonatomic) IBOutlet UILabel *unitAndUnit_name;


@end
