
//
//  GoodsCell.m
//  ZMC
//
//  Created by Naive on 16/5/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "GoodsCell.h"

@implementation GoodsCell

- (void)setGoodsInfo:(GoodsListData *)data {
    
    [self.goodsImgView sd_setImageWithURL:GET_IMAGEURL_URL(data.thumb) placeholderImage:[UIImage imageNamed:@"cailanzi.png"]];
//    [self.goodsImgView sd_setImageWithURL:GET_IMAGEURL_URL(data.thumb)];
    self.goodsName_lab.text = data.name;
    self.goodsMerchantName_lab.text = data.merchant_name;

    self.goodsPrice_lab.attributedText = [[Singer share] getGoodsMutStrWithPrice:[NSString stringWithFormat:@"%.2f",data.price] unit:ChangeNSIntegerToStr(data.unit) unitName:data.unit_name leftColor:ThemeGreenColor rightClor:nil leftFont:18 rightFont:0];
    
    if (data.shop_cart_count > 0) {
        
        self.goodsReduce_btn.alpha = 1;
        self.goodsNumber_lab.text = ChangeNSIntegerToStr(data.shop_cart_count);
    }else {
        self.goodsReduce_btn.alpha = 0;
        self.goodsNumber_lab.text = @"";
    }
}
//-(void)prepareForReuse
//{
//    [self.goodsImgView sd_cancelCurrentImageLoad];
//
//}


@end
