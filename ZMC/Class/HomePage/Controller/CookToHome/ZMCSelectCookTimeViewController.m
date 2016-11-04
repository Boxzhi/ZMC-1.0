//
//  SelectCookTimeViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/21.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCSelectCookTimeViewController.h"
#import "CuiPickerView.h"
#import "HomeNetwork.h"
#import "SVProgressHUD.h"
#import "ZMCCookDetailViewController.h"



@interface ZMCSelectCookTimeViewController () <UITextFieldDelegate,CuiPickViewDelegate>
{
    UIButton *_selectButton;
}

@property (nonatomic, strong) CuiPickerView *cuiPickerView;
@property (nonatomic, strong) NSString *dataString;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)sureHaveCooker:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *getTimeTF;
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (nonatomic, strong) NSString *timeString;


@end

@implementation ZMCSelectCookTimeViewController

{
    NSArray *array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.getTimeTF.delegate = self;
    
    _cuiPickerView = [[CuiPickerView alloc]init];
    _cuiPickerView.frame = CGRectMake(0, self.view.frame.size.height + 65, self.view.frame.size.width, 240);
    
    //这一步很重要
    _cuiPickerView.myTextField = _getTimeTF;
    
    _cuiPickerView.delegate = self;
    _cuiPickerView.curDate=[NSDate date];
    [self.view addSubview:_cuiPickerView];
    
    [self getButton];
}

- (void) getButton {
    
    self.button1.tag = 300;
    self.button2.tag = 301;
    self.button3.tag = 302;
    self.button4.tag = 303;
    self.button5.tag = 304;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [_cuiPickerView showInView:self.view];
    
//    self.view.frame = CGRectMake(0, -30, kScreenWidth, kScreenHeight - 30);
}

-(void)didFinishPickView:(NSString *)date
{
//    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.dataString = date;
    _getTimeTF.text = date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(UIButton *)sender {
    

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)selectTime:(UIButton *)sender {
    
    [_selectButton setTitleColor:StringLightColor forState:UIControlStateNormal];
    _selectButton.layer.borderColor = [UIColor clearColor].CGColor;

    [sender setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    sender.layer.cornerRadius = 4;
    sender.layer.masksToBounds = YES;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = ThemeGreenColor.CGColor;
    _selectButton = sender;
    
    if (_selectButton.tag == 300) {
        
        self.timeString = @"1";
        
    }else if (_selectButton.tag == 301) {
        
        self.timeString = @"2";
        
    }else if (_selectButton.tag == 302) {
        
        self.timeString = @"3";
        
    }else if (_selectButton.tag == 303) {
        
        self.timeString = @"5";
        
    }else {
        
        self.timeString = @"24";
    }
    
}

//点击确认雇佣大厨按钮
//发送请求，取消显示view
- (IBAction)confirmButtton:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissVC" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)sureHaveCooker:(id)sender {
    
    if ((self.timeString == nil || [self.getTimeTF.text isEqualToString:@""])) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择上门时间或服务时长"];
        
        [self performSelector:@selector(dismissSVP) withObject:nil afterDelay:1.5];
        
    }else {
        
        NSDictionary *dict = @{
                               @"item_id" : self.cookerId,
                               @"quantity" : self.timeString,
                               @"start_time" : self.getTimeTF.text,
                               @"type" : @2
                               };
        [HomeNetwork sureOfTheCookerToHome:dict andCompleteBlock:^(NSString *cookString) {

            
            if ([cookString isEqualToString:@"OK"]) {
                
                [SVProgressHUD showSuccessWithStatus:@"雇佣成功"];
                
                [self performSelector:@selector(dismissSVPSuess) withObject:nil afterDelay:1.5];
            }else {
                
                [SVProgressHUD showErrorWithStatus:cookString];
                
                [self performSelector:@selector(dismissSVP) withObject:nil afterDelay:1.5];
            }
        }];
    }
}

- (void)dismissSVPSuess {
    
    
    [SVProgressHUD dismiss];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)dismissSVP {
    
    [SVProgressHUD dismiss];

}
@end
