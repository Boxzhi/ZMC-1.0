//
//  GoodsDetailVC.m
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "GoodsDetailHeadCell.h"
#import "GoodsDetailDescriptionCell.h"
#import "GoodsDetailFootCell.h"
#import <UMSocial.h>
#import "WLNetworkErrorView.h"

#import "GoodsDateilModel.h"

#import "UILabel+StringFrame.h"
#import "UIBarButtonItem+NavButton.h"

#import "AppDelegate.h"
#import "ZMCBasketViewController.h"
#import "ShopsDetailVC.h"
#import "CommentsVC.h"
#import "ZMCStoreCell.h"

@interface GoodsDetailVC ()<UMSocialUIDelegate,WLNetworkErrorViewDelegate> {
    
    UITableView *_tableView;
    
    /**
     *  商品详情的数据源
     */
    GoodsDateilModel *goodsDetail_model;
    
    float short_introHeigh;
    
    NSInteger goodsNumber;
    
    UIImage *share_img;
    
    WLNetworkErrorView *networkErrorView;
    
//    NSInteger is_fav;
    BOOL is_back;
}
@property (weak, nonatomic) IBOutlet UIButton *enterShop_btn;
@property (weak, nonatomic) IBOutlet UIButton *collection_btn;
@property (weak, nonatomic) IBOutlet UIButton *joinShopMarket_btn;

@end

@implementation GoodsDetailVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [networkErrorView networkErrorRemove];
//    [WLNetworkErrorView dismiss];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (is_back) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.title = @"商品详情";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"caipushare"] highImage:[UIImage imageNamed:@"caipushare"] target:self action:@selector(rightClick) title:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -2, SCREEN_W, SCREEN_H-NAV_H-70) style:UITableViewStyleGrouped];

    _tableView.backgroundColor  = MAIN_BALCOLOR;
    
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    self.refreshTableView = _tableView;
    self.currentPage = 1;
    
    __weak typeof(self) blockSelf = self;
    [self setAnimationMJrefreshHeader:^{
        [blockSelf loadNewData];
    }];
    
    [self.enterShop_btn addTarget:self action:@selector(enterShopClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.collection_btn addTarget:self action:@selector(collectionClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.joinShopMarket_btn addTarget:self action:@selector(joinShopMarketClick:) forControlEvents:UIControlEventTouchUpInside];
    
    goodsNumber = 1;
    is_back = NO;
    
    [self getGoodsDetailInfo];
}

#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    self.currentPage = 1;
    [self getGoodsDetailInfo];
    
}

/**
 *  获取商品详情数据
 */
- (void)getGoodsDetailInfo {
    
    
    
    [CommonHttpAPI getGoodsDetailWithMethod:[NSString stringWithFormat:@"/%@",self.goods_id] WithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            goodsDetail_model = [GoodsDateilModel mj_objectWithKeyValues:responseObject];
            
            UIImageView *imgView = [[UIImageView alloc] init];
//            [imgView sd_setImageWithURL:GET_IMAGEURL_URL(goodsDetail_model.result.pic_list[0].pic)];
            if (goodsDetail_model.result.pic_list.count != 0) {
                [imgView sd_setImageWithURL:GET_IMAGEURL_URL(CHECK_VALUE(goodsDetail_model.result.pic_list[0].pic)) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    share_img = imgView.image;
                }];
            }else {
                share_img = [UIImage imageNamed:@"pinglun.png"];
            }
            
            
            
            [self getLabelHeigh:goodsDetail_model.result.short_intro];
            
//            if (goodsDetail_model.result.is_fav == 1) {
//                
//                [self.collection_btn setImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateNormal];
//            }
//            is_fav = goodsDetail_model.result.is_fav;
            
//            [_tableView reloadData];
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
    
    [self getGoodsDetailInfo];
    
}

- (void)getLabelHeigh:(NSString *)text
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.text = text;
    label.numberOfLines = 0;
    CGSize size = [label boundingRectWithSize:CGSizeMake(SCREEN_W-26, label.frame.size.height)];
    short_introHeigh = size.height+4;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    }
//    if (section == 0) {
//        return 1;
//    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (goodsDetail_model.result.short_intro.length == 0) {
            short_introHeigh = 0;
        }
        return kScreenWidth * 2 / 3 + 60 +short_introHeigh;
    }else if(indexPath.section == 3) {
        return 220;
    }else if(indexPath.section == 2) {
        return 44;
    }else if (indexPath.section == 1){
        return 70;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *identifier = @"GoodsDetailHeadCell";
        
        GoodsDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailHeadCell" owner:nil options:nil] firstObject];
        }
        
        [cell setGoodsDetailHead:goodsDetail_model.result];
        
