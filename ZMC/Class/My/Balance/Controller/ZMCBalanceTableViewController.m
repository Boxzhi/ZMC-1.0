//
//  ZMCBalanceTableViewController.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCBalanceTableViewController.h"
#import "ZMCBalanceTableViewCell.h"
#import "ZMCBalanceManger.h"
#import "ZMCBalanceItem.h"
#import "ZMCRefreshHeader.h"
#import "ZMCRefreshFooter.h"


static NSString * const ID = @"Balancecell";
@interface ZMCBalanceTableViewController ()<UITableViewDelegate, UITableViewDataSource, WeChatStylePlaceHolderDelegate>

//  模型数组
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation ZMCBalanceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收支";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCBalanceTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    // 去掉上下滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    // 隐藏cell间的黑线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    

    self.tableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_footer = [ZMCRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self loadNewData];
    
}


- (void)loadNewData{
    _currentPage = 1;
    
    [self loadDataPage:_currentPage];
}

- (void)loadMoreData{
    _currentPage += 1;
    
    [self loadDataPage:_currentPage];
}


- (void)loadDataPage:(NSInteger)page{
    
    [ZMCBalanceManger getbillPage:page Page_size:25 Result:^(NSDictionary *result) {
        
        [ZMCBalanceItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"description_":@"description"};
        }];
        if (_currentPage == 1) {
            
            _listArray = [ZMCBalanceItem mj_objectArrayWithKeyValuesArray:result[@"result"][@"data"][0][@"list"]];
        }else{
            NSArray *arr = [ZMCBalanceItem mj_objectArrayWithKeyValuesArray:result[@"result"][@"data"][0][@"list"]];
            [_listArray addObjectsFromArray:arr];
        }
        
        [self.tableView cyl_reloadData];
        
        [self.tableView.mj_header endRefreshing];
        if ([result[@"result"][@"total_pages"] integerValue] == _currentPage) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
    
}



#pragma mark - Tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZMCBalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = _listArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"无收支明细";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}



@end
