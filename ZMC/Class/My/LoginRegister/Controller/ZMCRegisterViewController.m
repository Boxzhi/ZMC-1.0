//
//  ZMCRegisterViewController.m
//  ZMC
//
//  Created by Will on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCRegisterViewController.h"
#import "ZMCRegisteredView.h"
#import "ZMCRegisteredTwoView.h"
#import "ZMCAFManegeritem.h"
#import "ZMCURL.h"
#import "ZMCAgreementViewController.h"
#import "ZMCNavigationController.h"
#import "LoginSuccessModel.h"

@interface ZMCRegisterViewController ()<UITextFieldDelegate>
{
    NSInteger _count;
    NSInteger _number;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
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

// 返回按钮
@property (weak, nonatomic) IBOutlet UIView *backView;


//// 保存从服务器获取的验证码
//@property (nonatomic, strong) NSString *msgResult;
// 保存调用第二步接口的凭证
@property (nonatomic, strong) NSString *pzResult;
// 保存点击下一步提示的错误信息
@property (nonatomic, strong) NSNumber *err_code;
@property (nonatomic, strong) NSString *errmsg;
@end

static ZMCRegisterViewController *registerVc = nil;
@implementation ZMCRegisterViewController
+ (ZMCRegisterViewController *)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        registerVc = [[ZMCRegisterViewController alloc] init];
    });
    return registerVc;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _count = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self setRegistedView];
    self.numberField.delegate = self;
    self.msgField.delegate = self;
    self.onePasswordField.delegate = self;
    self.twoPasswordField.delegate = self;
    
    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [self.backView addGestureRecognizer:tapges];
    
    ZMCLog(@"%lf", _trailingCon.constant);
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _trailingCon.constant = 0;
    self.titleLabel.text = @"注册";
}

#pragma mark - 创建注册View
- (void)setRegistedView{
    ZMCRegisteredView *registeredOne = [ZMCRegisteredView registeredOne];
    [self.contentView addSubview:registeredOne];
    ZMCRegisteredTwoView *registeredTwo = [ZMCRegisteredTwoView registeredTwo];
    [self.contentView addSubview:registeredTwo];
    
    self.numberField = registeredOne.numberField;
    self.msgBtn = registeredOne.msgBtn;
    self.msgField = registeredOne.msgField;
    
    self.onePasswordField = registeredTwo.onePasswordField;
    self.twoPasswordField = registeredTwo.twoPasswordField;
    
    // 注册页面的"下一步"按钮
    [registeredOne.nextButton addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 注册验证码按钮
    [registeredOne.msgBtn addTarget:self action:@selector(msgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 注册协议按钮
    [registeredOne.agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 完成注册按钮
    [registeredTwo.confirmRegButton addTarget:self action:@selector(conButtonClick) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 获取验证码按钮点击
- (void)msgBtnClick{
    ZMCLog(@"获取验证码");
    
    if ([self.numberField.text isEqualToString:@""] || self.numberField.text == NULL) {
        ALERT_MSG(@"提示", @"手机号不能为空");
        return;
    }
    
    // 发送获取验证码的请求
    [ZMCAFManegeritem setRegistercaptchaNumber:self.numberField.text type:@1 andResult:^(NSDictionary *result) {
//        _msgResult = result[@"result"];
        ZMCLog(@"%@", result[@"err_code"]);
        if ([result[@"err_code"] integerValue] != 0) {
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
        [ZMCAFManegeritem setRegisterNumber:self.numberField.text Msg:self.msgField.text andResult:^(NSDictionary *result) {
            _pzResult = result[@"result"];
            _err_code = result[@"err_code"];
            _errmsg = result[@"err_msg"];
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 判断点击下一步之后是否要跳转到设置密码界面
            if ([_err_code integerValue] == 0) {
                self.titleLabel.text = @"设置密码";
                _trailingCon.constant = _trailingCon.constant == 0 ? - kScreenWidth : 0;
                
                [UIView animateWithDuration:0.25 animations:^{
                    // layoutIfNeeded:重新布局,表示所有的frame重新计算
                    [self.view layoutIfNeeded];
                }];
                
                [self.onePasswordField becomeFirstResponder];
                
            }else{
                
                [SVProgressHUD showErrorWithStatus:_errmsg];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
        });
        
        
    }
    
}

#pragma mark - 确定注册按钮
- (void)conButtonClick{
    ZMCLog(@"点击了确定注册按钮");
    
    if ([self.onePasswordField.text isEqualToString:@""] || self.onePasswordField.text.length == 0 || self.onePasswordField.text.length < 6) {
        ALERT_MSG(@"提示", @"请输入6-15位字符密码");
        return;
    }else if (![self.onePasswordField.text isEqualToString:self.twoPasswordField.text]){
        ALERT_MSG(@"提示", @"两次密码输入不一致，请重新输入");

        return;
    }else{
        
        [SVProgressHUD showWithStatus:@"正在注册..."];
        
        NSString *onepwd = self.onePasswordField.text;
        NSString *twopwd = self.twoPasswordField.text;
        NSString *pzresult = self.pzResult;
        
        NSDictionary *params = @{
                                 @"password" : onepwd,
                                 @"repeat_passwd" : twopwd,
                                 @"token" : pzresult,
                                 };
        
        [HYBNetworking postWithUrl:uURegisterPassword refreshCache:YES params:params success:^(id response) {
            ZMCLog(@"成功");
            ZMCLog(@"%@", response);
            if ([response[@"err_code"] integerValue] == 0) {
                //                [self dismissViewControllerAnimated:YES completion:nil];
                
                [SVProgressHUD showSuccessWithStatus:@"注册成功"];

                
                [USER_DEFAULT setObject:@"1" forKey:ISLOGIN];
                // 保存toke值
                [USER_DEFAULT setObject:response[@"result"][@"access_token"] forKey:@"access_token"];
                [USER_DEFAULT setObject:response[@"result"][@"refresh_token"] forKey:@"refresh_token"];
                [USER_DEFAULT setObject:response[@"result"][@"expire_time"] forKey:@"expire_time"];
                NSString *timeSp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
                [USER_DEFAULT setObject:timeSp forKey:@"login_time"];
                
                [USER_DEFAULT synchronize];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [SVProgressHUD dismiss];
                });

            }else{
                [SVProgressHUD showErrorWithStatus:@"服务器错误，请重新注册"];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
                // 延迟2秒跳转到登录界面
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [SVProgressHUD dismiss];
                });
            }
        } fail:^(NSError *error) {
            ZMCLog(@"失败");
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
    }
}


#pragma mark - 注册协议按钮
- (void)agreementBtnClick{
    
    ZMCAgreementViewController *AgrVc = [[ZMCAgreementViewController alloc] init];
    
    [self presentViewController:AgrVc animated:YES completion:nil];
    
}


//#pragma mark - 封装的提示方法
//- (void)setAlertControllerWithMessage:(NSString *) message{
//    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *txAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//    
//    [alertVc addAction:txAction];
//    
//    [self presentViewController:alertVc animated:YES completion:nil];
//}

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
    
    ZMCRegisteredView *registeredOne = self.contentView.subviews[0];
    registeredOne.frame = CGRectMake(self.contentView.zmc_width * 0.5, 0, self.contentView.zmc_width * 0.5, self.contentView.zmc_height);
    
    ZMCRegisteredTwoView *registeredTwo = self.contentView.subviews[1];
    registeredTwo.frame = CGRectMake(0, 0, self.contentView.zmc_width * 0.5, self.contentView.zmc_height);
   
}

// 左上角返回登录界面按钮
- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD dismiss];
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
