//
//  ZMCAddreceiptViewController.m
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAddreceiptViewController.h"
#import "Address+CoreDataProperties.h"
#import "AppDelegate.h"
#import "ZMCAddressViewController.h"
#import "HZZCityPickerView.h"
#import "ZMCAddressManger.h"

@interface ZMCAddreceiptViewController ()<UITextFieldDelegate, HZZCityPickerViewDelegate>

@property (nonatomic, strong) AppDelegate *App;

@property (nonatomic, strong) NSManagedObjectContext *myContext;

// 姓名
@property (weak, nonatomic) IBOutlet UITextField *nameField;
// 手机号
@property (weak, nonatomic) IBOutlet UITextField *numberField;
// 省市区
@property (weak, nonatomic) IBOutlet UITextField *provincesField;
// 地址
@property (weak, nonatomic) IBOutlet UITextField *addressField;

// 保存数据库数据的数组
//@property (nonatomic, strong) NSMutableArray *allData;

// 默认地址按钮
@property (weak, nonatomic) IBOutlet UIButton *ClickButton;

// 省市区选择器
@property (nonatomic, strong) HZZCityPickerView *cityPicker;

// 保存省市区的ID
@property (nonatomic, strong) NSNumber *province_id;
@property (nonatomic, strong) NSNumber *city_id;
@property (nonatomic, strong) NSNumber *district_id;


@end

@implementation ZMCAddreceiptViewController


-(HZZCityPickerView *)cityPicker{
    if (!_cityPicker) {
        _cityPicker = [[HZZCityPickerView alloc] init];
        _cityPicker.cityPickerDelegate = self;
        _cityPicker.backgroundColor = RGB(244, 244, 244);
    }
    return _cityPicker;
}


#pragma mark - 添加收货地址界面

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.nameField.delegate = self;
    self.numberField.delegate = self;
    self.provincesField.delegate = self;
    self.addressField.delegate = self;

//    ZMCAddressViewController *addressVC = [[ZMCAddressViewController alloc] init];
//    _allData = addressVC.allData;
    [self setNavigationBar];

    self.provincesField.inputView = self.cityPicker;
    
    [self.ClickButton addTarget:self action:@selector(selected) forControlEvents:UIControlEventTouchUpInside];
}


- (void)selected{
    _ClickButton.selected = !_ClickButton.selected;
}


- (void)setNavigationBar{
    self.title = @"添加收货地址";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(confirm) title:@"确认"];
}


#pragma mark - 添加数据库中的收货地址
#pragma mark - 保存收货地址
- (void)confirm{
    if (self.nameField.text.length < 2) {
        [OMGToast showWithText:@"收货人姓名至少2个字符"];
    }else{
        if (self.numberField.text.length == 0) {
            [OMGToast showWithText:@"请填写联系电话"];
        }else{
            if (self.provincesField.text.length == 0) {
                [OMGToast showWithText:@"请选择所在地区"];
            }else{
                if (self.addressField.text.length == 0) {
                    [OMGToast showWithText:@"请填写详细地址"];
                }else{
                    if ([self.provincesField.text rangeOfString:@"--"].location != NSNotFound) {
                        [OMGToast showWithText:@"请选择已开通的省市区"];
                    }else{
                        
                        [SVProgressHUD showWithStatus:@"正在保存..."];
                        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];

                        // 发送保存地址的请求
                        
                        NSString *is_default;
                        if (_ClickButton.isSelected) {
                            is_default = @"true";
                        }else{
                            is_default = @"false";
                        }
                        
                        // 发送保存请求
                        [ZMCAddressManger addaddressConsignee:self.nameField.text mobile:self.numberField.text province_id:_province_id city_id:_city_id district_id:_district_id street_address:self.addressField.text is_default:is_default result:^(NSDictionary *result) {
                            
                            ZMCLog(@"添加收货地址--->>%@", result[@"err_msg"]);
                            if ([result[@"err_msg"] isEqualToString:@"OK"]) {
                                [self.navigationController popViewControllerAnimated:YES];
                                [SVProgressHUD dismiss];
                            }else{
                                [SVProgressHUD showErrorWithStatus:result[@"err_msg"]];
                            }
                        }];
                    }
                }
            }
        }
    }
    /*
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    Address *add = [NSEntityDescription insertNewObjectForEntityForName:@"Address" inManagedObjectContext:context];

    add.name = self.nameField.text;
    add.number = self.numberField.text;
    add.provinces = self.provincesField.text;
    add.address = self.addressField.text;
    
    [_allData insertObject:add atIndex:0];

    ZMCLog(@"保存");
    [delegate saveContext];
    
    [self.navigationController popViewControllerAnimated:YES];
     */
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _nameField) {
        [_numberField becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}



// 手机号删除按钮
/*
- (IBAction)valueChange:(UITextField *)sender {
    if (sender.text.length > 0) {
        sender.text = [sender.text substringToIndex:sender.text.length - 1];
    }
    
}
 */

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(HZZCityPickerView *)picker finishPickProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    
    if ([city isEqualToString:@"暂未开通"]) {
        city = @"--";
    }
    if ([district isEqualToString:@"暂未开通"]){
        district = @"--";
    }
    
    [self.provincesField setText:[NSString stringWithFormat:@"%@-%@-%@", province, city, district]];
    
    
}


- (void)cityPickerViewID:(HZZCityPickerView *)picker finishPickProvinceId:(NSNumber *)provinceId cityId:(NSNumber *)cityId districtId:(NSNumber *)districtId{
    self.province_id = provinceId;
    self.city_id = cityId;
    self.district_id = districtId;
}
                    
@end
