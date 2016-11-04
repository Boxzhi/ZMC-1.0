//
//  ZMCCouponViewController.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCouponViewController.h"
#import "ZMCCouponTableViewCell.h"
#import "ZMCMeiCouponTableViewCell.h"
#import "ZMCCouponManger.h"
#import "ZMCCouponItem.h"
#import "ZMCRefreshHeader.h"
#import "ZMCRefreshFooter.h"



static NSString *cellID = @"cellID";
@interface ZMCCouponViewController ()<UITableViewDelegate, UITableViewDataSource, CYLTableViewPlaceHolderDelegate> {
    
//    /**
//     *  优惠券的数据源
//     */
//    DiscountModel *discount_model;
}

@property (nonatomic, strong) NSMutableArray *dataarray;

@end

@implementation ZMCCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCCouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCMeiCouponTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MeiCell"];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGB(244, 244, 244);
    

    self.tableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    // 加载数据
    [self loadData];
}



- (void)setNavigationBar{
    self.navigationItem.title = @"我的优惠券";
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 加载数据
- (void)loadData{
    
    [ZMCCouponManger queCouponResult:^(NSDictionary *result) {
        
        ZMCLog(@"拿到的优惠券信息%@", result);
        
        [ZMCCouponItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"itemid":@"id"};
        }];
        _dataarray = [ZMCCouponItem mj_objectArrayWithKeyValuesArray:result[@"data"]];
        [self.tableView cyl_reloadData];
        
        [self.tableView.mj_header endRefreshing];

    }];

}

#pragma mark - TableViewSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    if (section == 0) {
//        return discount_model.result.data.count;
////    }else{
////        return 10;
////    }
    return _dataarray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
        return 10;
//    }
//    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGB(244, 244, 244);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ZMCCouponTableViewCell";
    
    ZMCCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMCCouponTableViewCell" owner:nil options:nil]firstObject];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.item = _dataarray[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isPerson == 9999) {
        //此时判断优惠券 有没有效果
        
//        ZMCCouponItem *item = [[ZMCCouponItem alloc] init];
        ZMCCouponItem *item = _dataarray[indexPath.row];
        
        [CommonHttpAPI getCheckCouponsWithParameters:[CommonRequestModel getCheckCouponWithCoupon_id:[NSString stringWithFormat:@"%@",item.itemid] delivery_way_id:self.delivery_way_id list:self.list] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([responseObject getTheResultForDic]) {
                
                if (self.didSelect) {
                    
                    DiscountData *model = [[DiscountData alloc] init];
                    model.denomination = [item.denomination floatValue];
                    model.coupon_id = [item.itemid integerValue];
                    model.title = item.title;
                    model.expire_time = item.expire_time;
                    model.desc = item.desc;
                    
                    self.didSelect(model);
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
    }
}


- (UIView *)makePlaceHolderView{
    UIView *view = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"youhuiquan"];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(265);
        make.height.mas_equalTo(117);
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY).offset(-50);
    }];

    return view;
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}

@end
