//
//  ZMCBottomSeventhViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/10.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCBottomSeventhViewController.h"
#import "CookBookNetwork.h"
#import "ZMCCookBookTVCell.h"
#import "BottomCookBookModel.h"
#import "ZMCCookBookDetailViewController.h"
#import "ZMCRefreshHeader.h"
#import "ZMCRefreshFooter.h"


@interface ZMCBottomSeventhViewController ()<UITableViewDelegate, UITableViewDataSource, WeChatStylePlaceHolderDelegate>
@property (nonatomic, strong) NSMutableArray *modelsArray;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UITableView *bottomTableView;
@end

static NSString *cellReuseId = @"CookBookCell";
@implementation ZMCBottomSeventhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    [self.view addSubview:self.bottomTableView];
    
    [self setupRefresh];
    
}

- (void)setupRefresh{
    self.bottomTableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.bottomTableView.mj_header beginRefreshing];
    self.bottomTableView.mj_footer = [ZMCRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self loadNewData];
//
//}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [self.bottomTableView.mj_header endRefreshing];
}

- (void)loadNewData{
    self.currentPage = 1;
    [self sendRequest];
}

- (void)loadMoreData{
    self.currentPage += 1;
    [self sendRequest];
}

- (void)sendRequest
{
    NSArray *cates = [USER_DEFAULT objectForKey:@"cateIDs"];
    
    
    [CookBookNetwork requestDishListWithCategory:cates[6] andPage:[NSNumber numberWithInteger:_currentPage] andPageSize:@15 andComplete:^(NSMutableDictionary *Dic) {
        if (_currentPage == 1) {
            self.modelsArray = [BottomCookBookModel mj_objectArrayWithKeyValuesArray:Dic[@"data"]];
        }else{
            NSArray *moreArray = [BottomCookBookModel mj_objectArrayWithKeyValuesArray:Dic[@"data"]];
            [self.modelsArray addObjectsFromArray:moreArray];
        }
        [_bottomTableView cyl_reloadData];
        [_bottomTableView.mj_header endRefreshing];
        if (_currentPage == [Dic[@"total_pages"] integerValue]) {
            [_bottomTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [_bottomTableView.mj_footer endRefreshing];
        }
        
        [SVProgressHUD dismiss];
    }];
}

- (UITableView *)bottomTableView
{
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -40 -64 -49) style:UITableViewStylePlain];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        _bottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _bottomTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [_bottomTableView registerNib:[UINib nibWithNibName:@"ZMCCookBookTVCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
        
    }
    return _bottomTableView;
}

#pragma mark- ------ tableView方法实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZMCCookBookTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    
    BottomCookBookModel *model = _modelsArray[indexPath.row];
    
    [cell.dishPic sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"caipu1"]];
    cell.dishName.text = model.name;
    cell.selectNum.text = [NSString stringWithFormat:@"已有%@人选择",model.selected_count];
    if (model.favourite_count != NULL) {
        cell.favouriteNum.text = [NSString stringWithFormat:@"%@人收藏",model.favourite_count];
    }else{
        cell.favouriteNum.text = @"0人收藏";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150;
}

/**
 *  点击菜谱某个菜跳转的方法
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BottomCookBookModel *model = _modelsArray[indexPath.row];
    
    ZMCCookBookDetailViewController *detailVC = [[ZMCCookBookDetailViewController alloc] init];
    detailVC.cookBookID = [model.ID longValue];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.bottomTableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"此分类下暂无菜品";
    weChatStylePlaceHolder.content = @"去别的分类看看吧~";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}


@end
