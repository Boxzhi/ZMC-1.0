//
//  ZMCPayViewController.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCPayViewController.h"
#import "ZMCPayManger.h"
#import "ZMCPayItem.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "OrderSingleItem.h"
#import "OrderPayTool.h"
#import "WLDecimalKeyboard.h"
#import <AFNetworking/AFNetworking.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@interface ZMCPayViewController ()<UITextFieldDelegate>

// 第一个按钮
@property (weak, nonatomic) IBOutlet UIButton *sanButton;
// 第二个按钮
@property (weak, nonatomic) IBOutlet UIButton *wuButton;
// 第三个按钮
@property (weak, nonatomic) IBOutlet UIButton *disangeButton;
// 其他金额
@property (weak, nonatomic) IBOutlet UIButton *otherButton;

// 支付宝按钮
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoButton;
// 微信按钮
@property (weak, nonatomic) IBOutlet UIButton *weixinButton;
// 喇叭图标
@property (weak, nonatomic) IBOutlet UIImageView *labaImageView;

@property (weak, nonatomic) IBOutlet UIView *btnView;

// 账户余额
@property (weak, nonatomic) IBOutlet UILabel *actbalanceLabel;


// 保存选中的按钮
@property (nonatomic, strong) UIButton *selectedButton;
// 输入金额的Field
@property (weak, nonatomic) IBOutlet UITextField *moneyField;

// 充值金额列表
@property (nonatomic, strong) NSArray *listArray;

// 优惠信息
@property (weak, nonatomic) IBOutlet UILabel *prefLabel;

@end

@implementation ZMCPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self selectedClick:_sanButton];
    
    WLDecimalKeyboard *inputView = [[WLDecimalKeyboard alloc] init];
    
    self.moneyField.delegate = self;
    self.moneyField.inputView = inputView;
    [self.moneyField reloadInputViews];
//    self.moneyField.inputAccessoryView = [self addToolbar];
    // 默认选中支付宝支付
    self.zhifubaoButton.selected = YES;
    self.moneyField.textColor = RGB(41, 180, 61);
    self.moneyField.text = self.selectedButton.titleLabel.text;
    
    self.actbalanceLabel.text = _actbalance;
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    [self loadData];

    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NOTIFICATION_ALIPAY object:nil] subscribeNext:^(NSNotification *notifi) {
        
        NSDictionary *dic = [notifi object];
        
        if (dic) {
            if ([@"9000" isEqualToString:[dic objectForKey:@"resultStatus"]]) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD showSuccessWithStatus:@"充值成功"];
                    [self SVPdismiss];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }else{
                [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", [dic objectForKey:@"memo"]]];
                [self SVPdismiss];
                
            }
        }else{
            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
            [SVProgressHUD showErrorWithStatus:@"充值失败"];
            [self SVPdismiss];
        }
        
    }];
    
    
    [self cheackNetWoking];
    
    
    NSDictionary *addresses = [self getIPAddresses];
    NSString *ip = [self getIPAddress:YES];
    ZMCLog(@"IP地址 addresses---->>%@-----%@----%@", addresses, addresses[@"en0/ipv4"], ip);
    
    [USER_DEFAULT setObject:addresses[@"en1/ipv4"] forKey:@"IP"];
    
    [USER_DEFAULT synchronize];
}


