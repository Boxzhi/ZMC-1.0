//
//  GoodsDetailHeadCell.m
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "GoodsDetailHeadCell.h"


@implementation GoodsDetailHeadCell

- (void)setGoodsDetailHead:(GoodsDetailResult *)model {
    
    self.goodsImg.contentSize = CGSizeMake(model.pic_list.count * SCREEN_W, 0);
    self.goodsImg.showsHorizontalScrollIndicator = NO;
    self.goodsImg.delegate = self;
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 2 / 3) delegate:self placeholderImage:[UIImage imageNamed:@"shangpinxiangqing"]];
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.backgroundColor = [UIColor clearColor];
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [self.goodsImg addSubview:cycleScrollView];
    cycleScrollView.autoScrollTimeInterval = 100;
    
    NSMutableArray *image = [NSMutableArray array];
    for (int i = 0; i < model.pic_list.count;i++)
    {
        [image addObject:model.pic_list[i].pic];
    }
    NSArray *imageURL = [image copy];
    cycleScrollView.imageURLStringsGroup = imageURL;
    
    self.goodsName_lab.text = model.name;
    self.goodsPrice_lab.attributedText = [[Singer share] getGoodsMutStrWithPrice:[NSString stringWithFormat:@"%.2f",model.price] unit:ChangeNSIntegerToStr(model.unit) unitName:[NSString stringWithFormat:@"%@",CHECK_VALUE(model.unit_name)] leftColor:ThemeGreenColor rightClor:[UIColor lightGrayColor] leftFont:0 rightFont:0];
    
    // 原价
    if (model.nature == 2 || model.nature == 3) {
        
        NSString *oldPrice = [NSString stringWithFormat:@"原价:￥%.2f/%ld%@", [model.original_price doubleValue] , model.original_unit, model.original_unit_name];
        NSUInteger length = [oldPrice length];
        
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice];
        [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(3, length-3)];
        
        [attri addAttribute:NSStrikethroughColorAttributeName value:UIColorFromRGB(0x999999) range:NSMakeRange(3, length-3)];
        
//        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
//        // 赋值
//        strikeLabel.attributedText = attribtStr;
        
        [self.merchantName_lab setAttributedText:attri];
        
        ZMCLog(@"nature------->>>>>>>%ld", model.nature);
    }else{
        self.merchantName_lab.text = @" ";
    }
    
//    self.merchantName_lab.text = model.merchant_name;
    if (model.short_intro.length == 0) {
        self.goodsDescription_lab.hidden = YES;
    }else {
        self.goodsDescription_lab.hidden = NO;
        self.goodsDescription_lab.text = model.short_intro;
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
