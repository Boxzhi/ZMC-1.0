//
//  ShopsDetailVC.m
//  ZMC
//
//  Created by Naive on 16/6/4.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ShopsDetailVC.h"
#import "MerchantDetailModel.h"
#import "MerchantGoodsCell.h"
#import "MerchantGoodsHeadCell.h"
#import "ShopsDetailHeadView.h"
#import "GoodsDetailVC.h"


#import "WLNetworkErrorView.h"

@interface ShopsDetailVC ()<WLNetworkErrorViewDelegate> {
    
    MerchantDetailModel *merchant_model;
    
    UITableView *_tableView;
    
    BOOL is_special;
    
    int is_fav;
    
    ShopsDetailHeadView *shopsDetailHeadView;
    
    WLNetworkErrorView *networkErrorView;
}
//@property (weak, nonatomic) IBOutlet UIImageView *shopsImg;
//@property (weak, nonatomic) IBOutlet UIImageView *shopsHeadImg;
//@property (weak, nonatomic) IBOutlet UILabel *shopsName_lab;
//@property (weak, nonatomic) IBOutlet UILabel *shopsBooth_lab;
//@property (weak, nonatomic) IBOutlet UILabel *shopsMarket_lab;
//@property (weak, nonatomic) IBOutlet UIImageView *shopsStarImg;
//
//
//@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
//@property (weak, nonatomic) IBOutlet UILabel *collectNum_lab;
//@property (weak, nonatomic) IBOutlet UIButton *shopsLeftBtn;
//@property (weak, nonatomic) IBOutlet UIButton *shopsRightBtn;
//@property (weak, nonatomic) IBOutlet UIView *shopsLeftView;
//@property (weak, nonatomic) IBOutlet UIView *shopsRightView;

@end

@implementation ShopsDetailVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [networkErrorView networkErrorRemove];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor  = MAIN_BALCOLOR;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.refreshTableView = _tableView;
    self.currentPage = 1;
    
    __weak typeof(self) blockSelf = self;
    [self setAnimationMJrefreshHeader:^{
        [blockSelf loadNewData];
    }];
    
    is_special = NO;
    
    [self getmerchantDetailInfo];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    self.currentPage = 1;
    [self getmerchantDetailInfo];
    
}


//获取店铺详情数据
- (void)getmerchantDetailInfo {
    
    [CommonHttpAPI getMercantDetailWithEspecId:[NSString stringWithFormat:@"/%@",self.merchant_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            merchant_model = [MerchantDetailModel mj_objectWithKeyValues:responseObject];
            
            self.title = merchant_model.result.name;
            
//            [self.shopsImg sd_setImageWithURL:GET_IMAGEURL_URL(merchant_model.result.pic) placeholderImage:[UIImage imageNamed:@"shangpinxiangqing.png"]];
//            [self.shopsHeadImg sd_setImageWithURL:GET_IMAGEURL_URL(merchant_model.result.avatar_url) placeholderImage:[UIImage imageNamed:@"shangdian-touxiang.png"]];
//            self.shopsName_lab.text = merchant_model.result.name;
//            self.shopsMarket_lab.text = merchant_model.result.market_name;
//            self.shopsBooth_lab.text = [NSString stringWithFormat:@"-%@号摊位",merchant_model.result.boothNo];
//            self.collectNum_lab.text = [NSString stringWithFormat:@"已有%ld人收藏",(long)merchant_model.result.collection_count];
//            if (merchant_model.result.score >= 2) {
//                self.shopsStarImg.image = [UIImage imageNamed:@"star_1.png"];
//                if (merchant_model.result.score >= 4) {
//                    self.shopsStarImg.image = [UIImage imageNamed:@"star_2.png"];
//                    if (merchant_model.result.score >= 6) {
//                        self.shopsStarImg.image = [UIImage imageNamed:@"star_3.png"];
//                        if (merchant_model.result.score >= 8) {
//                            self.shopsStarImg.image = [UIImage imageNamed:@"star_4.png"];
//                            if (merchant_model.result.score >= 10) {
//                                self.shopsStarImg.image = [UIImage imageNamed:@"star_5.png"];
//                            }
//                        }
//                    }
//                }
//            }
//            
//            if (merchant_model.result.is_fav == 1) {
//                
//                [self.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
//            }
            is_fav = merchant_model.result.is_fav;
            
            [self.refreshTableView cyl_reloadData];
            [self endRefresh];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
        [networkErrorView networkErrorRemove];
        //        [WLNetworkErrorView dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
//        networkErrorView = [[WLNetworkErrorView  alloc] initWithText:@"亲，您的手机网络不太顺畅喔~" imageName:@"wu.png" buttonTitile:@"重新加载"];
//        networkErrorView.delegete = self;
//        [networkErrorView networkErrorShow];
        //        [WLNetworkErrorView networkErrorShowWithBlock:^{
        //            [self getGoodsDetailInfo];
        //        }];
    }];
    
}

