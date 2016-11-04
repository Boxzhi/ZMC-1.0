//
//  BasicViewController.m
//  ThailandGo
//
//  Created by Daniel on 15/9/28.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "BasicViewController.h"
#import "AppDelegate.h"
//#import "HomeViewController.h"
#import "ZMCLoginViewController.h"
//#import "BoardAndLineButton.h"

#import "UIViewController+Category.h"
//#import "CallServiceVC.h"
//#import "OrderListViewController.h"
//#import "MyDiscountVC.h"
//#import "ComplaintsSuggestionsVC.h"
//#import "RechargeVC.h"
//#import "GoodsDetailsViewController.h"


@interface BasicViewController () {
//    UIView *view ;
//    UIImageView *backgroundImg;
//    UILabel *titleLabel ;
//    BoardAndLineButton *button;
}

@end

@implementation BasicViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setTabBarHiddenAction];
    [self showNavBar];
    [[WLNetworkErrorView shared] networkErrorRemove];
 
}

#pragma mark - 自动隐藏底部tabbar
-(void)setTabBarHiddenAction
{
//    BasicViewController *control=(BasicViewController *)[self.navigationController.viewControllers firstObject];
//    if (![control isKindOfClass:[BasicViewController class]]) {
//        return;
//    }
//
//    if (control == self) {
//        [UITabbarCommonViewController setTabbarViewShow];
//    }else{
//        [UITabbarCommonViewController setTabbarViewHidden];
//    }

}

-(void)showNavBar{
    
//    BasicViewController *control=(BasicViewController *)[self.navigationController.viewControllers firstObject];
//    
//    if (![control isKindOfClass:[BasicViewController class]]) {
//        return;
//    }
//
//    
////    if (control != [HomeViewController class]) {
//        self.navigationController.navigationBar.barTintColor = ORANGE_COLOR;
////    }else{
////        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
////    }
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:WHITE_COLOR,NSForegroundColorAttributeName,nil]];
//    
//    
//    
//    
////    if (control == self) {
////        self.navigationController.navigationBar.hidden = YES;
////        
////    }else{
////        self.navigationController.navigationBar.hidden = NO;
////    }
//    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    //返回按钮
//    [self setTheBackItemButton];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }

//    if ([UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
//        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
//        [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName : [UIColor whiteColor]}];
//        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:(51) / 255.f green:(171) / 255.f blue:(160) / 255.f alpha:1.f]];
//        [[UINavigationBar appearance] setTranslucent:NO];
//    }
    
    
//    if(IOS7_OR_LATER){
////        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//
////            self.edgesForExtendedLayout = UIRectEdgeNone;
//
//
//    }
    
    if (IOS7){
        /**
         *  当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt。
         */
//        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
//        self.modalPresentationCapturesStatusBarAppearance = NO;
        
    }
    
    self.view.backgroundColor =MAIN_BALCOLOR;

    
    
    // Do any additional setup after loading the view.
}



#pragma mark 定义返回按钮
/**
 *   @pragma返回按钮
 */
- (void)setTheBackItemButton
{
    UIImage* backImg;
    //自定义返回按钮
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
//        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        
            
            if ([self.navigationController.viewControllers count]>1) {
                UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
                backButton.frame = CGRectMake(0.0, 0.0, 40.0, 27.0);
                [backButton setImage:[UIImage imageNamed:@"navBar_BackLeft"] forState:UIControlStateNormal];
                [backButton setImage:[UIImage imageNamed:@"navBar_BackLeft"] forState:UIControlStateSelected];
                [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
                UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
                temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
                self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
            }
            
                    
    }else{
        backImg=[[UIImage imageNamed:@"navBar_Back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 0)resizingMode:UIImageResizingModeStretch];
        UIBarButtonItem* backItem=[[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:self action:nil];
        
        [backItem setBackButtonBackgroundImage:backImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        backItem.enabled=YES;
        self.navigationItem.backBarButtonItem = backItem;
    }
    
}
-(void)backAction
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 弹出登陆页面
-(void)presentLoginVCAction
{
    
    ZMCLoginViewController *loginVc = [ZMCLoginViewController shared];
    [self presentViewController:loginVc animated:YES completion:nil];
    
//    if (self.presentingViewController) {
//        [self presentViewController:[ZMCLoginViewController navigationControllerContainSelf] animated:YES completion:nil];
//    }else{
//        if (self.tabbarController) {
//            [self.tabbarController presentViewController:[ZMCLoginViewController navigationControllerContainSelf] animated:YES completion:nil];
//        }else{
//            [self presentViewController:[ZMCLoginViewController navigationControllerContainSelf] animated:YES completion:nil];
//        }
//    }
    
}





@end
