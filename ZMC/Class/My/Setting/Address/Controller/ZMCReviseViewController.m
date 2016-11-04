//
//  ZMCReviseViewController.m
//  ZMC
//
//  Created by Will on 16/5/11.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCReviseViewController.h"
#import "Address.h"
#import "ZMCAddressViewController.h"
#import "AppDelegate.h"
#import "HZZCityPickerView.h"
#import "ZMCPickerViewItem.h"
#import "ZMCAddressManger.h"

@interface ZMCReviseViewController ()<HZZCityPickerViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *shengField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;

//// 默认地址按钮
@property (weak, nonatomic) IBOutlet UIButton *ClickButton;

//@property (nonatomic, strong) NSManagedObjectContext *myContext;

// 省市区选择器
@property (nonatomic, strong) HZZCityPickerView *cityPicker;

// 保存省市区的ID
@property (nonatomic, strong) NSNumber *province_id;
@property (nonatomic, strong) NSNumber *city_id;
@property (nonatomic, strong) NSNumber *district_id;
// 收货编号
@property (nonatomic, strong) NSNumber *id_;

@end

@implementation ZMCReviseViewController


-(HZZCityPickerView *)cityPicker{
    if (!_cityPicker) {
        _cityPicker = [[HZZCityPickerView alloc] init];
        _cityPicker.cityPickerDelegate = self;
        _cityPicker.backgroundColor = RGB(244, 244, 244);
    }
    return _cityPicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.nameField.delegate = self;
    self.numberField.delegate = self;
    
    [self setNavigationBar];
    
    [self setData];
    
    self.shengField.inputView = self.cityPicker;
    
    [self.ClickButton addTarget:self action:@selector(selected) forControlEvents:UIControlEventTouchUpInside];
}


- (void)selected{
    _ClickButton.selected = !_ClickButton.selected;
}

- (void)setData{
    
//    Address *address = self.allData[_cellRow];
//    
//    self.nameField.text = address.name;
//    self.numberField.text = address.number;
//    self.shengField.text = address.provinces;
//    self.addressField.text = address.address;
    
    ZMCPickerViewItem *item = _allData[_cellRow];
    self.nameField.text = item.consignee;
    self.numberField.text = item.mobile;
    self.shengField.text = [NSString stringWithFormat:@"%@ %@ %@", item.province_name, item.city_name, item.district_name];
    self.addressField.text = item.street_address;
    
    
    self.province_id = item.province_id;
    self.city_id = item.city_id;
    self.district_id = item.district_id;
    _id_ = item.id_;
}

- (void)setNavigationBar{
    
    self.title = @"修改收货地址";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(confirm) title:@"确认"];
}


#pragma mark - 修改数据库中的收货地址

- (void)confirm{
    /*
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * context = delegate.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    if (array != nil) {
        
        // 修改对应的数据
        Address *add = array[_cellRow];
        add.name = self.nameField.text;
        add.number = self. numberField.text;
        add.provinces = self.shengField.text;
        add.address = self.addressField.text;
        // 更新数据源
        [self.allData removeAllObjects];
        [self.allData addObjectsFromArray:array];
        // 修改本地持久化
        [self.myContext save:nil];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
     */
    if (self.nameField.text.length < 2) {
        [OMGToast showWithText:@"收货人姓名至少2个字符"];
    }else{
        if (self.numberField.text.length == 0) {
            [OMGToast showWithText:@"请填写联系电话"];
        }else{
            if (self.shengField.text.length == 0) {
                [OMGToast showWithText:@"请选择所在地区"];
            }else{
                if (self.addressField.text.length == 0) {
                    [OMGToast showWithText:@"请填写详细地址"];
                }else{
                    if ([self.shengField.text rangeOfString:@"--"].location != NSNotFound) {
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
                        
                        [ZMCAddressManger addaddressConsignee:self.nameField.text mobile:self.numberField.text province_id:_province_id city_id:_city_id district_id:_district_id street_address:self.addressField.text is_default:is_default SerialId:(NSNumber *)_id_ result:^(NSDictionary *result) {
                            
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

}



#pragma mark - PSCityPickerViewDelegate
- (void)cityPickerView:(HZZCityPickerView *)picker finishPickProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
 
    if ([city isEqualToString:@"暂未开通"]) {
        city = @"--";
    }
    if ([district isEqualToString:@"暂未开通"]){
        district = @"--";
    }
    
    [self.shengField setText:[NSString stringWithFormat:@"%@-%@-%@", province, city, district]];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _nameField) {
        [_numberField becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (void)cityPickerViewID:(HZZCityPickerView *)picker finishPickProvinceId:(NSNumber *)provinceId cityId:(NSNumber *)cityId districtId:(NSNumber *)districtId{
    self.province_id = provinceId;
    self.city_id = cityId;
    self.district_id = districtId;
}

@end
