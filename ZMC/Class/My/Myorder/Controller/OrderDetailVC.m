//
//  OrderDetailVC.m
//  ZMC
//
//  Created by Naive on 16/6/1.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "OrderDetailVC.h"
#import "YBSegmentView.h"
#import "OrderDetailModel.h"
#import "OrderListModel.h"
#import "NSString+WPAttributedMarkup.h"
#import "WPAttributedStyleAction.h"

#import "ClothesTailCell.h"
#import "ClothesTailCurrentCell.h"
#import "OrderDetailHeadCell.h"
#import "ZMCMyOrderTableViewCell.h"


@interface OrderDetailVC ()<YBSegmentViewPro,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    
    YBSegmentView *titleView ;//标题自定义view
    
    UITableView *orderDetailTableView;
    
    NSString *orderListStatus;
    
    OrderDetailModel *model;
    
    TapStatus tapSta;
    
    NSInteger select_section;
    
    NSString *_numberStr;
    
}


@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    titleView =[[YBSegmentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 44)];
    titleView.titleSegBtnAry =[NSMutableArray arrayWithObjects:@"订单详情",@"物流详情", nil];
    titleView.YBsegDelegete =self;
    [self.view addSubview:titleView];
    
    orderDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,NAV_H+10, SCREEN_W, SCREEN_H - NAV_H - 72) style:UITableViewStyleGrouped];
    //    [orderDetailTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    orderDetailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [orderDetailTableView setSeparatorInset:UIEdgeInsetsMake(0, 40, 0, 0)];
    orderDetailTableView.showsVerticalScrollIndicator = NO;
    orderDetailTableView.backgroundColor = MAIN_BALCOLOR;
    [self.view addSubview:orderDetailTableView];
    
    orderDetailTableView.delegate = self;
    orderDetailTableView.dataSource = self;
    self.refreshTableView = orderDetailTableView;
    
    
    tapSta = OrderDetailStatus;
    [self getOrderListWithStatus:tapSta];
    
    //接收一切通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notice:) name:@"refresh" object:nil];
    
}

-(void)notice:(id)sender{
    
    [CommonHttpAPI getOrderDetailWithEspecId:[NSString stringWithFormat:@"/%@",self.order_id] lWithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            model = [OrderDetailModel mj_objectWithKeyValues:responseObject];
            
            [orderDetailTableView reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
        [SVProgressHUD dismiss];
    }];
}

-(void)YbSegDidSelect:(NSInteger )didSelect{
    
    
    switch (didSelect) {
        case 0:
        {
            tapSta = OrderDetailStatus;
            break;
        }
        case 1:
        {
            tapSta = OrderTrailStatus;
            break;
        }
            
        default:
            break;
    }
    
    [self getOrderListWithStatus:tapSta];
    
}

