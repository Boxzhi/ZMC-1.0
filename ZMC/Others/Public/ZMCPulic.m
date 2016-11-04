//
//  ZMCPulic.m
//  ZMC
//
//  Created by 睿途网络 on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCPulic.h"

@implementation ZMCPulic

{
    NSInteger number;
    
}

+ (void)plusTapped:(UIButton *)button getMinusButton:(UIButton *)mButton getCountLabel:(UILabel *) label {
    
    if ([label.text intValue] <= 98) {
    
        int newNum = [label.text intValue] + 1;
        
        label.text = [NSString stringWithFormat:@"%d", newNum];
        
        mButton.alpha = 1;
        
        [mButton setImage:[UIImage imageNamed:@"minus_pre"] forState:(UIControlStateNormal)];
        
    }else {
    
        button.adjustsImageWhenHighlighted = NO;
        
        return;
    }
    
}

+ (void)minusTapped:(UIButton *)button getCountLabel:(UILabel *) label {
    
    if ([label.text isEqualToString:@"0"]) {
        
        button.adjustsImageWhenHighlighted = NO;
        
        return;
        
    }else if ([label.text isEqualToString:@"1"]) {
        
        [button setImage:[UIImage imageNamed:@"minus"] forState:(UIControlStateNormal)];
        
//        int newNum = [label.text intValue] - 1;
        
//        label.text = [NSString stringWithFormat:@"%d", newNum];
        label.text = @"";
        
        button.adjustsImageWhenHighlighted = NO;
        
        button.alpha = 0;
        
    }else {
        
        int newNum = [label.text intValue] - 1;
        
        label.text = [NSString stringWithFormat:@"%d", newNum];
        
        [button setImage:[UIImage imageNamed:@"minus_pre"] forState:(UIControlStateNormal)];
    }
}

- (void)updateNumberLabel:(UILabel *)label {
    
    ZMCLog(@"走没走");
    
    label.text = [NSString stringWithFormat:@"%zd", number];
    
    ZMCLog(@"%zd", number);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (void)plusTFCountWithTF:(UITextField *)textField andMinusButton:(UIButton *)button
{
    if (![button.currentBackgroundImage isEqual:[UIImage imageNamed:@"minus_pre"]]) {
        [button setBackgroundImage:[UIImage imageNamed:@"minus_pre"] forState:UIControlStateNormal];
        button.userInteractionEnabled = YES;
    }
    textField.text = [NSString stringWithFormat:@"%d",[textField.text intValue] + 1];
    
}
+ (void)minusTFCountWithTF:(UITextField *)textField andMinusButton:(UIButton *)button
{
    if ([textField.text isEqualToString:@"1"]) {
        textField.text = @"0";
        [button setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
        button.userInteractionEnabled = NO;
        return;
    }
    textField.text = [NSString stringWithFormat:@"%d",[textField.text intValue] - 1];
    
}
@end
