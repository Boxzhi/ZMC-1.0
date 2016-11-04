//
//  ZMCMyTableViewController.m
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyTableViewController.h"
#import "ZMCMyHeaderView.h"
#import "ZMCsettingController.h"
#import "ZMCPayViewController.h"
#import "ZMCBalanceTableViewController.h"
#import "ZMCCouponViewController.h"
#import "ZMCCollectionViewController.h"
#import "ZMCHealthyViewController.h"
#import "ZMCAboutViewController.h"
#import "ZMCPaymentsViewController.h"
#import "ZMCMyintegralViewController.h"
#import "ZMCMyorderViewController.h"
#import <Masonry.h>
#import "ZMCAFManegeritem.h"
#import "ZMCMyHeaderItem.h"
#import "ToolDefine.h"
#import "BasicViewController.h"
#import "ZMCRegisterViewController.h"


@interface ZMCMyTableViewController()

@property (nonatomic, weak) ZMCMyHeaderView *headerView;
// 点击登录注册
@property (nonatomic, weak) UIButton *loginBtn;

// 昵称
@property (nonatomic, weak) UILabel *namelabel;
// 会员图标
@property (nonatomic, weak) UIImageView *medlImage;
//// 签名
//@property (nonatomic, weak) UILabel *siglabel;

@end



static ZMCMyTableViewController *myTableVC = nil;
@implementation ZMCMyTableViewController{
    UIView *backView;
}
+ (ZMCMyTableViewController *)shared{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myTableVC = [[ZMCMyTableViewController alloc] init];
    });
    return myTableVC;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // 设置导航条
    [self setNavigationBar];
    
    self.tableView.backgroundColor = [UIColor redColor];
    
    // 第0组
    [self setupGrup0];
    
    // 第1组
    [self setupGrup1];
    
    // 第2组
    [self setupGrup2];

    // 设置头像所在的View
    [self setHeardView];
    
    
    [_loginBtn addTarget:self action:@selector(ClickLogin) forControlEvents:UIControlEventTouchUpInside];
    
    // 加载数据
    [self loadData];

    // 添加手势
    [self getTapGesture];
    
    // 去掉上下滚动条
    self.tableView.showsVerticalScrollIndicator = NO;

    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorColor = RGB(241, 241, 241);

    // 禁止掉额外滚动区域
    self.tableView.bounces = NO;
    
    Check_Login
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!TOKEN) {
        self.loginBtn.hidden = NO;
        self.headerView.nameLabel.hidden = YES;
        self.headerView.memberImage.hidden = YES;
        self.headerView.autographLabel.hidden = YES;
        self.headerView.balanceLabel.text = @"¥ 0";
        self.headerView.frozenLabel.text = @"¥ 0.00";
        self.headerView.pointsLabel.text = @"0";
        self.headerView.myImageView.image = [UIImage imageNamed:@"my-touxiang"];
    }else{
        self.loginBtn.hidden = YES;
        self.headerView.nameLabel.hidden = NO;
        self.headerView.memberImage.hidden = NO;
        self.headerView.autographLabel.hidden = NO;
    }
    [self loadData];

}

#pragma mark - 弹出登录
- (void)presentLoginVCAction
{
//    [USER_DEFAULT removeObjectForKey:@"access_token"];
//    [USER_DEFAULT removeObjectForKey:@"refresh_token"];
//    [USER_DEFAULT removeObjectForKey:@"expire_time"];
//    [USER_DEFAULT removeObjectForKey:@"login_time"];
//
//    [USER_DEFAULT setObject:@"0" forKey:ISLOGIN];

    [self presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
}

- (void)presentRegisterVCAction
{
    [self presentViewController:[ZMCRegisterViewController shared] animated:YES completion:nil];
}


#pragma mark - 加载数据
- (void)loadData{
    [ZMCAFManegeritem setVipinfo:^(NSDictionary *vipResult) {

        ZMCMyHeaderItem *headitem = [ZMCMyHeaderItem mj_objectWithKeyValues:vipResult];
        self.headerView.item = headitem;
        
    }];
 
        [self.tableView reloadData];
}

#pragma mark - 添加手势
- (void)getTapGesture{
    
    // 给余额积分添加点击手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(balanceTap)];
    [self.headerView.balanceView addGestureRecognizer:tap1];
    // 我的积分
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(integralTap)];
    [self.headerView.myIntegralView addGestureRecognizer:tap2];
    // 待配送
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adistribution)];
    [self.headerView.AdistributionView addGestureRecognizer:tap3];
    // 配送中
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bdistribution)];
    [self.headerView.BdistributionView addGestureRecognizer:tap4];
    // 已收货
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cdistribution)];
    [self.headerView.CdistributionView addGestureRecognizer:tap5];
    // 我的全部订单
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alldistribution)];
    [self.headerView.allOrder addGestureRecognizer:tap6];

}


#pragma mark - 头像昵称所在的View
- (void)setHeardView{
    ZMCMyHeaderView *headerView = [ZMCMyHeaderView myHeaderView];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    self.loginBtn = headerView.loginBtn;
    headerView.autoresizingMask = UIViewAutoresizingNone;
}


#pragma mark - 设置NavigationBar
-(void)setNavigationBar{
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"setting"] highImage:[UIImage imageNamed:@"setting"] target:self action:@selector(setting) title:nil];
}

