//
//  PopView.m
//  ZMC
//
//  Created by MindminiMac on 16/5/4.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//
#define ButtonTitleFont [UIFont systemFontOfSize:15]
#define ButtonBackgroundColor UIColorFromRGB(0xf4f4f4)
#define ButtonTitleColor StringMiddleColor


#import "ZMCPopView.h"

@implementation ZMCPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame andButtonTitleArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
//        CGFloat x = frame.origin.x;
//        CGFloat y = frame.origin.y;
        CGFloat w = frame.size.width;
        CGFloat h = frame.size.height;
        h = h - 5;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(11, 0, 27, 5)];
        image.image = [UIImage imageNamed:@"tankuang"];
        [self addSubview:image];
        
        for (int i =0; i <array.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.frame = CGRectMake(0, 5 + h / array.count *i, w, h / array.count - 1);
            [button addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
            button.backgroundColor = ButtonBackgroundColor;
            
            [button setTitleColor:ButtonTitleColor forState:UIControlStateNormal];
            button.titleLabel.font = ButtonTitleFont;
            [self addSubview:button];
            button.tag = 100 +i;
        }

    }
    return self;
}

- (void)remove
{
    [self removeFromSuperview];
}

- (void)selectItem:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(popView:didSelectButtonWithTag:)]) {
        [self.delegate popView:self didSelectButtonWithTag:button.tag];
    }
}


@end
