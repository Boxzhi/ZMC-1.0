//
//  ZMCPulic.h
//  ZMC
//
//  Created by 睿途网络 on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCPulic : UIView

/**
 *
 *购物车加号方法实现
 *
 */

+ (void)plusTapped:(UIButton *)button getMinusButton:(UIButton *)mButton getCountLabel:(UILabel *) label;

/**
 *
 *购物车减号方法实现
 *
 */
+ (void)minusTapped:(UIButton *)button getCountLabel:(UILabel *) label;
//- (void)updateNumberLabel:(UILabel *)label;



//两个按钮，中间一个输入框
+ (void)plusTFCountWithTF:(UITextField *)textField andMinusButton:(UIButton *)button;
+ (void)minusTFCountWithTF:(UITextField *)textField andMinusButton:(UIButton *)button;

@end
