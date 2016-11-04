//
//  RefreshTableViewController.m
//  ThailandGo
//
//  Created by Daniel on 15/10/8.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "RefreshTableViewController.h"
#import <MJRefresh.h>


@interface RefreshTableViewController ()
{
    UIView *view ;
    UIImageView *backgroundImg;
    UILabel *titleLabel ;
}

@end

@implementation RefreshTableViewController



- (void)setMJrefreshHeader:(dispatch_block_t)block{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    self.refreshTableView.mj_header = header;
    
}

- (void)setAnimationMJrefreshHeader:(dispatch_block_t)block{
    self.refreshTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    
}

- (void)setMJrefreshFooter:(dispatch_block_t)block{
    
    self.refreshTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (block) {
            block();
        }
    }];
    // 设置了底部inset
    self.refreshTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    // 忽略掉底部inset
    self.refreshTableView.mj_footer.ignoredScrollViewContentInsetBottom = 30;
    
    
    
}
- (void)endHeaderRefresh{
    
    [self.refreshTableView.mj_header endRefreshing];
}

- (void)endFooterRefresh{
    
    [self.refreshTableView.mj_footer endRefreshing];
    
}

- (void)endRefresh{
    
    [self endHeaderRefresh];
    [self endFooterRefresh];
}

- (void)hidenFooterView{
    
    [self.refreshTableView.mj_footer endRefreshingWithNoMoreData];

//    self.refreshTableView.mj_footer.hidden = YES;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.totalDataAry = [NSMutableArray array];
    self.refreshTableView.tableFooterView = [UIView new];
    
    self.currentPage = 1;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)checkshowNoData{
    
    
    if (self.totalDataAry.count == 0) {
        
        
    }else{
        [view removeFromSuperview];
        return;
    }
    
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:self.refreshTableView.frame];
        view.backgroundColor = [UIColor whiteColor];
        
        backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 128, 128)];
        backgroundImg.image = [UIImage imageNamed:@"discount_empty.png"];
        backgroundImg.center = CGPointMake(view.center.x, view.center.y-100);
        [view addSubview:backgroundImg];
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
        titleLabel.center = CGPointMake(view.center.x, backgroundImg.center.y+backgroundImg.frame.size.height);
        titleLabel.text = @"您还没有优惠券";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor grayColor];
        [view addSubview:titleLabel];

    }
    
    
    
    [self.refreshTableView addSubview:view];
    
    
    
    
}

- (void)beginFresh{
    
    [self.refreshTableView.mj_header beginRefreshing];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
