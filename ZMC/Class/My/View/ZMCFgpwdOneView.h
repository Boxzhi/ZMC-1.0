//
//  ZMCRegisteredView.h
//  ZMC
//
//  Created by Will on 16/5/4.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCFgpwdOneView : UIView

// 注册页面的"下一步"按钮
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
// 验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *msgBtn;

// 手机号输入框
@property (weak, nonatomic) IBOutlet UITextField *numberField;
// 验证码输入框
@property (weak, nonatomic) IBOutlet UITextField *msgField;




+ (instancetype)fgpwdOne;


@end
