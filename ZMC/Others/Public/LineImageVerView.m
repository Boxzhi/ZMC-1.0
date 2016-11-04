//
//  LineImageVerView.m
//  WashApp
//
//  Created by Daniel on 15/3/31.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import "LineImageVerView.h"

@implementation LineImageVerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 0.5, self.frame.size.height);
        self.backgroundColor = RGBACOLOR(199, 199, 204, 0.8f);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 0.5, self.frame.size.height);
        self.backgroundColor = RGBACOLOR(199, 199, 204, 0.8f);
    }
    return self;
}

- (void)awakeFromNib
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 0.5, self.frame.size.height);
    self.backgroundColor = RGBACOLOR(199, 199, 204, 0.8f);
}
@end
