//
//  ZMCRegisterViewController.m
//  ZMC
//
//  Created by Will on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCFgpwdViewController.h"
#import "ZMCFgpwdOneView.h"
#import "ZMCFgpwdTwoView.h"
#import "ZMCAFManegeritem.h"
#import "ZMCURL.h"


@interface ZMCFgpwdViewController ()<UITextFieldDelegate>
{
    NSInteger _count;
    NSInteger _number;
}


// 显示内容的View
@property (weak, nonatomic) IBOutlet UIView *contentView;
// 约束线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingCon;
// 保存手机号的输入框
@property (nonatomic, weak) UITextField *numberField;
// 保存验证码输入框
@property (nonatomic, weak) UITextField *msgField;
// 验证码按钮
@property (nonatomic, weak) UIButton *msgBtn;

// 设置密码
@property (nonatomic, weak) UITextField *onePasswordField;
// 再次设置密码
@property (nonatomic, weak) UITextField *twoPasswordField;

//// 保存从服务器获取的验证码
//@property (nonatomic, strong) NSString *msgResult;
// 保存调用第二步接口的凭证
@property (nonatomic, strong) NSString *pzResult;
// 保存点击下一步提示的错误信息
@property (nonatomic, strong) NSString *errmsg;
@end

@implementation ZMCFgpwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRegistedView];
    self.numberField.delegate = self;
    self.msgField.delegate = self;
    self.onePasswordField.delegate = self;
    self.twoPasswordField.delegate = self;
    
}

#pragma mark - 创建注册View
- (void)setRegistedView{
    ZMCFgpwdOneView *fgpwdOne = [ZMCFgpwdOneView fgpwdOne];
    [self.contentView addSubview:fgpwdOne];
    ZMCFgpwdTwoView *fgpwdTwo = [ZMCFgpwdTwoView fgpwdTwo];
    [self.contentView addSubview:fgpwdTwo];
    
    self.numberField = fgpwdOne.numberField;
    self.msgBtn = fgpwdOne.msgBtn;
    self.msgField = fgpwdOne.msgField;
    
    self.onePasswordField = fgpwdTwo.onePasswordField;
    self.twoPasswordField = fgpwdTwo.twoPasswordField;
    
    // 注册页面的"下一步"按钮
    [fgpwdOne.nextButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 注册验证码按钮
    [fgpwdOne.msgBtn addTarget:self action:@selector(msgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 完成注册按钮
    [fgpwdTwo.confirmRegButton addTarget:self action:@selector(conButtonClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 获取验证码按钮点击
- (void)msgBtnClick{
    ZMCLog(@"获取验证码");
    
    if ([self.numberField.text isEqualToString:@""] || self.numberField.text == NULL) {
       
        ALERT_MSG(@"提示", @"手机号不能为空");
        return;
    }
    // 发送获取验证码的请求
    [ZMCAFManegeritem setRegistercaptchaNumber:self.numberField.text type:@2 andResult:^(NSDictionary *result) {
//        _msgResult = result[@"result"];
        
        if (![result[@"err_msg"] isEqualToString:@"OK"]) {
            [SVProgressHUD showErrorWithStatus:result[@"err_msg"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }else{
            [self.msgField becomeFirstResponder];
            [self performSelector:@selector(BtnAction) withObject:nil];
        }
        
    }];
    [SVProgressHUD dismiss];
}


#pragma mark - 下一步按钮点击
- (void)nextBtnClick{
    if ([self.msgField.text isEqualToString:@""] || self.msgField.text == 0) {

        ALERT_MSG(@"提示", @"验证码不能为空");
        return;
    }else {
        
        // 把手机号及验证码发送到服务器
        // 获取调用第二步接口的凭证
        [ZMCAFManegeritem postFgpwdNumber:self.numberField.text Msg:self.msgField.text andResult:^(NSDictionary *result) {
            _pzResult = result[@"result"];
            _errmsg = result[@"err_msg"];
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 判断点击下一步之后是否要跳转到设置密码界面
            if ([_errmsg isEqualToString:@"OK"]) {

                _trailingCon.constant = _trailingCon.constant == 0 ? -kScreenWidth : 0;
                
                [UIView animateWithDuration:0.25 animations:^{
                    // layoutIfNeeded:重新布局,表示所有的frame重新计算
                    [self.view layoutIfNeeded];
                }];
                
                [self.onePasswordField becomeFirstResponder];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:_errmsg];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
        });
    }
    
}

#pragma mark - 确定按钮
- (void)conButtonClick{
    ZMCLog(@"点击了确定按钮");

    if ([self.onePasswordField.text isEqualToString:@""] || self.onePasswordField.text.length == 0) {

        ALERT_MSG(@"提示", @"请设置密码");
        return;
    }else if (![self.onePasswordField.text isEqualToString:self.twoPasswordField.text]){
    
        ALERT_MSG(@"提示", @"两次密码输入不一致，请重新输入");
        return;
    }else{
        
        
        NSString *onepwd = self.onePasswordField.text;
        NSString *twopwd = self.twoPasswordField.text;
        NSString *pzresult = self.pzResult;
        
        NSDictionary *params = @{
                                 @"password" : onepwd,
                                 @"repeat_passwd" : twopwd,
                                 @"token" : pzresult,
                                 };
        
        [HYBNetworking postWithUrl:@"http://115.159.227.219:8088/fanfou-api/member/reset/password/step2" refreshCache:YES params:params success:^(id response) {
            ZMCLog(@"成功");
            ZMCLog(@"%@", response);
            [SVProgressHUD showSuccessWithStatus:@"重置密码成功"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
            // 延迟2秒跳转到登录界面
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
                [SVProgressHUD dismiss];
            });
            
            
        } fail:^(NSError *error) {
            ZMCLog(@"失败");
            [SVProgressHUD showErrorWithStatus:@"重置密码失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
    }
}


#pragma mark - 验证码的倒计时
- (void)BtnAction{
    self.msgBtn.enabled = NO;
    _count = 60;
    _number = 0;
    [self.msgBtn setTitle:@"60秒" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)timerFired:(NSTimer *)_timer{
    if (_count != 0 && _number == 0) {
        _count -= 1;
        NSString *str = [NSString stringWithFormat:@"%ld秒", (long)_count];
        [self.msgBtn setTitle:str forState:UIControlStateDisabled];
    }else{
        [_timer invalidate];
        self.msgBtn.enabled = YES;
        [self.msgBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    ZMCFgpwdOneView *fgpwdOne = self.contentView.subviews[0];
    fgpwdOne.frame = CGRectMake(self.contentView.zmc_width * 0.5, 0, self.contentView.zmc_width * 0.5, self.contentView.zmc_height);
    
    ZMCFgpwdTwoView *fgpwdTwo = self.contentView.subviews[1];
    fgpwdTwo.frame = CGRectMake(0, 0, self.contentView.zmc_width * 0.5, self.contentView.zmc_height);
    
   
}

// 左上角返回登录界面按钮
- (IBAction)loginBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.onePasswordField) {
        [self.twoPasswordField becomeFirstResponder];
    }else if (textField == self.twoPasswordField){
        [self conButtonClick];
    }
    return YES;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
