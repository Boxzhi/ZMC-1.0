//
//  OrderCheckoutViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCOrderCheckoutViewController.h"
#import "ZMCPaySuccedViewController.h"

#import "DeliverTypeModel.h"
#import "OrderMoneyModel.h"
#import "DiscountModel.h"
#import "AddressModel.h"

#import "DistributionTimeVC.h"
#import "ZMCCouponViewController.h"
#import "ZMCAddressViewController.h"
#import "ZMCPayViewController.h"

#import "ZMCOrderCheckOutView.h"

@interface ZMCOrderCheckoutViewController ()<UITextFieldDelegate> {
    
    /**
     *  支付金额的数据源
     */
    OrderMoneyModel *orderMoney_model;
    
    /**
     *  派送方式数据源
     */
    DeliverTypeModel *deliverType_model;
    
    /**
     *  使用的积分
     */
    int usePoints;
    
    ZMCOrderCheckOutView *orderCheckOutView;
    
    DiscountData *discountData; //优惠劵信息
    
    __weak IBOutlet UIScrollView *orderCheckOutScrollView;
}


@property (weak, nonatomic) IBOutlet UILabel *userName_lab;
@property (weak, nonatomic) IBOutlet UILabel *userMobile_lab;
@property (weak, nonatomic) IBOutlet UILabel *userAddress_lab;
@property (weak, nonatomic) IBOutlet UILabel *currentMarket_lab;

@property (weak, nonatomic) IBOutlet UILabel *goodsNumber_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;

@property (weak, nonatomic) IBOutlet UILabel *distributionTime_lab;
@property (weak, nonatomic) IBOutlet UILabel *coupon_lab;
@property (weak, nonatomic) IBOutlet UILabel *points_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsMoney_lab;
@property (weak, nonatomic) IBOutlet UILabel *balance_lab;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney_lab;
@property (weak, nonatomic) IBOutlet UILabel *discountMoney_lab;
@property (weak, nonatomic) IBOutlet UITextField *remark_textField;
@property (weak, nonatomic) IBOutlet UILabel *payMoney_lab;
@property (weak, nonatomic) IBOutlet UILabel *freight_lab;

@property (nonatomic, strong) NSString *address_id; //收货地址id
@property (nonatomic, strong) NSMutableString *cook_info; //厨师信息
@property (nonatomic, strong) NSString *delivery_date; //配送日期
@property (nonatomic, strong) NSString *delivery_section; //配送时间段
@property (nonatomic, strong) NSString *delivery_way_id; //配送方式id
@property (nonatomic, strong) NSMutableString *list; //商品
@property (nonatomic, strong) NSString *remark; //备注

@end

@implementation ZMCOrderCheckoutViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.delivery_way_id) {
        [self getPayMoneyInfo];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订单结算";
    
    orderCheckOutScrollView.contentSize = CGSizeMake(0, 600);
    
    orderCheckOutView = (ZMCOrderCheckOutView *)[[[NSBundle mainBundle] loadNibNamed:@"ZMCOrderCheckOutView" owner:nil options:nil]lastObject];
    [orderCheckOutView.selectAddress_btn addTarget:self action:@selector(clickToSelectAddress:) forControlEvents:UIControlEventTouchUpInside];
    [orderCheckOutView.selectTime_btn addTarget:self action:@selector(clickToSelectTime:) forControlEvents:UIControlEventTouchUpInside];
    [orderCheckOutView.selectCoupon_btn addTarget:self action:@selector(clickToUseTicket:) forControlEvents:UIControlEventTouchUpInside];
    [orderCheckOutView.selectPoint_btn addTarget:self action:@selector(clickToUsePoint:) forControlEvents:UIControlEventTouchUpInside];
    [orderCheckOutView.chongZhi_btn addTarget:self action:@selector(addMoney:) forControlEvents:UIControlEventTouchUpInside];
    
    [orderCheckOutScrollView addSubview:orderCheckOutView];
    [orderCheckOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderCheckOutScrollView);
        make.left.equalTo(orderCheckOutScrollView);
        make.width.mas_equalTo(SCREEN_W);
        make.height.equalTo(@600);
    }];

    orderCheckOutView.remark_textField.inputAccessoryView = [self addToolbar];
    [orderCheckOutView.remark_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingDidBegin];
    orderCheckOutView.remark_textField.delegate = self;
    orderCheckOutView.goodsNumber_lab.text = ChangeNSIntegerToStr(self.shoppingCarts_model.result.total);
    orderCheckOutView.goodsPrice_lab.text = [NSString stringWithFormat:@"%.2f",self.shoppingCarts_model.result.total_price];
    self.cook_info = [[NSMutableString alloc] init];
    if (self.shoppingCarts_model.result.cooks.count != 0) {
            self.cook_info = [NSMutableString stringWithFormat:@"%ld,%@,%ld",(long)self.shoppingCarts_model.result.cooks[0].cooks_id,self.shoppingCarts_model.result.cooks[0].start_time,(long)self.shoppingCarts_model.result.cooks[0].quantity];
    }
    self.list = [[NSMutableString alloc] init];
    [self.shoppingCarts_model.result.merchants enumerateObjectsUsingBlock:^(ShoppongCartsMerchants *merchants_obj, NSUInteger idx, BOOL *stop) {
        [merchants_obj.goods enumerateObjectsUsingBlock:^(ShoppongCartsGooods *goods_obj, NSUInteger idx, BOOL *stop) {
            [self.list appendFormat:@"%ld,%ld,%ld;",(long)merchants_obj.merchants_id,(long)goods_obj.goods_id,(long)goods_obj.quantity];
        }];
        
         
    }];

    orderCheckOutView.currentMarket_lab.text = Market_name;
    
    [self getAddressDefault];
    
    [self getOrderDeliveryInfo];
}

