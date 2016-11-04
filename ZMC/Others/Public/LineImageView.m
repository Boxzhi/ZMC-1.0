//
//  LineImageView.m
//  YueDongApp
//
//  Created byDaniel on 14-8-15.
//  Copyright (c) 2014年Daniel. All rights reserved.
//

#import "LineImageView.h"

@implementation LineImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0.5);
        self.backgroundColor = RGBACOLOR(199, 199, 204, 1.0f);
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0.5);
        self.backgroundColor = RGBACOLOR(199, 199, 204, 1.0f);
    }
    return self;
}

- (void)awakeFromNib
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 0.5);
    self.backgroundColor = RGBACOLOR(199, 199, 204, 1.0f);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
