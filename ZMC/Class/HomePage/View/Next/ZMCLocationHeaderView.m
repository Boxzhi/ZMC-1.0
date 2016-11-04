//
//  ZMCLocationHeaderView.m
//  ZMC
//
//  Created by MindminiMac on 16/5/12.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCLocationHeaderView.h"

@implementation ZMCLocationHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (ZMCLocationHeaderView *)instanceHeaderView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"ZMCLocationHeaderView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void)layoutSubviews
{
    self.searchBar.backgroundImage = [UIImage new];
}
@end
