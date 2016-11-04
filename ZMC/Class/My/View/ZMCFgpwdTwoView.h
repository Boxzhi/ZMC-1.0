//
//  ZMCRegisteredTwoView.h
//  ZMC
//
//  Created by Will on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCFgpwdTwoView : UIView
// 确定按钮
@property (weak, nonatomic) IBOutlet UIButton *confirmRegButton;
// 第一个密码输入框
@property (weak, nonatomic) IBOutlet UITextField *onePasswordField;

// 第二个密码输入框
@property (weak, nonatomic) IBOutlet UITextField *twoPasswordField;

+ (instancetype)fgpwdTwo;

@end
