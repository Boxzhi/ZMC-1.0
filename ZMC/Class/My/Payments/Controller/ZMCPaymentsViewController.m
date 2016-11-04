//
//  ZMCPaymentsViewController.m
//  ZMC
//
//  Created by Will on 16/5/2.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCPaymentsViewController.h"
#import "ZMCRecordTableViewCell.h"
#import "ZMCPaymentsManger.h"
#import "ZMCPaymetsItem.h"


static NSString *recordID = @"recordID";
@interface ZMCPaymentsViewController ()<UITableViewDelegate, UITableViewDataSource, WeChatStylePlaceHolderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *recordTableView;

@property (weak, nonatomic) IBOutlet UIButton *refundButton;


// 账户余额
@property (weak, nonatomic) IBOutlet UILabel *balanceMoney;
// 可退款余额
@property (weak, nonatomic) IBOutlet UILabel *rfMoney;


// 退款记录详细信息
@property (nonatomic, strong) NSArray *refund_list;

@end

@implementation ZMCPaymentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"账户余额";
    
    [self.recordTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCRecordTableViewCell class]) bundle:nil] forCellReuseIdentifier:recordID];
    
    self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.refundButton addTarget:self action:@selector(refundBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadDta];
    
}

- (void)loadDta{
    
    __weak typeof(self) weakSelf = self;
    [ZMCPaymentsManger getPayMentRelust:^(NSDictionary *result) {
    
//        _refund_list = result[@"result"][@"refund_list"];
        _refund_list = [ZMCPaymetsItem mj_objectArrayWithKeyValuesArray:result[@"result"][@"refund_list"]];
        weakSelf.rfMoney.text = [NSString stringWithFormat:@"%@元", result[@"result"][@"allow_refund_money"]];
        weakSelf.balanceMoney.text = [NSString stringWithFormat:@"¥ %@", result[@"result"][@"balance"]];
        
        [weakSelf.recordTableView cyl_reloadData];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _refund_list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMCRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recordID];
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    cell.item = _refund_list[_refund_list.count - indexPath.row - 1];

    return cell;
}

- (void)refundBtn{
    ZMCLog(@"确认退款");

    [SVProgressHUD showWithStatus:@"退款中..."];
    
    NSNumber *money = [NSNumber numberWithInteger:[_rfMoney.text integerValue]];
    [ZMCPaymentsManger postPayMentMonsy:money relust:^(NSDictionary *result) {
        if ([result[@"err_msg"] isEqualToString:@"OK"]) {
            [SVProgressHUD showSuccessWithStatus:@"退款成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            [self loadDta];
            [self.recordTableView cyl_reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:result[@"err_msg"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }];
}


- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.recordTableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
//    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"没有退款记录";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}


@end
