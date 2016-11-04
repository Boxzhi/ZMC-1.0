
//
//  ZMCEvaluationViewController.m
//  ZMC
//
//  Created by Will on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCEvaluationViewController.h"
#import "ZMCMyOrderTableViewCell.h"

#import "OrderListModel.h"

#import "OrderDetailVC.h"

@interface ZMCEvaluationViewController ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate,UIAlertViewDelegate> {
    
    /**
     *  订单列表的数据源
     */
    OrderListModel *orderList_model;
    
    NSInteger select_section;
}


@property (nonatomic, strong) UITableView *orderTableView;
@end

static NSString *cellReuseId = @"cell";
@implementation ZMCEvaluationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getOrderListInfo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.orderTableView];
    
    self.refreshTableView = _orderTableView;
    self.currentPage = 1;
    
    __weak typeof(self) blockSelf = self;
    [self setAnimationMJrefreshHeader:^{
        [blockSelf loadNewData];
    }];
    
    [self setMJrefreshFooter:^{
        [blockSelf loadMoreData];
    }];
    
    
//    [self getOrderListInfo];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    self.currentPage = 1;
    [self getOrderListInfo];
    
}

- (void)loadMoreData{
    
    self.currentPage = self.currentPage + 1;
    [self getOrderListInfo];
    
}

- (void)getOrderListInfo {
    
    [CommonHttpAPI getOrderListWithParameters:[CommonRequestModel getOrderListWithOrder_status:@"4" pageNO:ChangeNSIntegerToStr(self.currentPage) page_size:@"30"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            orderList_model = [OrderListModel mj_objectWithKeyValues:responseObject];
            
            [self.refreshTableView cyl_reloadData];
            [self endRefresh];
            if (self.currentPage >= orderList_model.result.total_pages) {
                
                [self hidenFooterView];
                
            }
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method 没有数据界面显示

- (UIView *)makePlaceHolderView {
    
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.refreshTableView.frame];
    weChatStylePlaceHolder.delegate = self;
    
    weChatStylePlaceHolder.imageName = @"order_empty.png";
    weChatStylePlaceHolder.title = @"您还没有订单哦";
    weChatStylePlaceHolder.content = @"快去下单吧!";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
    [self beginFresh];
}


- (UITableView *)orderTableView
{
    if (!_orderTableView) {
        _orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -40 -64) style:UITableViewStyleGrouped];
        _orderTableView.delegate = self;
        _orderTableView.dataSource = self;
        _orderTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [_orderTableView registerNib:[UINib nibWithNibName:@"ZMCMyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    }
    return _orderTableView;
}


#pragma mark- tableview协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return orderList_model.result.data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (orderList_model.result.data[section].order_cook) {
        return orderList_model.result.data[section].order_bizs.count+1;
    }
    return orderList_model.result.data[section].order_bizs.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ZMCMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    static NSString *identifier = @"ZMCMyOrderTableViewCell";
    
    ZMCMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMCMyOrderTableViewCell" owner:nil options:nil] firstObject];
    }
    
    if (orderList_model.result.data[indexPath.section].order_cook) {
        
        if (indexPath.row == 0) {
            [cell setOrderCookInfo:orderList_model.result.data[indexPath.section].order_cook WithOrderStatus:orderList_model.result.data[indexPath.section].order_status WithOrderId:orderList_model.result.data[indexPath.section].order_id WithNavigationController:self.navigationController];
        }else {
            [cell setOrderInfo:orderList_model.result.data[indexPath.section].order_bizs[indexPath.row-1] WithOrderStatus:orderList_model.result.data[indexPath.section].order_status WithOrderId:orderList_model.result.data[indexPath.section].order_id WithCreate_time:orderList_model.result.data[indexPath.section].create_time WithNavigationController:self.navigationController];
        }
        
        
    }else {
        
        [cell setOrderInfo:orderList_model.result.data[indexPath.section].order_bizs[indexPath.row] WithOrderStatus:orderList_model.result.data[indexPath.section].order_status WithOrderId:orderList_model.result.data[indexPath.section].order_id WithCreate_time:orderList_model.result.data[indexPath.section].create_time WithNavigationController:self.navigationController];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (orderList_model.result.data[indexPath.section].order_cook) {
        if (indexPath.row == 0) {
            return 150;
        }else {
            return 85+110*orderList_model.result.data[indexPath.section].order_bizs[indexPath.row-1].goods.count;
        }
        //        return 150;
    }
    return 85+110*orderList_model.result.data[indexPath.section].order_bizs[indexPath.row].goods.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:view];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 3, 40)];
    label.backgroundColor = ThemeGreenColor;
    [view addSubview:label];
    
    UILabel *orderLabel = [[UILabel alloc] init];
    orderLabel.font = [UIFont systemFontOfSize:15];
    orderLabel.textColor = StringMiddleColor;
    [view addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(15);
    }];
    //    orderLabel.text = @"订单号：7465161123132";
    orderLabel.text =[NSString stringWithFormat:@"订单号：%@",orderList_model.result.data[section].order_sn];
    
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [view addSubview:timeLabel];
    timeLabel.font = [UIFont systemFontOfSize:15];
    timeLabel.textColor = StringLightColor;
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(- 10);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(15);
    }];
    //    timeLabel.text = @"2015-12-25";
    timeLabel.text = orderList_model.result.data[section].order_status_name;
    return bgView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *money = [[UILabel alloc] init];
    [view addSubview:money];
    money.font = [UIFont systemFontOfSize:15];
    money.textColor = StringMiddleColor;
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(10);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(15);
    }];
    //    money.text = @"合计：￥120.00";
    money.text = [NSString stringWithFormat:@"合计：%.2f",orderList_model.result.data[section].paid_money];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button];
    [button setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"确认收货" forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.borderColor = ThemeGreenColor.CGColor;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-10);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(87);
    }];
    //    [button addTarget:self action:@selector(clickToCancelOrder) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:button1];
    [button1 setTitleColor:StringMiddleColor forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [button1 setTitle:@"取消订单" forState:UIControlStateNormal];
    button1.layer.cornerRadius = 4;
    button1.layer.masksToBounds = YES;
    button1.layer.borderWidth = 1;
    button1.layer.borderColor = StringMiddleColor.CGColor;
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(button).offset(-97);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(87);
    }];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        select_section = section;
        
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:@"是否确认收货"
                                   delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil] show];
        
    }];
    