-(void)getOrderListWithStatus:(TapStatus )status{
    
    switch (status) {
        case OrderDetailStatus:{
            
            if (model != nil) {
                [self.refreshTableView reloadData];
                return ;
            }
            [SVProgressHUD showWithStatus:@"加载中.."];
            
            [CommonHttpAPI getOrderDetailWithEspecId:[NSString stringWithFormat:@"/%@",self.order_id] lWithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                [SVProgressHUD dismiss];
                ZMCLog(@"%@",responseObject);
                if ([responseObject getTheResultForDic]) {
                    
                    model = [OrderDetailModel mj_objectWithKeyValues:responseObject];
                    
                    [orderDetailTableView reloadData];
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
                [SVProgressHUD dismiss];
            }];
            
            
            //            [YBGifLoadingView show];
//            [OrderHttpAPI getOrderDetailWithEspecId:self.order_id WithParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                
//                //                [YBGifLoadingView dismiss];
//                
//                NSLog(@"%@",JsonFromDic(responseObject));
//                if ([responseObject getTheResultForDic]){
//                    [SVProgressHUD dismiss];
//                    model = [OrderDetailModel mj_objectWithKeyValues:responseObject];
//                    NSLog(@"%@",model);
//                    [self racMehod];
//                    
//                    [orderDetailTableView reloadData];
//                }else{
//                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
//                }
//                
//                
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                //                [YBGifLoadingView dismiss];
//                [SVProgressHUD dismiss];
//            }];
            
            break;
        }
        case OrderTrailStatus:{
            
            
            
            //            if (logsModel !=nil) {
            //                [self.refreshTableView reloadData];
            //                return ;
            //            }
            //            [SVProgressHUD showWithStatus:@"加载中.." maskType:SVProgressHUDMaskTypeNone];
            //            [OrderHttpAPI getOrderStatusWithEspecId:@"1" WithParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //                NSLog(@"%@",JsonFromDic(responseObject));
            //                if ([responseObject getTheResultForDic]){
            //                    [SVProgressHUD dismiss];
            //                    logsModel = [OrderLogsModel mj_objectWithKeyValues:responseObject];
            //
            //                    NSLog(@"%@",model);
            //
            //                    [orderDetailTableView reloadData];
            //                }else{
            //                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            //                }
            //
            //
            //            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //                [SVProgressHUD dismiss];
            //            }];
            //
            
            [self.refreshTableView reloadData];
            break;
        }
            
        default:
            break;
    }
    
    [self.refreshTableView reloadData];
    
    
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tapSta == OrderDetailStatus) {
        return 2;
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tapSta == OrderDetailStatus) {
        if (section == 1) {
            
            if (model.result.order_cook) {
                
                return model.result.order_bizs.count+1;
            }else
                return model.result.order_bizs.count;
        }else {
            return 1;
        }
        
    }else{
        return model.result.order_logs.count;
    }
}

#pragma mark - 每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tapSta == OrderDetailStatus) {
        if (indexPath.section == 0) {
            return 185;
        }else if (indexPath.section == 1) {
            
            if (model.result.order_cook) {
                
                if (indexPath.row == 0) {
                    return 150;
                }else {
                    return 85+110*model.result.order_bizs[indexPath.row-1].goods.count;
                }
            }else
                return 85+110*model.result.order_bizs[indexPath.row].goods.count;
        }else{
            return 100;
        }
    }else{
        return 54;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tapSta == OrderDetailStatus) {
        
        if (section == 0) {
            return 1;
        }else if(section == 1){
            return 50;
        }else{
            return 1;
        }
    }else{
        return 50;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tapSta == OrderDetailStatus) {
        if (section == 1) {
            return 50;
        }
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (tapSta == OrderDetailStatus) {
        
        if (section == 1) {
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
            orderLabel.text =[NSString stringWithFormat:@"订单号：%@",model.result.order_sn];
            
            
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
            timeLabel.text = model.result.order_status_name;
            return bgView;
        }
        
    }else{
        
        static NSString *identifier = @"HeadView";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (headerView == nil) {
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identifier];
        }
        
        headerView.contentView.backgroundColor=[UIColor whiteColor];
        [headerView setFrame:CGRectMake(0, 0, SCREEN_W, 50)];
        
        UILabel *header_lab = [[UILabel  alloc] initWithFrame:CGRectMake(16, 0, SCREEN_W-20, 50)];
        header_lab.text = @"物流跟踪";
        header_lab.textColor = [UIColor darkGrayColor];
        header_lab.font = [UIFont systemFontOfSize:15];
        
        [headerView addSubview:header_lab];
        
        
        
        return headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tapSta == OrderDetailStatus) {
        
        if (section == 1) {
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
            money.text = [NSString stringWithFormat:@"合计：%@",model.result.paid_money];
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [view addSubview:button];
            [button setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:@"提醒配送" forState:UIControlStateNormal];
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
            
//            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//                
//                [CommonHttpAPI postReminderOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)model.result.order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//                    
//                    NSLog(@"%@",responseObject);
//                    [button setTitle:@"已提醒" forState:UIControlStateNormal];
//                    button.userInteractionEnabled = NO;
//                    if ([responseObject getTheResultForDic]) {
//                        
//                        [OMGToast showWithText:@"已提醒配送，请耐心等待"];
//                        
//                    }else {
//                        
//                        [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
//                        
//                    }
//                    
//                } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                    NSLog(@"%@",error);
//                }];
//            }];
            
            [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                
                select_section = section;
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                    message:@"是否取消订单"
                                                                   delegate:self
                                                          cancelButtonTitle:@"取消"
                                                          otherButtonTitles:@"确定",nil];
                [alertView show];
                alertView.tag = 2;
                
                
            }];
            //    [button1 addTarget:self action:@selector(clickToConfirm:) forControlEvents:UIControlEventTouchUpInside];
            