//        [[cell.goodsDecrease_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[[cell.goodsDecrease_btn
               rac_signalForControlEvents:UIControlEventTouchUpInside]
              takeUntil:cell.rac_prepareForReuseSignal]
             subscribeNext:^(UIButton *x) {
            
            
            if ([cell.goodsNumber.text isEqualToString:@"1"]) {
                cell.goodsDecrease_btn.adjustsImageWhenHighlighted = NO;
            }else {
                cell.goodsNumber.text = ChangeNSIntegerToStr([cell.goodsNumber.text integerValue] - 1);
                goodsNumber = [cell.goodsNumber.text integerValue];
                if ([cell.goodsNumber.text isEqualToString:@"1"]) {
                    [cell.goodsDecrease_btn setImage:[UIImage imageNamed:@"minus"] forState:(UIControlStateNormal)];
                }
//                [cell.goodsDecrease_btn setImage:[UIImage imageNamed:@"minus_pre"] forState:(UIControlStateNormal)];
            }
        }];
        
//        [[cell.goodsIncrease_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[[cell.goodsIncrease_btn
               rac_signalForControlEvents:UIControlEventTouchUpInside]
              takeUntil:cell.rac_prepareForReuseSignal]
             subscribeNext:^(UIButton *x) {
            if ([cell.goodsNumber.text intValue] <= 98) {
                
                int newNum = [cell.goodsNumber.text intValue] + 1;
                
                cell.goodsNumber.text = [NSString stringWithFormat:@"%d", newNum];
                
                goodsNumber = [cell.goodsNumber.text integerValue];
                
                [cell.goodsDecrease_btn setImage:[UIImage imageNamed:@"minus_pre"] forState:(UIControlStateNormal)];
                
            }else {
                
                cell.goodsIncrease_btn.adjustsImageWhenHighlighted = NO;
                
                return;
            }
        }];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }else if(indexPath.section == 3) {
        
        static NSString *identifier = @"GoodsDetailDescriptionCell";
        
        GoodsDetailDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailDescriptionCell" owner:nil options:nil] firstObject];
        }
        
        [cell setGoodsDetailDescription:goodsDetail_model.result];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }else if(indexPath.section == 2) {
        
        static NSString *identifier = @"GoodsDetailFootCell";
        
        GoodsDetailFootCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsDetailFootCell" owner:nil options:nil] firstObject];
        }
        
        cell.commentNumber_lab.text = [NSString stringWithFormat:@"(%ld)",(long)goodsDetail_model.result.comment_count];
        if (goodsDetail_model.result.score >= 2) {
            cell.commentScoreImgView.image = [UIImage imageNamed:@"mall_detail_xingxing01.png"];
            if (goodsDetail_model.result.score >= 4) {
                cell.commentScoreImgView.image = [UIImage imageNamed:@"mall_detail_xingxing01.png"];
                if (goodsDetail_model.result.score >= 6) {
                    cell.commentScoreImgView.image = [UIImage imageNamed:@"mall_detail_xingxing01.png"];
                    if (goodsDetail_model.result.score >= 8) {
                        cell.commentScoreImgView.image = [UIImage imageNamed:@"mall_detail_xingxing01.png"];
                        if (goodsDetail_model.result.score >= 10) {
                            cell.commentScoreImgView.image = [UIImage imageNamed:@"mall_detail_xingxing01.png"];
                        }
                    }
                }
            }
        }
        if(goodsDetail_model.result.score <= 0) {
            
        }else if (goodsDetail_model.result.score <= 2) {
            cell.commentScoreImgView.image = [UIImage imageNamed:@"smallstar_1.png"];
        }else if (goodsDetail_model.result.score <= 4) {
            cell.commentScoreImgView.image = [UIImage imageNamed:@"smallstar_2.png"];
        }else if (goodsDetail_model.result.score <= 6) {
            cell.commentScoreImgView.image = [UIImage imageNamed:@"smallstar_3.png"];
        }else if (goodsDetail_model.result.score <= 8) {
            cell.commentScoreImgView.image = [UIImage imageNamed:@"smallstar_4.png"];
        }else if (goodsDetail_model.result.score <= 10) {
            cell.commentScoreImgView.image = [UIImage imageNamed:@"smallstar_5.png"];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"ZMCStoreCell";
        
        ZMCStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMCStoreCell" owner:nil options:nil] firstObject];
        }

        [cell.headerimage sd_setImageWithURL:[NSURL URLWithString:goodsDetail_model.result.merchant.pic] placeholderImage:[UIImage imageNamed:@"shoucang"]];
        cell.shopName.text = goodsDetail_model.result.merchant.name;
        cell.shopNumber.text = [NSString stringWithFormat:@"- %@", goodsDetail_model.result.merchant.booth_no];
        cell.sellLabel.text = [NSString stringWithFormat:@"在售%ld件商品", (long)goodsDetail_model.result.merchant.selling_goods_cnt];
        cell.soldLabel.text = [NSString stringWithFormat:@"已售%ld单", (long)goodsDetail_model.result.merchant.sold_orders_cnt];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        ZMCLog(@"跳转评论");
        CommentsVC *vc = [[CommentsVC alloc] initWithNibName:@"CommentsVC" bundle:nil];
        vc.goods_id = self.goods_id;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1){
        
        [self gotoStore];
        
    }
}

