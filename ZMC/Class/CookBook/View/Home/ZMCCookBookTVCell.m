//
//  ZMCCookBookTVCell.m
//  ZMC
//
//  Created by 睿途网络 on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCookBookTVCell.h"
#import "CookBookModel.h"
#import "UIImageView+Header.h"

@implementation ZMCCookBookTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)getModelDataToControl:(CookBookModel *)model {
    
    __weak typeof(self)weakSelf = self;
    
    dispatch_queue_t queue = dispatch_queue_create("Ljun", NULL);
    
    dispatch_async(queue, ^{
        
        NSString *string = [NSString stringWithFormat:@"已有%@人选择", model.selected_count];
        
        weakSelf.dishName.text = model.name;
        weakSelf.selectNum.text = string;
        [weakSelf.dishPic zmc_swtGoodCook:model.pic];
        
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
