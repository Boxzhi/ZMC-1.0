//
//  MenuClassifyCell.h
//  ZMC
//
//  Created by Naive on 16/5/24.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCategoryModel.h"
#import "HistoryMerchantModel.h"

@interface MenuClassifyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *menuTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *menuBgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *menuSignImgView;

- (void)setMenuClassify:(GoodsCategoryChilds *)child;

- (void)setMenuMercant:(HistoryMerchantData *)data;

@end
