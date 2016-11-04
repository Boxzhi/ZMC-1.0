//
//  ZMCNavigationController.m
//  ZMC
//
//  Created by Will on 16/4/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCNavigationController.h"
#import "ZMCPaySuccedViewController.h"

@interface ZMCNavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation ZMCNavigationController

+ (void)load
{
    // 获取整个应用的navigationBar
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 设置导航条标题
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navigationBar setTitleTextAttributes:titleAttr];
    
    navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.interactivePopGestureRecognizer.delegate = self;
}

//
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只有非根控制器,才需要设置返回按钮
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;

        viewController.navigationItem.leftBarButtonItem =  [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"nav_back"] highImage:nil target:self action:@selector(back) title:nil];
    }
    // 这个才是真正的跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
// 是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

- (void)handleNavigationTransition:(UIGestureRecognizer *)pan
{
    
}

@end
