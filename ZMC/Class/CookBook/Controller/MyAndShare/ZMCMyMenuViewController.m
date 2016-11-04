//
//  MyMenuViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyMenuViewController.h"
#import "ZMCMenuTableViewCell.h"
#import "ZMCMenuDetailViewController.h"
#import "ZMCThird.h"
#import "ZMCMyListItem.h"
#import "ZMCRefreshHeader.h"


@interface ZMCMyMenuViewController ()<UITableViewDelegate,UITableViewDataSource, WeChatStylePlaceHolderDelegate>

@property (nonatomic, strong) UITableView *menuTableView;
/**
 *  菜单列表数组
 */
@property (nonatomic, strong) NSArray *listArray;
@end

static NSString *cellReuseId = @"cell";
@implementation ZMCMyMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的菜单";
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    [self.view addSubview:self.menuTableView];
    
    [self loadData];
    
    self.menuTableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (UITableView *)menuTableView
{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64) style:UITableViewStylePlain];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_menuTableView registerNib:[UINib nibWithNibName:@"ZMCMenuTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    }
    return _menuTableView;
}

- (void)loadData{
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token)
    {
        NSString *urlStr = [NSString stringWithFormat:uCMyList, token, @1, @15];
        [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
            
            [ZMCMyListItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"list_id":@"id"};
            }];
            _listArray = [ZMCMyListItem mj_objectArrayWithKeyValuesArray:response[@"result"][@"data"]];
            [self.menuTableView cyl_reloadData];
            [self.menuTableView.mj_header endRefreshing];
            [SVProgressHUD dismiss];
        } fail:^(NSError *error) {
            ZMCLog(@"我的菜单列表获取失败");
        }];
    }];
     
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    cell.item = _listArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.selected = NO;
    });
    
    ZMCMenuDetailViewController *menuVC = [[ZMCMenuDetailViewController alloc] init];
    ZMCMyListItem *item = _listArray[indexPath.row];
    menuVC.detail_id = item.list_id;
    [self.navigationController pushViewController:menuVC animated:YES];
}



#pragma mark - 空数据占位图
- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.menuTableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"您还没有分享菜单";
    weChatStylePlaceHolder.content = @"快去分享菜谱到朋友圈吧~";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}



@end
