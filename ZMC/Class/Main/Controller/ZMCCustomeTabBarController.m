//
//  ZMCCustomeTabBarController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "ZMCCustomeTabBarController.h"
#import "ZMCBasketViewController.h"
#import "ZMCMarketViewController.h"
#import "ZMCCookBookViewController.h"
#import "ZMCHomePageViewController.h"
#import "ZMCMyTableViewController.h"
#import "ZMCNavigationController.h"


@interface ZMCCustomeTabBarController ()

@end

@implementation ZMCCustomeTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                ZMCLog(@"WIFI网络");
                [USER_DEFAULT setObject:@"YES" forKey:@"isReachable_client"];
                [USER_DEFAULT synchronize];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                ZMCLog(@"手机网络");
                [USER_DEFAULT setObject:@"YES" forKey:@"isReachable_client"];
                [USER_DEFAULT synchronize];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                ZMCLog(@"没有网络");
                [USER_DEFAULT setObject:@"NO" forKey:@"isReachable_client"];
                [USER_DEFAULT synchronize];
                ALERT_MSG(@"提示", @"网络不给力，请检查网络设置");

                break;
                
            case AFNetworkReachabilityStatusUnknown:
                ZMCLog(@"未知网络");
                [USER_DEFAULT setObject:@"YES" forKey:@"isReachable_client"];
                [USER_DEFAULT synchronize];
                
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
    
    
    // 设置tabbar为不透明
    self.tabBar.translucent = NO;
    
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    [self loadTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // 去掉tabBar顶部的线
    
    
    [[self.tabBar valueForKey:@"shadowView"] removeFromSuperview];
}



#pragma mark- 设置底部的tabbar
- (void)loadTabbar
{
    
    ZMCHomePageViewController *homeVC = [[ZMCHomePageViewController alloc] init];
    ZMCNavigationController *homeNavi = [[ZMCNavigationController alloc] initWithRootViewController:homeVC];
    homeNavi.tabBarItem.image = [UIImage imageNamed:@"home"];
    homeNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"house_pre"];
    homeNavi.tabBarItem.title = @"首页";

    
    ZMCCookBookViewController *cookVC = [[ZMCCookBookViewController alloc] init];
    ZMCNavigationController *cookNavi = [[ZMCNavigationController alloc] initWithRootViewController:cookVC];
    cookNavi.tabBarItem.image = [UIImage imageNamed:@"caipu"];
    cookNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"caipu_pre"];
    cookNavi.tabBarItem.title = @"菜谱";
    
    
    ZMCMarketViewController *wanderVC = [[ZMCMarketViewController alloc] init];
    ZMCNavigationController *wanderNavi = [[ZMCNavigationController alloc] initWithRootViewController:wanderVC];
    wanderNavi.tabBarItem.image = [UIImage imageNamed:@"shop"];
    wanderNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"shop_pre"];
    wanderNavi.tabBarItem.title = @"逛菜场";
//    [self setTabBarItem:wanderNavi.tabBarItem Title:@"逛菜场" withTitleSize:14.0 andFoneName:@"Marion-Italic" selectedImage:@"shop_pre" withTitleColor:UIColorFromRGB(0xf4f4f4) unselectedImage:@"shop" withTitleColor:ThemeGreenColor];
    
    ZMCBasketViewController *basketVC = [[ZMCBasketViewController alloc] init];
    ZMCNavigationController *basketNavi = [[ZMCNavigationController alloc] initWithRootViewController:basketVC];
    basketNavi.tabBarItem.image = [UIImage imageNamed:@"buy"];
    basketNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"buy_pre"];
    basketNavi.tabBarItem.title = @"菜篮子";
    
    
    ZMCMyTableViewController *myVC = [ZMCMyTableViewController shared];
    myVC.view.backgroundColor = [UIColor lightGrayColor];
    ZMCNavigationController *myNavi = [[ZMCNavigationController alloc] initWithRootViewController:myVC];
    myNavi.tabBarItem.image = [UIImage imageNamed:@"user"];
    myNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"user_pre"];
    myNavi.tabBarItem.title = @"我的";
    
    
    self.viewControllers = @[homeNavi,cookNavi,wanderNavi,basketNavi,myNavi];
    self.selectedIndex = 0;

    self.tabBar.tintColor = ThemeGreenColor;
}


//- (void)setTabBarItem:(UITabBarItem *)tabbarItem
//                Title:(NSString *)title
//        withTitleSize:(CGFloat)size
//          andFoneName:(NSString *)foneName
//        selectedImage:(NSString *)selectedImage
//       withTitleColor:(UIColor *)selectColor
//      unselectedImage:(NSString *)unselectedImage
//       withTitleColor:(UIColor *)unselectColor{
//    
//    //设置图片
//    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    
//    //未选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
//    
//    //选中字体颜色
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
//}

//#pragma mark- 添加中间的按钮
//- (void)addCenterButtonWithImage:(UIImage *)buttonImage highlightImage:(UIImage *)highlightImage
//{
//    
//    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
//    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
//    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    button.layer.borderWidth = 4;
//    button.layer.borderColor = [UIColor whiteColor].CGColor;
//    button.layer.cornerRadius = 34.5;
//    button.layer.masksToBounds = YES;
//    
//    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
//    if (heightDifference < 0)
//        button.center = self.tabBar.center;
//    else
//    {
//        CGPoint center = self.tabBar.center;
//        center.y = center.y - heightDifference/2.0 -kScreenHeight +49;
//        button.center = center;
//    }
//    button.tag = 200;
//    [self.tabBar addSubview:button];
//}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    UIButton *button = [self.tabBar viewWithTag:200];
    if (item.title.length == 0) {
        button.layer.borderColor = [UIColor colorWithRed:92/255.0 green:211/255.0 blue:103/255.0 alpha:1].CGColor;
        
    } else {
        button.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

@end
