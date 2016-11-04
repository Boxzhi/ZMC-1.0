//
//  ZMCLoginViewController.m
//  ZMC
//
//  Created by Will on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCLoginViewController.h"
#import "ZMCRegisterViewController.h"
#import "ZMCAFManegeritem.h"
#import "ZMCFgpwdViewController.h"
#import "ZMCMyTableViewController.h"
#import "ZMCTokenResultItem.h"

@interface ZMCLoginViewController ()<UITextFieldDelegate>

// 账号
@property (weak, nonatomic) IBOutlet UITextField *telephoneField;
// 密码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
// 登录
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
// 叉叉关闭
@property (weak, nonatomic) IBOutlet UIView *cancelView;


// 接口调用凭证
@property (nonatomic, strong) NSString *access_token;
// 刷新凭证
@property (nonatomic, strong) NSString *refresh_token;
// 过期时间（单位：秒）
@property (nonatomic, assign) NSNumber *expire_time;

@end

static ZMCLoginViewController *loginVc = nil;
@implementation ZMCLoginViewController

+ (ZMCLoginViewController *)shared{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginVc = [[ZMCLoginViewController alloc] init];
    });
    return loginVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    [self.loginButton addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancel)];
    [self.cancelView addGestureRecognizer:tapGes];
    
    self.passwordField.delegate = self;

}

#pragma mark - 登录按钮点击
- (void)Login{
    [self.passwordField resignFirstResponder];
    if ([self.telephoneField.text isEqualToString:@""] || self.telephoneField.text == NULL) {
        
        ALERT_MSG(@"提示", @"请输入账号");
        return;
    }else if ([self.passwordField.text isEqualToString:@""] || self.passwordField.text == NULL){

        ALERT_MSG(@"提示", @"请输入密码");
        return;
    }else{
        [SVProgressHUD showWithStatus:@"正在登录"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        [ZMCAFManegeritem setLoginTelephonenumber:self.telephoneField.text password:self.passwordField.text andToken:^(NSDictionary *tokenDic) {
            // 判断是否登录成功跳转
            if ([tokenDic[@"err_code"] integerValue] == 0) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
//                LoginSuccessModel *model = [LoginSuccessModel mj_objectWithKeyValues:tokenDic];
//                [TotalAccessTokenTool shared].tokenModel = model.result;

                
                
                [USER_DEFAULT setObject:@"1" forKey:ISLOGIN];
                // 保存toke值
                [USER_DEFAULT setObject:tokenDic[@"result"][@"access_token"] forKey:@"access_token"];
                [USER_DEFAULT setObject:tokenDic[@"result"][@"refresh_token"] forKey:@"refresh_token"];
                [USER_DEFAULT setObject:tokenDic[@"result"][@"expire_time"] forKey:@"expire_time"];
                NSString *timeSp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
                [USER_DEFAULT setObject:timeSp forKey:@"login_time"];
                
                [USER_DEFAULT synchronize];
                
                [SVProgressHUD dismiss];
            }else{
                [SVProgressHUD showErrorWithStatus:tokenDic[@"err_msg"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            
         }];
        
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 取消/注册按钮点击
- (void)clickCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD dismiss];
}


#pragma mark - 跳转到注册界面
- (IBAction)registBtn:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[ZMCMyTableViewController shared] presentRegisterVCAction];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.passwordField) {
        [self Login];
    }
    return YES;
}

#pragma mark - 忘记密码
- (IBAction)Forgotpassword:(id)sender {
    ZMCFgpwdViewController *fgpwdVc = [[ZMCFgpwdViewController alloc] init];
    [self presentViewController:fgpwdVc animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
