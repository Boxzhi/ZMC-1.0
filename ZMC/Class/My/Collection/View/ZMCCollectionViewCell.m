//
//  ZMCCollectionViewCell.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZMCCollectionItem.h"


@interface ZMCCollectionViewCell()
// 蔬水图片
@property (weak, nonatomic) IBOutlet UIImageView *fruitImageView;
// 蔬果店名
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
// 购买人数
@property (weak, nonatomic) IBOutlet UILabel *peopleNmLabel;
// 菜场名称
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;

@end

@implementation ZMCCollectionViewCell

//- (void)setFrame:(CGRect)frame{
//    
//    frame.size.height -= 1;
//    [super setFrame:frame];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setItem:(ZMCCollectionItem *)item{
    _item = item;
    
    [self.fruitImageView sd_setImageWithURL:[NSURL URLWithString:item.pic] placeholderImage:[UIImage imageNamed:@"shoucang"] completed:nil];
    
    self.storeLabel.text = item.name;
    self.peopleNmLabel.text = [NSString stringWithFormat:@"%ld人收藏", (long)item.collection_count];
    self.marketLabel.text = item.market_name;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