//    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        
//        [CommonHttpAPI postCancelOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)orderList_model.result.data[section].order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//            
//            NSLog(@"%@",responseObject);
//            if ([responseObject getTheResultForDic]) {
//                
//                [OMGToast showWithText:@"订单已取消"];
//                [self getOrderListInfo];
//            }else {
//                
//                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
//                
//            }
//            
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            NSLog(@"%@",error);
//        }];
//    }];
    //    [button1 addTarget:self action:@selector(clickToConfirm:) forControlEvents:UIControlEventTouchUpInside];
    
    if (orderList_model.result.data[section].order_status == 4) {
//        button.hidden = YES;
        button1.hidden = YES;
    }
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailVC *vc = [[OrderDetailVC alloc] initWithNibName:@"OrderDetailVC" bundle:nil];
    vc.order_id = ChangeNSIntegerToStr(orderList_model.result.data[indexPath.section].order_id);
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [CommonHttpAPI postOrderFinishWithEspecId:[NSString stringWithFormat:@"/%ld",(long)orderList_model.result.data[select_section].order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            if ([responseObject getTheResultForDic]) {
                
                [OMGToast showWithText:@"已确认收货"];
                [self getOrderListInfo];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];

    }
}

#pragma mark- 点击取消订单
//- (void)clickToCancelOrder
//{
//
//}
//- (void)clickToConfirm:(UIButton *)button
//{
//    if ([button.titleLabel.text containsString:@"提醒"]) {
//        //        提醒发货
//    }
//    if ([button.titleLabel.text containsString:@"确认"]) {
//        //        确认收货
//    }
//}
@end
