//
//  BoardAndLineButton.m
//  YiHaiFarm
//
//  Created by Daniel on 15/12/30.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "BoardAndLineButton.h"

@implementation BoardAndLineButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         [self setStyle];
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
         [self setStyle];
        
    }
    return self;
}

- (void)awakeFromNib
{
    
    [self setStyle];
    
}

- (void)setStyle{
    
    self.layer.borderColor =ORANGE_COLOR.CGColor;
    self.layer.borderWidth =0.5f;
    self.layer.cornerRadius =3.0f;
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.layer setBorderColor:ORANGE_COLOR.CGColor];
    [self setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    
}

- (instancetype)initWithColor:(UIColor *)color{
    if (self = [super init]) {
        
        [self.layer setBorderColor:color.CGColor];
        [self setTitleColor:color forState:UIControlStateNormal];
        
    }
    return self;
    
}


- (void)setCustomColor:(UIColor *)color{
    self.layer.borderColor =color.CGColor;
    [self.layer setBorderColor:color.CGColor];
    [self setTitleColor:color forState:UIControlStateNormal];
}
@end