/**
 *  获取默认地址
 */
- (void)getAddressDefault {
    
    [CommonHttpAPI getAddressDefaultWithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        ZMCLog(@"%@",responseObject);
        
        if ([responseObject getTheResultForDic]) {
//            @property (weak, nonatomic) IBOutlet UILabel *userName_lab;
//            @property (weak, nonatomic) IBOutlet UILabel *userMobile_lab;
//            @property (weak, nonatomic) IBOutlet UILabel *userAddress_lab;
//            @property (weak, nonatomic) IBOutlet UILabel *currentMarket_lab;
            AddressModel *address_model = [AddressModel mj_objectWithKeyValues:responseObject];
            if (!address_model.result) {
                orderCheckOutView.userName_lab.text = @"";
                orderCheckOutView.userMobile_lab.text = @"";
                orderCheckOutView.userAddress_lab.text = @"请手动选择收货地址";
            }else {
                self.address_id = ChangeNSIntegerToStr(address_model.result.address_id);
                orderCheckOutView.userName_lab.text = address_model.result.consignee;
                orderCheckOutView.userMobile_lab.text = address_model.result.mobile;
                orderCheckOutView.userAddress_lab.text = [NSString stringWithFormat:@"%@%@%@%@",address_model.result.province_name,address_model.result.city_name,address_model.result.district_name,address_model.result.street_address];
                orderCheckOutView.currentMarket_lab.text = Market_name;
            }
            
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

/**
 *  获取派送方式
 */
- (void)getOrderDeliveryInfo {
    [CommonHttpAPI getOrderDeliveryInfoWithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        
        if ([responseObject getTheResultForDic]) {
            
            deliverType_model = [DeliverTypeModel mj_objectWithKeyValues:responseObject];
            if (deliverType_model.result.data.count != 0) {
//                self.stationWay = deliverType_model.result.list[0].name;
                self.delivery_way_id =[NSString stringWithFormat:@"%ld",(long)deliverType_model.result.data[0].data_id];
            }
            
            [self getPayMoneyInfo];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

/**
 *  获取支付金额
 */
- (void)getPayMoneyInfo {
    
    NSString *cookInfo;
    if (self.shoppingCarts_model.result.cooks.count != 0) {
        cookInfo = [NSString stringWithFormat:@"%ld,%ld",(long)self.shoppingCarts_model.result.cooks[0].cooks_id,(long)self.shoppingCarts_model.result.cooks[0].quantity];
    }
    
    [CommonHttpAPI getPayMoneyWithParameters:[CommonRequestModel getPayMoneyWithCook_info:CHECK_VALUE( cookInfo) coupon_id:ChangeNSIntegerToStr(discountData.coupon_id) delivery_way_id:self.delivery_way_id goods_list:self.list use_points:ChangeNSIntegerToStr(usePoints) market_id:Market_id] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        
        if ([responseObject getTheResultForDic]) {
            
            orderMoney_model = [OrderMoneyModel mj_objectWithKeyValues:responseObject];
            orderCheckOutView.goodsMoney_lab.text = [NSString stringWithFormat:@"¥%.2f",orderMoney_model.result.ordinary_money];
            orderCheckOutView.balance_lab.text = [NSString stringWithFormat:@"¥%.2f",orderMoney_model.result.balance];
            orderCheckOutView.totalMoney_lab.text = [NSString stringWithFormat:@"%.2f",self.shoppingCarts_model.result.total_price];            orderCheckOutView.discountMoney_lab.text = [NSString stringWithFormat:@"- ¥%.2f",orderMoney_model.result.discount_money];
            self.payMoney_lab.text = [NSString stringWithFormat:@"¥%.2f",orderMoney_model.result.total_money];
            orderCheckOutView.points_lab.text = [NSString stringWithFormat:@"可用%d点积分抵扣%.2f元",orderMoney_model.result.available_points,orderMoney_model.result.available_points * orderMoney_model.result.ratio];
            orderCheckOutView.freight_lab.text = [NSString stringWithFormat:@"+ ¥%.2f",orderMoney_model.result.freight];
            orderCheckOutView.freight_limit_lab.text = [NSString stringWithFormat:@"订单满%d免3元运费",orderMoney_model.result.no_freight_limit];
//            self.goodsPrice_lab.text = [NSString stringWithFormat:@"¥%.2f",orderMoney_model.result.goods_money];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
    
    
}

/**
 *  提交订单
 */
- (void)saveOrderInfo {
    
//    Market_id
    
    [CommonHttpAPI postSaveOrderInfoWithParameters:[CommonRequestModel getOrderSaveWithAddress_id:self.address_id cook_info:self.cook_info coupon_id:ChangeNSIntegerToStr(discountData.coupon_id) delivery_date:self.delivery_date delivery_section:self.delivery_section delivery_way_id:self.delivery_way_id goods_list:CHECK_VALUE(self.list) market_id:Market_id remark:self.remark use_points:ChangeNSIntegerToStr(usePoints)] success:^(NSURLSessionDataTask *task, id responseObject) {
       
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            [SVProgressHUD dismiss];
            NSDictionary *dic = responseObject;
            
            [SVProgressHUD showSuccessWithStatus:@"下单成功"];
            
            ZMCPaySuccedViewController *payVC = [[ZMCPaySuccedViewController alloc] init];
            payVC.money = [NSString stringWithFormat:@"%.2f",orderMoney_model.result.total_money];
            payVC.frozen = [NSString stringWithFormat:@"%.2f",orderMoney_model.result.total_money];
            payVC.order_id = dic[@"result"][@"order_id"];
            [self.navigationController pushViewController:payVC animated:YES];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

//点击，选择收货地址
- (void)clickToSelectAddress:(UIButton *)sender {

    ZMCAddressViewController *vc = [[ZMCAddressViewController alloc]init];
    vc.is_order = 9999;
    __weak __typeof(self) weakSelf = self;
    vc.getAddress = ^(NSString *userName,NSString *userMobile,NSString *userAddress,NSString *addressId){
        weakSelf.address_id = addressId;
        orderCheckOutView.userName_lab.text = userName;
        orderCheckOutView.userMobile_lab.text = userMobile;
        orderCheckOutView.userAddress_lab.text = userAddress;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//点击，选择配送时间
- (void)clickToSelectTime:(UIButton *)sender {
    
    DistributionTimeVC *vc = [[DistributionTimeVC alloc]initWithNibName:@"DistributionTimeVC" bundle:nil];
   __weak __typeof(self) weakSelf = self; 
    vc.getTime = ^(NSString *date,NSString *time) {
        weakSelf.delivery_date = date;
        weakSelf.delivery_section = time;
        orderCheckOutView.distributionTime_lab.text = [NSString stringWithFormat:@"%@ %@",date,time];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

//点击，使用优惠券
- (void)clickToUseTicket:(UIButton *)sender {
    
    ZMCCouponViewController* viewController = [[ZMCCouponViewController alloc] init];
    __weak __typeof(self) weakSelf = self;
    viewController.didSelect = ^(DiscountData *data) {
        
        discountData = data;
        [weakSelf getPayMoneyInfo];
        orderCheckOutView.coupon_lab.text = [NSString stringWithFormat:@"-%.f",data.denomination];
//        [_tableView reloadData];
        
    };
    viewController.delivery_way_id = self.delivery_way_id;
    viewController.list = self.list;
    viewController.isPerson = 9999;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

//点击，使用积分
- (void)clickToUsePoint:(UIButton *)sender {
    static BOOL isSelected;
    isSelected = !isSelected;
    [sender setBackgroundImage:isSelected == YES?[UIImage imageNamed:@"choose_pre"] :[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
    usePoints = isSelected == YES?orderMoney_model.result.available_points:0;
    [self getPayMoneyInfo];
}

//点击，充值
- (void)addMoney:(UIButton *)sender {
    
    ZMCPayViewController *vc = [[ZMCPayViewController alloc] initWithNibName:@"ZMCPayViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//点击，确认购买
- (IBAction)clickToBuy:(UIButton *)sender {
    
//    [SVProgressHUD showWithStatus:@"下单中..." ];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.remark = orderCheckOutView.remark_textField.text;
    
    if (self.address_id != nil) {
        if (self.delivery_way_id != nil && self.delivery_date!= nil && self.delivery_section !=nil) {
            if (orderMoney_model.result.total_money <= orderMoney_model.result.balance) {
                
                [SVProgressHUD showWithStatus:@"下单中..." ];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                [self saveOrderInfo];
            }else {
                [OMGToast showWithText:@"余额不足，请先充值!"];
            }
            
        }else {
            [OMGToast showWithText:@"请选择配送时间！"];
        }
    }else {
        [OMGToast showWithText:@"请选择收货地址！"];
    }
    
}





//    ZMCPaySuccedViewController *payVC = [[ZMCPaySuccedViewController alloc] init];
//    [self.navigationController pushViewController:payVC animated:YES];

- (void) textFieldDidChange:(id) sender {
    self.view.frame = CGRectMake(0, -40, self.view.frame.size.width, self.view.frame.size.height);
}
//给键盘添加完成按钮
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    [bar setTintColor:[UIColor blackColor]];
    toolbar.items = @[nextButton, prevButton, space, bar];
    return toolbar;
}

- (void)textFieldDone{
    [orderCheckOutView.remark_textField resignFirstResponder];
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}
//#pragma mark- 键盘下落
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
@end
