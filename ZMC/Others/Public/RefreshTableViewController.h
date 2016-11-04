//
//  RefreshTableViewController.h
//  ThailandGo
//
//  Created by Daniel on 15/10/8.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import "BasicViewController.h"

#import <CYLTableViewPlaceHolder/CYLTableViewPlaceHolder.h>
#import "WeChatStylePlaceHolder.h"
@interface RefreshTableViewController : BasicViewController<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,assign)   NSInteger				currentPage;

@property(nonatomic,assign)   NSInteger				totalPage;

@property(nonatomic,assign)   NSInteger				totalCount;

@property(nonatomic,assign)   BOOL				    isLastPage;

@property(nonatomic,assign)   BOOL				    reloading;

@property(nonatomic,assign)   BOOL				    isLoading;

@property(nonatomic,assign)   BOOL				    isFromHead;


@property (nonatomic,strong) UITableView *refreshTableView;  //列表

@property (nonatomic,strong) NSMutableArray *totalDataAry; //数据源

//- (void)startRefreshLoading;
//
//- (void)startMoreAnimation:(BOOL)animating;
//
//- (void)dataSourceDidFinishLoadingNewData;
//
//- (void)reloadTableViewDataSource;
//
//- (BOOL)hasMore;
//
//
//- (void)refreshData;
//
//- (void)refreshDataComplete;
//
//- (void)loadMoreData;
//
//- (void)loadMoreDataComplete;

#pragma  适合自己项目的方法


- (void)setMJrefreshHeader:(dispatch_block_t)block;

- (void)setAnimationMJrefreshHeader:(dispatch_block_t)block;

- (void)setMJrefreshFooter:(dispatch_block_t)block;

- (void)endHeaderRefresh;

- (void)endFooterRefresh;

- (void)beginFresh;


/**
 *  在reloadData之后调用
 */
- (void)endRefresh;

/**
 *  在reloadData  endRefresh之后调用
 */
- (void)hidenFooterView;

/**
 *  是否需要填充无数据情况
 */
- (void)checkshowNoData;

@end
