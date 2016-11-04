//
//  BasketTableViewCell.m
//  ZMC
//
//  Created by MindminiMac on 16/4/21.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCBasketTableViewCell.h"

@implementation ZMCBasketTableViewCell

- (void)setBaseketCooksInfo:(ShoppongCartsCooks *)model {
    
    [self.goodsImageView sd_setImageWithURL:GET_IMAGEURL_URL(model.avatar) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
    self.goodsTitleLabel.text = model.name;
    self.goodsPrice.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2ld",(long)model.price] unit:@"元" unitName:@"小时" leftColor:ThemeGreenColor rightClor:nil];
    self.goodsCountTF.text = ChangeNSIntegerToStr(model.quantity);
    self.activie_lab.text = @"";
}

- (void)setBaseketGoodsInfo:(ShoppongCartsGooods *)model {
    
    [self.goodsImageView sd_setImageWithURL:GET_IMAGEURL_URL(model.pic) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
    self.goodsTitleLabel.text = model.goods_name;
    self.goodsPrice.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2f",model.price] unit:ChangeNSIntegerToStr(model.unit) unitName:model.unit_name leftColor:ThemeGreenColor rightClor:nil];
    self.goodsCountTF.text = ChangeNSIntegerToStr(model.quantity);
    
    if (model.nature == 2) {
        self.activie_lab.text = @"";
//        self.goodsPrice.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2f",model.original_price] unit:ChangeNSIntegerToStr(model.original_unit) unitName:model.original_unit_name leftColor:ThemeGreenColor rightClor:nil];
    }else if (model.nature == 3){
//        self.activie_lab.text = [NSString stringWithFormat:@"超出限购的商品，不再享受特价¥%.2f/%ld%@",model.original_price,(long)model.original_unit,model.original_unit_name];
        self.activie_lab.text = @"超出限购的商品，不再享受特价";
    }else {
        self.activie_lab.text = @"";
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
