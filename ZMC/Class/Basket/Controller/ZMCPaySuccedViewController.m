//
//  ZMCPaySuccedViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCPaySuccedViewController.h"
#import "UIBarButtonItem+NavButton.h"
#import "OrderDetailVC.h"
#import "ZMCNavigationController.h"

@interface ZMCPaySuccedViewController ()<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, assign) BOOL isCanSideBack;

// 分享描述
@property (nonatomic, strong) NSString *share_desc;
// 分享图标
@property (nonatomic, strong) NSString *share_img;
// 分享链接
@property (nonatomic, strong) NSString *share_link;
// 分享标题
@property (nonatomic, strong) NSString *share_title;

- (IBAction)orderBtn:(UIButton *)sender;

@end

@implementation ZMCPaySuccedViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.isCanSideBack = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    [self getShareCoupon];
}

/**
 *  获取分享链接
 */
- (void)getShareCoupon{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *strUrl = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/order/share_coupon?access_token=%@&order_id=%@", token, self.order_id];
        
        [HYBNetworking getWithUrl:strUrl refreshCache:NO success:^(id response) {
            if ([response[@"err_code"] integerValue] == 0) {
            
                _share_title = response[@"result"][@"share_title"];
                _share_desc = response[@"result"][@"share_desc"];
                _share_img = response[@"result"][@"share_img"];
                _share_link = response[@"result"][@"share_link"];
                
            }

        } fail:^(NSError *error) {
            ZMCLog(@"%@", error);
        }];
    }];

}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self resetSideBack];
}
- (void)resetSideBack{
    self.isCanSideBack = YES;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.isCanSideBack;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"支付成功";
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"nav_back"] highImage:[UIImage imageNamed:@"nav_back"] target:self action:@selector(backAction) title:nil];
    
    self.infoLabel.text = [NSString stringWithFormat:@"您支付了 ¥%@   冻结金额 ¥%@",self.money,self.frozen];
    

//    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:@"点击查看详细信息" attributes:@{NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
//    _detailLabel.attributedText = content;
//    _detailLabel.userInteractionEnabled = YES;
}


-(void)backAction{
    //    NSLog(@"11");
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





//- (IBAction)clickToSeeDetail:(UITapGestureRecognizer *)sender {
//    ZMCLog(@"跳转到订单页面");
//}

- (IBAction)orderBtn:(UIButton *)sender {
    
    
    OrderDetailVC* viewController = [[OrderDetailVC alloc] initWithNibName:@"OrderDetailVC" bundle:nil];
//    viewController.orderDetailStatus = Order_PendingDelivery ;
    viewController.order_id = self.order_id;
    //    OrderList *tmpModel = self.totalDataAry[indexPath.section];
    //    viewController.orderDetailModel = tmpModel;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

/**
 *  分享领取优惠券
 */
- (IBAction)shareCoupon:(id)sender {
    
    HZZCustomShareView *shareCoupon = [HZZCustomShareView shareViewWithPresentedViewController:self items:@[UMShareToWechatSession, UMShareToWechatTimeline] title:_share_title content:_share_desc image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_share_img]]] urlResource:nil shareUrl:_share_link];
    
    [[UIApplication sharedApplication].keyWindow addSubview:shareCoupon];
    
}

@end