//            if (model.result.order_status == 0 || model.result.order_status == 3 ||model.result.order_status == 5) {
//                button.hidden = YES;
//                button1.hidden = YES;
//            }
//            if (model.result.order_status == 4) {
//                [button setTitle:@"确认收货" forState:UIControlStateNormal];
//                [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//                    
//                    select_section = section;
//                    
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                                        message:@"是否确认收货"
//                                                                       delegate:self
//                                                              cancelButtonTitle:@"取消"
//                                                              otherButtonTitles:@"确定",nil];
//                    [alertView show];
//                    alertView.tag = 4;
//                    
//                    
//                }];
//                button1.hidden = YES;
//            }else
                if (model.result.order_status == 3 || model.result.order_status == -1) {
                    
                    button.hidden = YES;
                    button1.hidden = YES;
                }else if (model.result.order_status == 4) {
                    [button setTitle:@"确认收货" forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                        
                        select_section = section;
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                            message:@"是否确认收货"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"取消"
                                                                  otherButtonTitles:@"确定",nil];
                        [alertView show];
                        alertView.tag = 4;
                        
                        
                    }];
                    button1.hidden = YES;
                }else if (model.result.order_status == 5 || model.result.order_status == 0 ) {
                    [button setTitle:@"删除订单" forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                        
                        select_section = section;
                        
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                            message:@"是否删除订单"
                                                                           delegate:self
                                                                  cancelButtonTitle:@"取消"
                                                                  otherButtonTitles:@"确定",nil];
                        [alertView show];
                        alertView.tag = 5;
                        
                        
                    }];
                    button1.hidden = YES;
                }else {
                [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                    
                    [CommonHttpAPI postReminderOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)model.result.order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                        
                        ZMCLog(@"%@",responseObject);
                        if ([responseObject getTheResultForDic]) {
                            
                            [OMGToast showWithText:@"已提醒配送，请耐心等待"];
                            [button setTitle:@"已提醒" forState:UIControlStateNormal];
                            button.userInteractionEnabled = NO;
                            
                        }else {
                            
                            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                            [button setTitle:@"已提醒" forState:UIControlStateNormal];
                            button.userInteractionEnabled = NO;
                            
                        }
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        ZMCLog(@"%@",error);
                    }];
                }];
            }
            
            return view;
            
        }
        
    }else {
        
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tapSta == OrderDetailStatus) {
        
        if (indexPath.section == 0) {
            static NSString *identifier = @"OrderDetailHeadCell";
            
            OrderDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderDetailHeadCell" owner:nil options:nil] firstObject];
            }
            
            
            cell.consignee_lab.text = model.result.consignee;
            cell.address_lab.text = [NSString stringWithFormat:@"%@%@%@%@", model.result.province_name, model.result.city_name, model.result.district_name, model.result.address];
//            cell.address_lab.text = model.result.address;
            cell.mobile_lab.text = model.result.mobile;
            cell.orderSn_lab.text = model.result.order_sn;
            cell.orderTime_lab.text = model.result.create_time;
            cell.selectTime_lab.text = model.result.delivery_time;
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;

        }else {
            
            static NSString *identifier = @"ZMCMyOrderTableViewCell";
            
            ZMCMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMCMyOrderTableViewCell" owner:nil options:nil] firstObject];
            }
            
            
        
            
            if (model.result.order_cook) {
                
                if (indexPath.row == 0) {
                    
                    OrderListOrderCook *cook = [OrderListOrderCook mj_objectWithKeyValues:model.result.order_cook];
                    
                    [cell setOrderCookInfo:cook WithOrderStatus:model.result.order_status WithOrderId:model.result.order_id WithNavigationController:self.navigationController];
                }else {
                    
                    OrderListOrderBizs *bizs = [OrderListOrderBizs mj_objectWithKeyValues:model.result.order_bizs[indexPath.row-1]];
                    
                    [cell setOrderInfo:bizs WithOrderStatus:model.result.order_status WithOrderId:model.result.order_id WithCreate_time:model.result.create_time WithNavigationController:self.navigationController];
                }
                
            }else {
                
                OrderListOrderBizs *bizs = [OrderListOrderBizs mj_objectWithKeyValues:model.result.order_bizs[indexPath.row]];
//                NSLog(@"%ld",(long)bizs.goods[0].has_comment);
//                NSLog(@"%ld",(long)model.result.order_bizs[indexPath.row].goods[0].has_comment);
                [cell setOrderInfo:bizs WithOrderStatus:model.result.order_status WithOrderId:model.result.order_id WithCreate_time:model.result.create_time WithNavigationController:self.navigationController];
            }
            
            
            //    [cell.cancelOrder addTarget:self action:@selector(clickToCancelOrder) forControlEvents:UIControlEventTouchUpInside];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
        }
        
    }else{
        
        ClothesTailCell *cell = [tableView dequeueReusableCellWithIdentifier:[ClothesTailCell cellIdentifier]];
        ClothesTailCurrentCell *cellCurr = [tableView dequeueReusableCellWithIdentifier:[ClothesTailCurrentCell cellIdentifier]];
        if (cell ==nil) {
            if (indexPath.row ==0) {
                cellCurr = (ClothesTailCurrentCell *)[[[NSBundle mainBundle] loadNibNamed:@"ClothesTailCurrentCell" owner:self options:nil] lastObject];
            }else{
                cell = (ClothesTailCell *)[[[NSBundle mainBundle] loadNibNamed:@"ClothesTailCell" owner:self options:nil] lastObject];
            }
            
        }
        
        if (indexPath.row ==0) {

            
            NSString *str = [NSString stringWithFormat:@"【%@】 %@",model.result.order_logs[indexPath.row].status_name,model.result.order_logs[indexPath.row].desc];
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:str];
            cellCurr.logisticsDes_labTwo.attributedText = attributedString;
            
            cellCurr.logisticsTime_lab.text = model.result.order_logs[indexPath.row].create_time;
     
//            NSString *descStr = model.result.order_logs[indexPath.row].desc;
//            if ([descStr rangeOfString:@"配送工人"].location != NSNotFound && [descStr rangeOfString:@"1"].location != NSNotFound)
//            {
//                ZMCLog(@"%@", model.result.order_logs[indexPath.row].desc);
//                
//                NSRange range1 = [descStr rangeOfString:@"["];
//                NSRange range2 = [descStr rangeOfString:@"]"];
//                
//                NSString *numberStr = [descStr substringWithRange:NSMakeRange(range1.location + 4, 11)];
//                ZMCLog(@"截取到的手机号%@", numberStr);
//                _numberStr = numberStr;
//                
//                NSDictionary* style3 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
//                                         @"number":[WPAttributedStyleAction styledActionWithAction:^{
//                                             ZMCLog(@"Help action");
//                                         }],
//                                         @"link": RGB(88, 168, 247)};
//                
//                NSRange range3 = [descStr rangeOfString:numberStr];
//                NSString *FrontStr = [descStr substringToIndex:range3.location];
//                NSString *behindStr = [descStr substringWithRange:NSMakeRange(range2.location, 4)];
//                ZMCLog(@"%@--%@", FrontStr, behindStr);
//                
//                NSString *lableStr = [NSString stringWithFormat:@"【%@】 %@ <number>%@</number> %@", model.result.order_logs[indexPath.row].status_name, FrontStr, numberStr, behindStr];
//                cellCurr.logisticsDes_lab.attributedText = [lableStr attributedStringWithStyleBook:style3];
//                
//                cellCurr.logisticsDes_lab.userInteractionEnabled = YES;
//                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNumber:)];
//                [cellCurr.logisticsDes_lab addGestureRecognizer:tapGes];
            
//            }else{
//                
//                cellCurr.logisticsDes_lab.text = [NSString stringWithFormat:@"【%@】 %@",model.result.order_logs[indexPath.row].status_name,model.result.order_logs[indexPath.row].desc];
//            }
        }else{
            
//            NSString *descStr = model.result.order_logs[indexPath.row].desc;
//            if ([descStr rangeOfString:@"配送工人"].location != NSNotFound && [descStr rangeOfString:@"1"].location != NSNotFound)
//            {
//                ZMCLog(@"%@", model.result.order_logs[indexPath.row].desc);
//                
//                NSRange range1 = [descStr rangeOfString:@","];
//                NSRange range2 = [descStr rangeOfString:@"]"];
//                
//                NSString *numberStr = [descStr substringWithRange:NSMakeRange(range1.location + 1, 11)];
//                ZMCLog(@"截取到的手机号%@", numberStr);
//                _numberStr = numberStr;
//                
//                NSDictionary* style3 = @{@"body":[UIFont fontWithName:@"HelveticaNeue" size:14.0],
//                                         @"number":[WPAttributedStyleAction styledActionWithAction:^{
//                                             ZMCLog(@"Help action");
//                                         }],
//                                         @"link": RGB(88, 168, 247)};
//                
//                NSRange range3 = [descStr rangeOfString:numberStr];
//                NSString *FrontStr = [descStr substringToIndex:range3.location];
//                NSString *behindStr = [descStr substringWithRange:NSMakeRange(range2.location, 4)];
//                ZMCLog(@"%@--%@", FrontStr, behindStr);
//                
//                NSString *lableStr = [NSString stringWithFormat:@"【%@】 %@ <number>%@</number> %@", model.result.order_logs[indexPath.row].status_name, FrontStr, numberStr, behindStr];
//                cell.logisticsDes_lab.attributedText = [lableStr attributedStringWithStyleBook:style3];
//                
//                cell.logisticsDes_lab.userInteractionEnabled = YES;
//                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNumber:)];
//                [cell.logisticsDes_lab addGestureRecognizer:tapGes];
                
//            }else{
//                
//                cell.logisticsDes_lab.text = [NSString stringWithFormat:@"【%@】 %@",model.result.order_logs[indexPath.row].status_name,model.result.order_logs[indexPath.row].desc];
//            }
            
            NSString *str = [NSString stringWithFormat:@"【%@】 %@",model.result.order_logs[indexPath.row].status_name,model.result.order_logs[indexPath.row].desc];
            NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:str];
            cell.logisticsDes_labOne.attributedText = attributedString;
            
            cell.logisticsTime_lab.text = model.result.order_logs[indexPath.row].create_time;
        }
        
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cellCurr setSelectionStyle:UITableViewCellSelectionStyleNone];
        if (indexPath.row ==0) {
            return cellCurr;
        }else{
            return cell;
        }
    }
    return nil;
}

//- (void)clickNumber:(UITapGestureRecognizer *)ges {
//
//    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_numberStr];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    
//}


#pragma mark -UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == 2) {
            [CommonHttpAPI postCancelOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)model.result.order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                if ([responseObject getTheResultForDic]) {
                    
                    [OMGToast showWithText:@"订单已取消"];
                    model = nil;
                    [self getOrderListWithStatus:tapSta];
                    
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
            }];
        }else if (alertView.tag == 4) {
            [CommonHttpAPI postOrderFinishWithEspecId:[NSString stringWithFormat:@"/%ld",(long)model.result.order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                if ([responseObject getTheResultForDic]) {
                    
                    [OMGToast showWithText:@"已确认收货"];
                    model = nil;
                    [self getOrderListWithStatus:tapSta];
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
            }];
        }else if (alertView.tag == 5) {
            [CommonHttpAPI postDeleteOrderWithEspecId:[NSString stringWithFormat:@"/%ld",(long)model.result.order_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                if ([responseObject getTheResultForDic]) {
                    
                    [OMGToast showWithText:@"订单已删除"];
                    model = nil;
                    [self getOrderListWithStatus:tapSta];
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
            }];
        }
        
    }
    
}

@end
