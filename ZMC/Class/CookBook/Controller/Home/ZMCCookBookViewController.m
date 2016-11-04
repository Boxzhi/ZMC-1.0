//
//  ZMCCookBookViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "ZMCCookBookViewController.h"
#import "ZMCCookBookTVCell.h"

#import "ZMCPopView.h"
#import "ZMCMyMenuViewController.h"
#import "ZMCShareMenuViewController.h"

#import <WMPageController.h>
#import "ZMCBottomViewController.h"
#import "ZMCBottomSecondViewController.h"
#import "ZMCBottomThirdViewController.h"
#import "ZMCBottomFourthViewController.h"
#import "ZMCBottomFifthViewController.h"
#import "ZMCBottomSixthViewController.h"
#import "ZMCBottomSeventhViewController.h"
#import "ZMCBottomEighthViewController.h"

#import "CookBookNetwork.h"
#import "CookBookCategoryModel.h"
#import "ZMCParticipateViewController.h"
#import "ZMCSearchViewController.h"
#import "XTPopView.h"


@interface ZMCCookBookViewController ()<selectIndexPathDelegate>
{
    UIButton *_bgButton;
    XTPopView *_popView;
    NSArray *_menuItems;
    NSMutableArray *_itemArray;
    NSMutableArray *_vcArray;
    NSArray *_viewControllers;
    
    NSArray *_modelsArray;
    
    NSMutableArray *_cateIDArray;
    
//    MBProgressHUD * HUD;
}

@property (nonatomic, strong) WMPageController *pageController;

@end

@implementation ZMCCookBookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemArray = [[NSMutableArray alloc] init];
    _vcArray = [[NSMutableArray alloc] init];
    _cateIDArray = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = @"菜谱";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(treatButton:) title:@"宴客"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(clickToSearch) title:nil];
    
    _menuItems = [NSArray arrayWithObjects:@"分享菜单", @"我的菜单",@"我参加的", nil];
    _viewControllers = @[[ZMCBottomViewController class],[ZMCBottomSecondViewController class],[ZMCBottomThirdViewController class],[ZMCBottomFourthViewController class],[ZMCBottomFifthViewController class],[ZMCBottomSixthViewController class],[ZMCBottomSeventhViewController class],[ZMCBottomEighthViewController class]];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self sendRequestForCategories];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [HYBNetworking cancelRequestWithURL:@"http://115.159.227.219:8088/fanfou-api/cookbook/cate"];
}

//发送请求，获取所有的分类
- (void)sendRequestForCategories
{
//    [USER_DEFAULT removeObjectForKey:@"cateIDs"];
    [CookBookNetwork requestCookBookCategoryComplete:^(NSArray *array) {
        _modelsArray = array;
        
        for (int i =0 ; i < _modelsArray.count; i ++ ) {
            CookBookCategoryModel *model = _modelsArray[i];
            [_itemArray addObject:model.name];
            [_vcArray addObject:_viewControllers[i]];
            
            [_cateIDArray addObject:model.ID];
//            [SVProgressHUD dismiss];
        }
        [self addChildViewController:self.pageController];
        [self.view addSubview:self.pageController.view];
        
        [USER_DEFAULT setObject:_cateIDArray forKey:@"cateIDs"];
        [USER_DEFAULT synchronize];
        
    }];
}

- (WMPageController *)pageController
{
    if (!_pageController) {
        _pageController = [[WMPageController alloc] initWithViewControllerClasses:_vcArray andTheirTitles:_itemArray];
        //    pageController.menuItemWidth = 60;
        _pageController.menuHeight = 40;
        _pageController.titleColorNormal = StringMiddleColor;
        _pageController.titleColorSelected = ThemeGreenColor;
        _pageController.selectIndex = 0;
        _pageController.menuViewStyle = WMMenuViewStyleLine;
        _pageController.titleSizeSelected = _pageController.titleSizeNormal;
        _pageController.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;

    }
    
    return _pageController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 点击导航栏左侧按钮，弹出view
- (void)treatButton:(UIButton *)sender {
    
    UIBarButtonItem *btnItem = self.navigationItem.leftBarButtonItem;
    UIButton *btn = btnItem.customView;
    CGPoint point = CGPointMake(btn.center.x, btn.frame.origin.y + 60);
    
    _popView = [[XTPopView alloc] initWithOrigin:point Width:120 Height:40 * 3 Type:XTTypeOfUpLeft Color:UIColorFromRGB(0x383838)];
    _popView.dataArray = @[@"分享菜谱", @"我的菜单", @"我参加的"];
    _popView.images = @[@"fxcp", @"wdcd", @"wcyd"];
    _popView.fontSize = 15;
    _popView.row_height = 40;
    _popView.titleTextColor = [UIColor whiteColor];
    _popView.delegate = self;
    [_popView popView];
    /*
    if (!_bgButton) {
        _bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgButton.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _bgButton.backgroundColor = [UIColor blackColor];
        _bgButton.alpha = 0.2;
        [self.view addSubview:_bgButton];
        [_bgButton addTarget:self action:@selector(clickToDeselect:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (!_popView) {
        _popView = [[ZMCPopView alloc] initWithFrame:CGRectMake(10, 0, 90, 145) andButtonTitleArray:@[@"分享菜谱", @"我的菜单", @"我参加的"]];

        _popView.delegate = self;
        [self.view addSubview:_popView];
    }
     */
}

#pragma mark - 点击搜索
- (void)clickToSearch{
    
    ZMCSearchViewController *searchVC = [[ZMCSearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];

}


#pragma mark- 点击背景的阴影button，取消选择
//- (void)clickToDeselect:(UIButton *)button
//{
//    [self removeView];
//}

#pragma mark- 点击弹框上的某个按钮，调用的协议方法
- (void)selectIndexPathRow:(NSInteger)index
{
    if (TOKEN) {
        
        switch (index) {
            case 0:
            {
                [_popView dismiss];
                
                ZMCShareMenuViewController *shareVc = [[ZMCShareMenuViewController alloc] init];
                shareVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:shareVc animated:YES];
            }
                break;
            case 1:
            {
                [_popView dismiss];
                ZMCMyMenuViewController *myVc = [[ZMCMyMenuViewController alloc] init];
                myVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:myVc animated:YES];
            }
                break;
            case 2:
            {
                [_popView dismiss];
                ZMCParticipateViewController *partVc = [[ZMCParticipateViewController alloc] init];
                partVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:partVc animated:YES];
                
            }
                break;
            default:
                break;
        }
        
    }else{
        [_popView dismiss];
        [self presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
    }
}
//- (void)popView:(ZMCPopView *)popView didSelectButtonWithTag:(NSInteger)tag
//{
//    [self removeView];
//    if (TOKEN) {
//        if (tag == 100) {
//            ZMCShareMenuViewController *shareVC = [[ZMCShareMenuViewController alloc] init];
//            shareVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:shareVC animated:YES];
//        }
//        if (tag == 101) {
//            ZMCMyMenuViewController *myVC = [[ZMCMyMenuViewController alloc] init];
//            myVC.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:myVC animated:YES];
//        }
//        if (tag == 102) {
//            ZMCParticipateViewController *partVc = [[ZMCParticipateViewController alloc] init];
//            partVc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:partVc animated:YES];
//        }
//    }else{
//        
//        [self presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
//    }
//}
//- (void)removeView
//{
//    [_popView removeFromSuperview];
//    _popView = nil;
//    [_bgButton removeFromSuperview];
//    _bgButton = nil;
//}


@end