#pragma mark - 检测网络状态
- (void)cheackNetWoking{
    __weak typeof(self) blockSelf = self;

    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        ZMCLog(@"当前网络状态是---->> %@", AFStringFromNetworkReachabilityStatus(status));
        NSDictionary *addresses;
        NSString *IP;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                ZMCLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                ZMCLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                ZMCLog(@"手机网络");
                addresses = [blockSelf getIPAddresses];
                IP = addresses[@"lo0/ipv4"];
                ZMCLog(@"保存的IP地址--->>>%@", IP);
                [USER_DEFAULT setObject:IP forKey:@"IP"];
                [USER_DEFAULT synchronize];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                ZMCLog(@"WIFI网络");
//                IP = [blockSelf getIPAddress:YES];
//                ZMCLog(@"保存的IP地址--->>>%@", IP);
                addresses = [blockSelf getIPAddresses];
                IP = addresses[@"en0/ipv4"];
                [USER_DEFAULT setObject:IP forKey:@"IP"];
                [USER_DEFAULT synchronize];
                break;
            default:
                break;
        }
    }];
    
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - 获取IP地址
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    ZMCLog(@"IP地址 addresses---->>%@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


- (void)SVPdismiss{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

/*
- (void)setMoneyButton{
//    [_sanButton setTitle:[NSString stringWithFormat:@"%@元", _listArray[0][@"money"]] forState:UIControlStateNormal];
//    [_wuButton setTitle:[NSString stringWithFormat:@"%@元", _listArray[1][@"money"]] forState:UIControlStateNormal];
//    [_disangeButton setTitle:[NSString stringWithFormat:@"%@元", _listArray[2][@"money"]] forState:UIControlStateNormal];

}
 */

- (void)setNavigationBar{
    self.navigationItem.title = @"账户充值";
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
//    [self setMoneyButton];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ZMCLog(@"%@",_listArray[0][@"desc"]);
    self.prefLabel.text = _listArray[0][@"desc"];
    self.moneyField.text = [NSString stringWithFormat:@"%@元", _listArray[0][@"money"]];
    [SVProgressHUD dismiss];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
}


- (void)loadData{
    [ZMCPayManger getPayPrepaid:^(NSArray *result) {
        
        _listArray = result;
        if ([result[0][@"money"] isKindOfClass:[NSNull class]]) {
            
            [_sanButton setTitle:@"--元" forState:UIControlStateNormal];
            [_wuButton setTitle:@"--元" forState:UIControlStateNormal];
            [_disangeButton setTitle:@"--元" forState:UIControlStateNormal];
        }else{
            
            [_sanButton setTitle:[NSString stringWithFormat:@"%@元", result[0][@"money"]] forState:UIControlStateNormal];
            [_wuButton setTitle:[NSString stringWithFormat:@"%@元", result[1][@"money"]] forState:UIControlStateNormal];
            [_disangeButton setTitle:[NSString stringWithFormat:@"%@元", result[2][@"money"]] forState:UIControlStateNormal];
        }
    }];
}

#pragma mark - 选中按钮属性
- (void)setSelectedColorWithButton:(UIButton *)sender{
    
    [sender setTitleColor:RGB(41, 180, 61) forState:UIControlStateNormal];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

#pragma mark - 点击充值金额按钮
- (IBAction)selectedClick:(UIButton *)sender {
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    // 设置Field的文本为选中按钮的金额
    if (sender == _otherButton) {
        self.moneyField.text  = NULL;
        self.moneyField.placeholder = @"请输入要充值的金额";
        self.moneyField.enabled = YES;
        self.labaImageView.hidden = YES;
        [self.prefLabel setText:@""];
        [self.moneyField becomeFirstResponder];
    }else{
        self.labaImageView.hidden = NO;
        self.moneyField.text = sender.titleLabel.text;
        [_prefLabel setText:_listArray[self.selectedButton.tag][@"desc"]];
        [self.moneyField resignFirstResponder];
        self.moneyField.enabled = NO;
    }
    [self setSelectedColorWithButton:sender];
}

- (IBAction)zhifubaoClick:(UIButton *)sender {
    self.weixinButton.selected = NO;
    sender.selected = YES;

}

- (IBAction)weixinClick:(UIButton *)sender {
    self.zhifubaoButton.selected = NO;
    sender.selected = YES;

}


// 点击屏幕让键盘收起
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - 确认充值按钮
- (IBAction)confirmPayButton:(id)sender {
    if ([self.moneyField.text isEqualToString:@""] || self.moneyField.text == NULL) {
        [SVProgressHUD showInfoWithStatus:@"请输入您要充值的金额"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        [SVProgressHUD showWithStatus:@"充值中..."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
        
        NSNumber *num = [NSNumber numberWithFloat:[self.moneyField.text floatValue]];
        
        [ZMCPayManger getPayRecharge:num andResult:^(NSDictionary *result) {
            [SVProgressHUD dismiss];
            
            OrderSingleItem *item = [OrderSingleItem new];
            item.payPrice = [NSString stringWithFormat:@"%@", result[@"price"]] ;
            item.orderSn = result[@"recharge_sn"];
            
            [USER_DEFAULT setObject:result[@"recharge_sn"] forKey:@"recharge_sn"];
            [USER_DEFAULT synchronize];
            ZMCLog(@"订单号---->>>%@", result[@"recharge_sn"]);
            if (_zhifubaoButton.isSelected) {  // 支付宝

                [OrderPayTool AlipayMethodWith:item backBlock:^(NSDictionary *resultDic) {
                    if ([@"9000" isEqualToString:[resultDic objectForKey:@"resultStatus"]]) {
                        [SVProgressHUD showSuccessWithStatus:@"充值成功"];
                        
                        [self loadData];
                    }else{
                        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];

                        [SVProgressHUD showErrorWithStatus:@"充值失败"];
                    }
                }];
                
                
                NSString *str = self.moneyField.text;
                str = [str stringByReplacingOccurrencesOfString:@"元" withString:@""];
                ZMCLog(@"支付宝充值金额-->%@<--", str);
            }else{ // 微信
                
                NSString *res = [OrderPayTool jumpToBizPay];
                if (![@"" isEqualToString:res]) {
                    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alter show];
                }

            }
        }];
        
        

    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    ZMCLog(@"%@", [textField.text stringByReplacingCharactersInRange:range withString:string]);
    
    return YES;
}


// 给键盘添加完成按钮
//- (UIToolbar *)addToolbar
//{
//    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
//    toolbar.tintColor = [UIColor blueColor];
//    toolbar.backgroundColor = [UIColor whiteColor];
//    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
//    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
//    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
//    [bar setTintColor:ThemeGreenColor];
//    toolbar.items = @[nextButton, prevButton, space, bar];
//    return toolbar;
//}
//
//- (void)textFieldDone{
//    [_moneyField resignFirstResponder];
//}

@end
