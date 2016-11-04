//
//  ZMCBasketViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "ZMCBasketViewController.h"
#import "ZMCBasketTableViewCell.h"
#import "ZMCCookToHomeViewController.h"
#import "ZMCPulic.h"
#import "ZMCOrderCheckoutViewController.h"
#import "ShopBasketEmptyView.h"

#import "ShoppongCartsModel.h"

#import "UITabBar+badge.h"
#import "ZMCCookBookDetailViewController.h"

@interface ZMCBasketViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    /**
     *  菜篮子数据源
     */
    ShoppongCartsModel *shoppingCarts_model;
    
    UILabel *label;
    
    UIButton *button;
    
    NSString *type;
    
    NSString *item_id;
    
    int is_start;
}

@property (nonatomic, strong) UITableView *shoppingTable;

@property (nonatomic, weak) UILabel *settlement_lab;
@property (nonatomic, weak) UIButton *settlement_btn;

@end

static NSString *cellReuseId = @"cell";
@implementation ZMCBasketViewController

#pragma mark - 视图
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([UserInfo isLogin]) {
        [self getInfo];
    }else {
        shoppingCarts_model = nil;
        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
        [_shoppingTable reloadData];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"菜篮子";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);

    [self.view addSubview:self.shoppingTable];
    [self getBottomView];
    
    [self getShoppingCartsInfo];
    
}

- (void)getInfo {
    
    if (![UserInfo isLogin]) {
        [self endRefresh];
        return ;
    }
    [self getShoppingCartsInfo];
    
}

/**
 *  获取菜篮子数据
 */
