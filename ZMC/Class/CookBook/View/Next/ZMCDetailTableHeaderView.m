//
//  ZMCDetailTableHeaderView.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCDetailTableHeaderView.h"

@implementation ZMCDetailTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (ZMCDetailTableHeaderView *)instanceHeaderView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZMCDetailTableHeaderView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

@end