#pragma mark - WLNetworkErrorViewDelegate 的代理
- (void)getReload {
    
    [self getmerchantDetailInfo];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return 1;
        
    }else if (section == 1) {
        
        if (is_special) {
            return merchant_model.result.special_lists.count;
        }else
            return merchant_model.result.n_lists.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (kScreenWidth == 320) {
            return 275;
        }else if (kScreenWidth == 375){
            return 310;
        }else{
            return 330;
        }
    }else if (indexPath.section == 1) {
        return 110;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 41;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    static NSString *identifier = @"HeaderView";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
    }
    headerView.contentView.backgroundColor = [UIColor whiteColor];
    [headerView setFrame:CGRectMake(0, 0, tableView.frame.size.width, 41)];
    
    shopsDetailHeadView = (ShopsDetailHeadView *)[[[NSBundle mainBundle] loadNibNamed:@"ShopsDetailHeadView" owner:nil options:nil]lastObject];
    shopsDetailHeadView.frame = CGRectMake(0, 0, SCREEN_W, 41);
    [shopsDetailHeadView.shopsLeftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shopsDetailHeadView.shopsRightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if (is_special) {
        [shopsDetailHeadView.shopsLeftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        shopsDetailHeadView.shopsLeftView.hidden = YES;
        [shopsDetailHeadView.shopsRightBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
        shopsDetailHeadView.shopsRightView.hidden = NO;
    }else {
        [shopsDetailHeadView.shopsLeftBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
        shopsDetailHeadView.shopsLeftView.hidden = NO;
        [shopsDetailHeadView.shopsRightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        shopsDetailHeadView.shopsRightView.hidden = YES;
    }
    
    
    [headerView addSubview:shopsDetailHeadView];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"MerchantGoodsHeadCell";
        
        MerchantGoodsHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MerchantGoodsHeadCell" owner:nil options:nil] firstObject];
        }
        
        [cell.collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.collectBtn.layer setBorderWidth:1.0];
        [cell.collectBtn.layer setCornerRadius:5.0f];
        [cell.collectBtn.layer setBorderColor:[ThemeGreenColor CGColor]];
        
        [cell.shopsImg sd_setImageWithURL:GET_IMAGEURL_URL(merchant_model.result.pic) placeholderImage:[UIImage imageNamed:@"shangpinxiangqing.png"]];
        [cell.shopsHeadImg sd_setImageWithURL:GET_IMAGEURL_URL(merchant_model.result.avatar_url) placeholderImage:[UIImage imageNamed:@"shangdian-touxiang.png"]];
        cell.shopsName_lab.text = merchant_model.result.name;
        cell.shopsMarket_lab.text = merchant_model.result.market_name;
        cell.shopsBooth_lab.text = [NSString stringWithFormat:@"-%@",merchant_model.result.boothNo];
        cell.collectNum_lab.text = [NSString stringWithFormat:@"已有%ld人收藏",(long)merchant_model.result.collection_count];
        if (merchant_model.result.score >= 2) {
            cell.shopsStarImg.image = [UIImage imageNamed:@"star_one"];
            if (merchant_model.result.score >= 4) {
                cell.shopsStarImg.image = [UIImage imageNamed:@"star_two"];
                if (merchant_model.result.score >= 6) {
                    cell.shopsStarImg.image = [UIImage imageNamed:@"star_three"];
                    if (merchant_model.result.score >= 8) {
                        cell.shopsStarImg.image = [UIImage imageNamed:@"star_four"];
                        if (merchant_model.result.score >= 10) {
                            cell.shopsStarImg.image = [UIImage imageNamed:@"star_full"];
                        }
                    }
                }
            }
        }
        
        if (merchant_model.result.is_fav == 1) {
            
            [cell.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else if (indexPath.section == 1) {
     
        static NSString *identifier = @"MerchantGoodsCell";
        
        MerchantGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MerchantGoodsCell" owner:nil options:nil] firstObject];
        }
        
        NSString *goods_id;
        
        if (is_special) {
            [cell.goodsImg sd_setImageWithURL:GET_IMAGEURL_URL(merchant_model.result.special_lists[indexPath.row].pic) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
            cell.goodsName_lab.text = merchant_model.result.special_lists[indexPath.row].goods_name;
//            cell.goodsPrice_lab.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2f",merchant_model.result.special_lists[indexPath.row].price] unit:ChangeNSIntegerToStr(merchant_model.result.special_lists[indexPath.row].unit) unitName:merchant_model.result.special_lists[indexPath.row].unit_name leftColor:ThemeGreenColor rightClor:nil];
            cell.goodsPrice_lab.attributedText = [[Singer share] getGoodsMutStrWithPrice:[NSString stringWithFormat:@"%.2f",merchant_model.result.special_lists[indexPath.row].price] unit:ChangeNSIntegerToStr(merchant_model.result.special_lists[indexPath.row].unit) unitName:merchant_model.result.special_lists[indexPath.row].unit_name leftColor:ThemeGreenColor rightClor:nil leftFont:17 rightFont:0];
            goods_id = ChangeNSIntegerToStr(merchant_model.result.special_lists[indexPath.row].goods_id);
        }else {
            
            [cell.goodsImg sd_setImageWithURL:GET_IMAGEURL_URL(merchant_model.result.n_lists[indexPath.row].pic) placeholderImage:[UIImage imageNamed:@"pinglun.png"]];
            cell.goodsName_lab.text = merchant_model.result.n_lists[indexPath.row].goods_name;
//            cell.goodsPrice_lab.attributedText = [[Singer share] getMutStrWithPrice:[NSString stringWithFormat:@"%.2f",merchant_model.result.n_lists[indexPath.row].price] unit:ChangeNSIntegerToStr(merchant_model.result.n_lists[indexPath.row].unit) unitName:merchant_model.result.n_lists[indexPath.row].unit_name leftColor:ThemeGreenColor rightClor:nil];
            cell.goodsPrice_lab.attributedText = [[Singer share] getGoodsMutStrWithPrice:[NSString stringWithFormat:@"%.2f",merchant_model.result.n_lists[indexPath.row].price] unit:ChangeNSIntegerToStr(merchant_model.result.n_lists[indexPath.row].unit) unitName:merchant_model.result.n_lists[indexPath.row].unit_name leftColor:ThemeGreenColor rightClor:nil leftFont:17 rightFont:0];
            goods_id = ChangeNSIntegerToStr(merchant_model.result.n_lists[indexPath.row].goods_id);
        }
        
        //    [[cell.goodsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[[cell.goodsBtn
           rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:cell.rac_prepareForReuseSignal]
         subscribeNext:^(UIButton *x) {
             
             Check_Login
             
             [CommonHttpAPI postGoodsIncreaseWithParameters:[CommonRequestModel getGoodsIncreaseryWithItem_id:goods_id  quantity:@"1" start_time:@"" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 ZMCLog(@"%@",responseObject);
                 
                 if ([responseObject getTheResultForDic]) {
                     
                     [SVProgressHUD showSuccessWithStatus:@"已加入菜篮子"];
                     
                     [ChatbadgecountManager share].badgeCount ++;
                     
                     if ([ChatbadgecountManager share].badgeCount == 0) {
                         [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
                     }else {
                         [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%ld",(long)[ChatbadgecountManager share].badgeCount]];
                     }
                     
                 }else {
                     
                     [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                     
                 }
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 ZMCLog(@"%@",error);
             }];
             
             
         }];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        
        if (is_special) {
            
            MerchantDetailSpecialLists *model = [MerchantDetailSpecialLists mj_objectWithKeyValues:merchant_model.result.special_lists[indexPath.row]];
            GoodsDetailVC *gdVc = [[GoodsDetailVC alloc] init];
            gdVc.goods_id = [NSString stringWithFormat:@"%ld", model.goods_id];
            [self.navigationController pushViewController:gdVc animated:YES];
            
        }else{
            
            MerchantDetailNewLists *model = [MerchantDetailNewLists mj_objectWithKeyValues:merchant_model.result.n_lists[indexPath.row]];
            GoodsDetailVC *gdVc = [[GoodsDetailVC alloc] init];
            gdVc.goods_id = [NSString stringWithFormat:@"%ld", model.goods_id];
            [self.navigationController pushViewController:gdVc animated:YES];
            
        }
    }
}

- (void)collectBtnClick {
    
    Check_Login
    
    if (is_fav == 0) {
        [CommonHttpAPI postFavoriteAddWithParameters:[CommonRequestModel getFavoriteAddWithFav_id:self.merchant_id type:@"4"] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            if ([responseObject getTheResultForDic]) {
                
                [OMGToast showWithText:@"已收藏"];
//                [self.collectBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
                is_fav = 1;
                [self getmerchantDetailInfo];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
    }else {
        
        [CommonHttpAPI postFavoriteDeleteWithParameters:[CommonRequestModel getFavoriteDeleteWithFav_id:self.merchant_id] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            if ([responseObject getTheResultForDic]) {
                
                [OMGToast showWithText:@"已取消收藏"];
//                [self.collectBtn setTitle:@"收藏店铺" forState:UIControlStateNormal];
                is_fav = 0;
                [self getmerchantDetailInfo];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }

        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
    }
    
    
}

- (void)leftBtnClick {
    
//    [shopsDetailHeadView.shopsLeftBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
//    shopsDetailHeadView.shopsLeftView.hidden = NO;
//    [shopsDetailHeadView.shopsRightBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    shopsDetailHeadView.shopsRightView.hidden = YES;
    is_special = NO;
    
    [_tableView reloadData];
}

- (void)rightBtnClick {
    
//    [shopsDetailHeadView.shopsLeftBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    shopsDetailHeadView.shopsLeftView.hidden = YES;
//    [shopsDetailHeadView.shopsRightBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
//    shopsDetailHeadView.shopsRightView.hidden = NO;
    is_special = YES;
    
    [_tableView reloadData];
}



@end
