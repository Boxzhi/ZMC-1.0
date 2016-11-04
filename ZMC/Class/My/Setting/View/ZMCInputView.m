//
//  ZMCInputView.m
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCInputView.h"

@interface ZMCInputView()


@end

@implementation ZMCInputView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.nameField.tintColor = [UIColor grayColor];
    self.autographField.tintColor = [UIColor grayColor];

}


+ (instancetype)InputView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
    
}

@end
