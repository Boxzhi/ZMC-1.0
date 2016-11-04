//
//  CookTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/4/21.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCCookTableViewCell : UITableViewCell

//厨师的头像
@property (weak, nonatomic) IBOutlet UIImageView *cookHeaderView;

//厨师的名字
@property (weak, nonatomic) IBOutlet UILabel *cookName;

//厨师的年龄和地方
@property (weak, nonatomic) IBOutlet UILabel *cookAgeAndFrom;

//菜名
@property (weak, nonatomic) IBOutlet UILabel *dishName;

//菜系
@property (weak, nonatomic) IBOutlet UILabel *cookStyle;

//大厨评价的星星,xib中是5颗星的imageview和图片
@property (weak, nonatomic) IBOutlet UIImageView *markStarsImage;

@end
