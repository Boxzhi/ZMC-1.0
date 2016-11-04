//
//  ClothesTailCell.m
//  ZMC
//
//  Created by Naive on 16/6/1.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ClothesTailCell.h"

@implementation ClothesTailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.logisticsDes_labOne setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",linkText];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