#pragma mark - 点击注册登录按钮
- (void)ClickLogin{
    ZMCFunc;
    [self presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
}


#pragma mark - 余额积分点击跳转
- (void)balanceTap{
    if (!TOKEN) {
        [self ClickLogin];
    }else{
        ZMCPaymentsViewController *balanceVc = [[ZMCPaymentsViewController alloc] init];
        [self.navigationController pushViewController:balanceVc animated:YES];
    }
}
- (void)integralTap{
    if (!TOKEN) {
        [self ClickLogin];
    }else{
        ZMCMyintegralViewController *integralVc = [[ZMCMyintegralViewController alloc] init];
        
        [self.navigationController pushViewController:integralVc animated:YES];
    }
}

#pragma mark - 我的订单点击跳转
- (void)alldistribution{
    [self distribution:0];
}
- (void)adistribution{
    [self distribution:1];
}
- (void)bdistribution{
    [self distribution:2];
}
- (void)cdistribution{
    [self distribution:4];
}

- (void)distribution:(int)index{
    if (!TOKEN) {
        [self ClickLogin];
    }else{
        ZMCMyorderViewController *myOrderVc = [[ZMCMyorderViewController alloc] init];
        myOrderVc.selectedTag = index;
        [self.navigationController pushViewController:myOrderVc animated:YES];
    }
}



#pragma mark - 点击跳转到设置界面
-(void)setting{
    if (!TOKEN) {
        [self ClickLogin];
    }else{
        
        ZMCsettingController *settingVc = [[ZMCsettingController alloc] init];
        settingVc.hidesBottomBarWhenPushed = YES;
        settingVc.avatar = self.headerView.myImageView.image;
        settingVc.nick_name = self.headerView.nameLabel.text;
        settingVc.signature = self.headerView.autographLabel.text;
        [self.navigationController pushViewController:settingVc animated:YES];
    }
}



#pragma mark - 下面的cell
// 第0组
- (void)setupGrup0{
    // 第0组
    NSMutableArray *items = [NSMutableArray array];
    
    ZMCMyArrowItem *item0 = [ZMCMyArrowItem itemWithImage:[UIImage imageNamed:@"money"] title:@"我要充值"];
    [items addObject:item0];
    __weak typeof(self) weakSelf = self;
    item0.operationBlock = ^(NSIndexPath *indexPath){
        
        // 点击跳转
        if (!TOKEN) {
            [self ClickLogin];
        }else{
            ZMCPayViewController *payVc = [[ZMCPayViewController alloc] init];
            payVc.actbalance = self.headerView.balanceLabel.text;
            [weakSelf.navigationController pushViewController:payVc animated:YES];
        }
    };
    
    ZMCMyArrowItem *item1 = [ZMCMyArrowItem itemWithImage:[UIImage imageNamed:@"shouzhi"] title:@"我的收支"];
    [items addObject:item1];
    item1.operationBlock = ^(NSIndexPath *indexPath){
        // 点击跳转 
        if (!TOKEN) {
            [self ClickLogin];
        }else{
            ZMCBalanceTableViewController *balanceVc = [[ZMCBalanceTableViewController alloc] init];
        
            [weakSelf.navigationController pushViewController:balanceVc animated:YES];
        }
    };
    
    ZMCMyArrowItem *item2 = [ZMCMyArrowItem itemWithImage:[UIImage imageNamed:@"sale"] title:@"我的优惠券"];
    [items addObject:item2];
    item2.operationBlock = ^(NSIndexPath *indexPath){
        // 点击跳转
        if (!TOKEN) {
            [self ClickLogin];
        }else{
            ZMCCouponViewController *couponVc = [[ZMCCouponViewController alloc] init];
            [weakSelf.navigationController pushViewController:couponVc animated:YES];
        }
    };

    
    ZMCMyArrowItem *item3 = [ZMCMyArrowItem itemWithImage:[UIImage imageNamed:@"favorites"] title:@"我的收藏"];
    [items addObject:item3];
    item3.operationBlock = ^(NSIndexPath *indexPath){
        // 点击跳转
        if (!TOKEN) {
            [self ClickLogin];
        }else{
            ZMCCollectionViewController *collectionVc = [[ZMCCollectionViewController alloc] init];
            [weakSelf.navigationController pushViewController:collectionVc animated:YES];
        }
    };

    // 添加组模型
    ZMCMyGroupItem *group = [ZMCMyGroupItem groupItem:items];
    [self.groups addObject:group];
}

// 第一组
- (void)setupGrup1{
    // 第一组
    NSMutableArray *items = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    ZMCMyArrowItem *item0 = [ZMCMyArrowItem itemWithImage:[UIImage imageNamed:@"health"] title:@"健康知识"];
    [items addObject:item0];
    item0.operationBlock = ^(NSIndexPath *indexPath){
        // 点击跳转
        ZMCHealthyViewController *healthyVc = [[ZMCHealthyViewController alloc] init];
        [weakSelf.navigationController pushViewController:healthyVc animated:YES];
        
    };

    // 添加组模型
    ZMCMyGroupItem *group = [ZMCMyGroupItem groupItem:items];
    [self.groups addObject:group];
}
// 第二组
- (void)setupGrup2{
    NSMutableArray *items = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    ZMCMyArrowItem *item0 = [ZMCMyArrowItem itemWithImage:[UIImage imageNamed:@"us"] title:@"关于怎么吃"];
    [items addObject:item0];
    item0.operationBlock = ^(NSIndexPath *indexPath){
        // 点击跳转
        ZMCAboutViewController *aboutVc = [[ZMCAboutViewController alloc] init];
        [weakSelf.navigationController pushViewController:aboutVc animated:YES];
        
    };
    
    ZMCMyItem *item1 = [ZMCMyItem itemWithImage:[UIImage imageNamed:@"call"] title:@"联系我们"];
    item1.subTitle = @"4008272399";
    [items addObject:item1];
    item1.operationBlock = ^(NSIndexPath *indexPath){
        // 点击跳转
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"4008272399"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    };
    
    // 添加组模型
    ZMCMyGroupItem *group = [ZMCMyGroupItem groupItem:items];
    [self.groups addObject:group];
}

@end
