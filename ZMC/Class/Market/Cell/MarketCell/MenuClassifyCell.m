//
//  MenuClassifyCell.m
//  ZMC
//
//  Created by Naive on 16/5/24.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "MenuClassifyCell.h"


@implementation MenuClassifyCell


- (void)setMenuClassify:(GoodsCategoryChilds *)child {
    
    self.menuTitleLab.text = child.name;
}

- (void)setMenuMercant:(HistoryMerchantData *)data {
    
    self.menuTitleLab.text = data.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.menuSignImgView.alpha = 1;
        self.menuTitleLab.textColor = ThemeGreenColor;
    }else {
        self.menuSignImgView.alpha = 0;
        self.menuTitleLab.textColor = StringMiddleColor;
    }
}


@end