#pragma mark - button点击事件

- (void)rightClick {
    
    NSString *share_str = CHECK_VALUE(goodsDetail_model.result.name);
//    if ([share_str isEqualToString:@""]) {
//        
//        share_str = @"怎么吃";
//    }
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 100)];
////    [img sd_setImageWithURL:GET_IMAGEURL_URL(goodsDetail_model.result.pic_list[0].pic)];
//    [img sd_setImageWithURL:GET_IMAGEURL_URL(goodsDetail_model.result.pic_list[0].pic) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
        NSString *url2 = [NSString stringWithFormat:@"http://weixin.zenmechi.cc/#goodsDetail/%@",self.goods_id];
            ZMCLog(@"--------%@",share_img);
        NSString *url = url2;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.qzoneData.url = url;
    
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:UMAppKey
                                          shareText:share_str
                                         shareImage:share_img
                                    shareToSnsNames:@[UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone]
                                           delegate:self];
        
//    }];
   
}

////实现回调方法：
//-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
//{
//    //根据`responseCode`得到发送结果,如果分享成功
//    if(response.responseCode == UMSResponseCodeSuccess)
//    {
//        //得到分享到的平台名
//        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
//    }
//}

/**
 *  进入店铺
 *
 *  @param sender <#sender description#>
 */
- (void)enterShopClick:(UIButton *)sender
{
    [self gotoStore];
}

- (void)gotoStore{
    
    ShopsDetailVC *vc = [[ShopsDetailVC alloc] initWithNibName:@"ShopsDetailVC" bundle:nil];
    vc.merchant_id = [NSString stringWithFormat:@"%ld",(long)goodsDetail_model.result.merchant_id];
    [self.navigationController pushViewController:vc animated:YES];
    
}

/**
 *  收藏
 *
 *  @param sender ;
 */
- (void)collectionClick:(UIButton *)sender
{
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.tabBarController.selectedIndex = 3;
//    });
    
    self.tabBarController.selectedIndex = 3;    
    
//    ZMCBasketViewController *vc = [[ZMCBasketViewController alloc] init];
    
//    [self.navigationController popViewControllerAnimated:NO];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
//    [self.navigationController pushViewController:vc animated:YES];
    
//    });
    
    //    Check_Login
//    if (is_fav == 0) {
//        
//        [self getFavoriteAdd];
//        
//    }else {
//        
//        [self getFavoriteDelete];
//    }
}

/**
 *  加入菜篮子
 *
 *  @param sender <#sender description#>
 */
- (void)joinShopMarketClick:(UIButton *)sender
{
    Check_Login
    
    [SVProgressHUD showWithStatus:@"正在加入菜篮子..."];
//    [OMGToast showWithText:@"正在加入菜篮子..."];
    [CommonHttpAPI postGoodsIncreaseWithParameters:[CommonRequestModel getGoodsIncreaseryWithItem_id:self.goods_id  quantity:ChangeNSIntegerToStr(goodsNumber) start_time:@"" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [SVProgressHUD dismiss];
        ZMCLog(@"%@",responseObject);
        
        if ([responseObject getTheResultForDic]) {
            
            self.tabBarController.selectedIndex = 3;
            
            is_back = YES;
            
            
            [ChatbadgecountManager share].badgeCount = [ChatbadgecountManager share].badgeCount + goodsNumber;
            
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
        [SVProgressHUD dismiss];
    }];
}


@end