- (void)getShoppingCartsInfo {
    
    [CommonHttpAPI getShoppingCartsWithParameters:[CommonRequestModel getShoppongCartsWithPageNO:@"1" page_size:@"30"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        shoppingCarts_model = [ShoppongCartsModel mj_objectWithKeyValues:responseObject];
        
//        if (shoppingCarts_model.result.cooks.count == 0 && shoppingCarts_model.result.merchants.count == 0) {
//            //隐藏
//            [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
//        }else {
//            //显示
//            [self.tabBarController.tabBar showBadgeOnItemIndex:3];
//        }
        
        
        
        if ([responseObject getTheResultForDic]) {

            label.text = [NSString stringWithFormat:@"   合计: ￥%0.2f",shoppingCarts_model.result.total_price];
            
            [_shoppingTable reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
        if (shoppingCarts_model.result.cooks.count == 0) {
            [ChatbadgecountManager share].badgeCount = shoppingCarts_model.result.total;
        }else {
            [ChatbadgecountManager share].badgeCount = shoppingCarts_model.result.total + 1;
        }
        
        if ([ChatbadgecountManager share].badgeCount == 0) {
            [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
        }else {
            [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%ld",(long)[ChatbadgecountManager share].badgeCount]];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

- (UITableView *)shoppingTable
{
    if (!_shoppingTable) {
        _shoppingTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -50 -64 -49) style:UITableViewStyleGrouped];
         _shoppingTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _shoppingTable.delegate = self;
        _shoppingTable.dataSource = self;
        _shoppingTable.backgroundColor = UIColorFromRGB(0xf4f4f4);
        _shoppingTable.tableHeaderView = [self getTableHeaderView];
        [_shoppingTable registerNib:[UINib nibWithNibName:@"ZMCBasketTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    }
    return _shoppingTable;
}

#pragma mark- 设置底部的结算按钮
- (void)getBottomView
{

    label = [[UILabel alloc] init];
    label.backgroundColor = RGB(250.0, 250.0, 250.0);
    label.textColor = StringLightColor;
    _settlement_lab = label;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.bottom.equalTo(_shoppingTable.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 50));
    }];

    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = ThemeGreenColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"结算" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    _settlement_btn = button;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_top);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    [button addTarget:self action:@selector(clickToPay) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark- 点击结算
- (void)clickToPay
{
    Check_Login
    
    ZMCOrderCheckoutViewController *orderVC = [[ZMCOrderCheckoutViewController alloc] init];
    orderVC.hidesBottomBarWhenPushed = YES;
    orderVC.shoppingCarts_model = shoppingCarts_model;
    [self.navigationController pushViewController:orderVC animated:YES];
}

#pragma mark- 设置表头
- (UIView *)getTableHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:headerBtn];
    [headerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth -20, 40));
    }];
    [headerBtn setTitle:@"+ 添加大厨到家服务" forState:UIControlStateNormal];
    [headerBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    headerBtn.layer.cornerRadius = 4;
    headerBtn.layer.masksToBounds = YES;
    headerBtn.layer.borderColor = ThemeGreenColor.CGColor;
    headerBtn.layer.borderWidth = 1;
    
    [headerBtn addTarget:self action:@selector(clickToCookVC) forControlEvents:UIControlEventTouchUpInside];
    return view;
    
}

#pragma mark- 点击跳转到大厨到家页面
- (void)clickToCookVC
{
//    Check_Login
    
    ZMCCookToHomeViewController *cookToHomeVC = [[ZMCCookToHomeViewController alloc] init];
    cookToHomeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cookToHomeVC animated:YES];
}

#pragma mark- tableview的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (shoppingCarts_model.result.cooks.count == 0 && shoppingCarts_model.result.merchants.count == 0) {
        return 1;
    }
    if (shoppingCarts_model.result.cooks.count != 0) {
        return shoppingCarts_model.result.merchants.count + 1;
    }else {
        return shoppingCarts_model.result.merchants.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (shoppingCarts_model.result.cooks.count != 0) {
        if (section == 0) {
            return shoppingCarts_model.result.cooks.count;
        }else {
            return shoppingCarts_model.result.merchants[section-1].goods.count;
        }
    }else if(shoppingCarts_model.result.merchants.count != 0){
        return shoppingCarts_model.result.merchants[section].goods.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ZMCBasketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
//    cell.goodsCountTF.delegate = self;
//    [cell.minusButton addTarget:self action:@selector(minusCount:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.plusButton addTarget:self action:@selector(plusCount:) forControlEvents:UIControlEventTouchUpInside];
    
    static NSString *identifier = @"ZMCBasketTableViewCell";
    
    ZMCBasketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMCBasketTableViewCell" owner:nil options:nil] firstObject];
    }
    
    if (shoppingCarts_model.result.cooks.count != 0) {
        if (indexPath.section == 0) {
            [cell setBaseketCooksInfo:shoppingCarts_model.result.cooks[indexPath.row]];
        }else {
            [cell setBaseketGoodsInfo:shoppingCarts_model.result.merchants[indexPath.section - 1].goods[indexPath.row]];
        }
    }else {
        [cell setBaseketGoodsInfo:shoppingCarts_model.result.merchants[indexPath.section].goods[indexPath.row]];
    }
    
//    [[cell.minusButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    [[[cell.minusButton
           rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:cell.rac_prepareForReuseSignal]
         subscribeNext:^(UIButton *x) {
             
             cell.minusButton.userInteractionEnabled = NO;
             cell.plusButton.userInteractionEnabled = NO;
        if (shoppingCarts_model.result.cooks.count != 0) {
            if (indexPath.section == 0) {
                item_id = ChangeNSIntegerToStr(shoppingCarts_model.result.cooks[indexPath.row].cooks_id);
                type = @"2";
            }else if (shoppingCarts_model.result.merchants.count !=  0){
                item_id = ChangeNSIntegerToStr(shoppingCarts_model.result.merchants[indexPath.section-1].goods[indexPath.row].goods_id);
                type = @"1";
            }
        }else if (shoppingCarts_model.result.merchants.count !=  0){
            item_id = ChangeNSIntegerToStr(shoppingCarts_model.result.merchants[indexPath.section].goods[indexPath.row].goods_id);
            type = @"1";
        }
        
        [CommonHttpAPI postGoodsDecreaseWithParameters:[CommonRequestModel getGoodsDecreaseryWithItem_id:item_id quantity:@"1" type:type] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            
            if ([responseObject getTheResultForDic]) {
                
                [self getShoppingCartsInfo];
//                cell.goodsCountTF.text = ChangeNSIntegerToStr([cell.goodsCountTF.text intValue] - 1);
//                label.text = [NSString stringWithFormat:@"   合计: ￥%0.2f",shoppingCarts_model.result.total_price-shoppingCarts_model.result.merchants[indexPath.section].goods[indexPath.row].price];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
            cell.minusButton.userInteractionEnabled = YES;
            cell.plusButton.userInteractionEnabled = YES;
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
            cell.minusButton.userInteractionEnabled = YES;
            cell.plusButton.userInteractionEnabled = YES;
        }];
    }];
    [[[cell.plusButton
           rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:cell.rac_prepareForReuseSignal]
         subscribeNext:^(UIButton *x) {
             
             cell.minusButton.userInteractionEnabled = NO;
             cell.plusButton.userInteractionEnabled = NO;
        
        if (shoppingCarts_model.result.cooks.count != 0) {
            if (indexPath.section == 0) {
                item_id = ChangeNSIntegerToStr(shoppingCarts_model.result.cooks[indexPath.row].cooks_id);
                type = @"2";
            }else {
                item_id = ChangeNSIntegerToStr(shoppingCarts_model.result.merchants[indexPath.section-1].goods[indexPath.row].goods_id);
                type = @"1";
            }
        }else {
            item_id = ChangeNSIntegerToStr(shoppingCarts_model.result.merchants[indexPath.section].goods[indexPath.row].goods_id);
            type = @"1";
        }
        
        [CommonHttpAPI postGoodsIncreaseWithParameters:[CommonRequestModel getGoodsIncreaseryWithItem_id:item_id  quantity:@"1" start_time:@"" type:type] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            
            if ([responseObject getTheResultForDic]) {
                
                [self getShoppingCartsInfo];
//                cell.goodsCountTF.text = ChangeNSIntegerToStr([cell.goodsCountTF.text intValue] + 1);
//                label.text = [NSString stringWithFormat:@"   合计: ￥%0.2f",[label.text floatValue]+shoppingCarts_model.result.merchants[indexPath.section].goods[indexPath.row].price];
//                NSLog(@"%@",label.text);
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
            cell.minusButton.userInteractionEnabled = YES;
            cell.plusButton.userInteractionEnabled = YES;

            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
            cell.minusButton.userInteractionEnabled = YES;
            cell.plusButton.userInteractionEnabled = YES;
        }];
    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (shoppingCarts_model.result.cooks.count == 0 && shoppingCarts_model.result.merchants.count == 0) {
        
        ShopBasketEmptyView *headV = (ShopBasketEmptyView *)[[[NSBundle mainBundle] loadNibNamed:@"ShopBasketEmptyView" owner:self options:nil] lastObject];
        [[headV.goEmptyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
//            [[[Singer share] customTabbr]setSelectWithIndex:2];
            self.tabBarController.selectedIndex = 2;
            
        }];
        
        label.hidden = YES;
        button.hidden = YES;
        
        return headV;
    }
    
    
    label.hidden = NO;
    button.hidden = NO;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"shop_icon"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(13);
        make.size.mas_equalTo(CGSizeMake(18, 15));
    }];
    
    UILabel *merchantName_label = [[UILabel alloc] init];
    [view addSubview:merchantName_label];
//    label.text = @"琪琪鲜蔬直营店";
    merchantName_label.textColor = StringDarkColor;
    merchantName_label.font = [UIFont systemFontOfSize:15];
    [merchantName_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(48);
        make.top.equalTo(imageView.mas_top);
        make.size.mas_equalTo(CGSizeMake(200, 17));
    }];
    if (shoppingCarts_model.result.cooks.count != 0) {
        
        if (section == 0) {
            imageView.image = [UIImage imageNamed:@"cook_icon"];
            merchantName_label.text = @"大厨到家";
            UIButton *cookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [view addSubview:cookBtn];
            [cookBtn setTitle:@"更多" forState:UIControlStateNormal];
            [cookBtn setTitleColor:StringMiddleColor forState:UIControlStateNormal];
            cookBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [cookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_top);
                make.right.mas_equalTo(-16);
                make.size.mas_equalTo(CGSizeMake(32, 16));
            }];
            [cookBtn addTarget:self action:@selector(clickToCookVC) forControlEvents:UIControlEventTouchUpInside];
        }else {
            merchantName_label.text = shoppingCarts_model.result.merchants[section-1].name;
        }
        
    }else {
        merchantName_label.text = shoppingCarts_model.result.merchants[section].name;
    }

    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (shoppingCarts_model.result.cooks.count == 0 && shoppingCarts_model.result.merchants.count == 0) {
        return 250;
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

//- (void)minusCount:(UIButton *)button
//{
//    ZMCBasketTableViewCell *cell = (ZMCBasketTableViewCell *)button.superview.superview;
//    [ZMCPulic minusTFCountWithTF:cell.goodsCountTF andMinusButton:button];
//}
//- (void)plusCount:(UIButton *)button
//{
//    ZMCBasketTableViewCell *cell = (ZMCBasketTableViewCell *)button.superview.superview;
//    [ZMCPulic plusTFCountWithTF:cell.goodsCountTF andMinusButton:cell.minusButton];
//}

#pragma mark- 商品表中cell里面的输入框的协议方法
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
////    发送请求,获得商品的总价
//    
//}
@end
