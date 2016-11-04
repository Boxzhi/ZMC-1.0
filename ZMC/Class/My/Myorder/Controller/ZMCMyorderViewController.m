//
//  ZMCMyorderViewController.m
//  ZMC
//
//  Created by Will on 16/5/3.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyorderViewController.h"
#import "ZMCAllViewController.h"
#import "ZMCShippingViewController.h"
#import "ZMCGoodsViewController.h"
#import "ZMCEvaluationViewController.h"
#import "ZMCCompleteViewController.h"
#import <WMPageController.h>

@interface ZMCMyorderViewController ()

@property (nonatomic, strong) NSArray *viewControllers;

@end

@implementation ZMCMyorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的订单";

    self.selectIndex = self.selectedTag;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuHeight = 40;
        self.menuViewStyle = WMMenuViewStyleLine;
        self.titleColorNormal = StringMiddleColor;
        self.titleColorSelected = ThemeGreenColor;
        self.titleSizeSelected = self.titleSizeNormal;
        self.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    }
    return self;
}

- (NSArray *)titles {
    return @[@"全部", @"待配送",@"配送中", @"待收货", @"已完成"];
}

#pragma mark - WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titles.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
            ZMCLog(@"%ld",(long)index);
            break;
        case 0: {
            ZMCAllViewController *vc = [[ZMCAllViewController alloc] init];
            return vc;
            
        }
            case 1:
        {
            ZMCShippingViewController *vc = [[ZMCShippingViewController alloc] init];
            return vc;
            
        }
            case 2:
        {
            ZMCGoodsViewController *vc = [[ZMCGoodsViewController alloc] init];
            return vc;
            
        }   case 3: {
            ZMCEvaluationViewController *vc = [[ZMCEvaluationViewController alloc] init];
            return vc;
        }
            case 4:{
            ZMCCompleteViewController *vc = [[ZMCCompleteViewController alloc] init];
                return vc;
        }
        default: {
            return nil;
        }
            break;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.titles[index];
}


@end
