//
//  SearchViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCSearchViewController.h"
#import "ZMCPopView.h"
#import "ZMCCookBookViewController.h"
#import "ZMCSearchResultViewController.h"
#import "HZZPopView.h"

@interface ZMCSearchViewController ()<UITableViewDelegate, UITableViewDataSource, ZMCPopViewDelegate,UISearchBarDelegate, UIGestureRecognizerDelegate, hzzSelectIndexPathDelegate>
{
    UIButton *_bgButton;
    
    HZZPopView *_popView;
    
    UISearchBar *_searchBar;
    
    NSArray *_kinds;
    
    NSArray *_searchResultArray;
}

//产品按钮,点击可以展开
@property (strong, nonatomic)  UIButton *productButton;

//搜索历史列表
@property (strong, nonatomic)  UITableView *seachHistoryTable;

@property (nonatomic, strong) NSMutableArray *wordsArray;

@property (nonatomic, strong) UILabel *header_lab;
@property (nonatomic, strong) UIButton *footBtn;
@end

static NSString *cellReuseId = @"cell";



@implementation ZMCSearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self readUserDefault];
    
    [_searchBar becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    _kinds = @[@"商品", @"店铺", @"菜谱"];
    
    self.title = @"搜索";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(cancelClick) title:@"取消"];
    [self settitleView];
    //    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:nil selImage:nil target:self action:@selector(clickToLastView) title:@"取消"];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)settitleView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth, 35)];
    bgView.layer.cornerRadius = 5;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.backgroundColor = ThemeGreenColor;
    
    _productButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置按钮文字
    NSArray *vcArr = [self.navigationController viewControllers];
    NSInteger vcCount = vcArr.count;
    UIViewController *lastVc = vcArr[vcCount - 2];
    if ([lastVc isKindOfClass:[ZMCCookBookViewController class]]) {
        [_productButton setTitle:@"菜谱" forState:UIControlStateNormal];
    }else{
        [_productButton setTitle:_kinds[0] forState:UIControlStateNormal];
    }
    
    _productButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_productButton setImage:[UIImage imageNamed:@"xiala"] forState:UIControlStateNormal];
    [_productButton setTitleColor:StringMiddleColor forState:UIControlStateNormal];
    [bgView addSubview:_productButton];
    [_productButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(70);
    }];
    
    //  按钮里的图文排序
    _productButton.imageEdgeInsets = UIEdgeInsetsMake(0, _productButton.titleLabel.zmc_width + 55, 0, -_productButton.titleLabel.zmc_width);
    _productButton.titleEdgeInsets = UIEdgeInsetsMake(0, -_productButton.imageView.zmc_width, 0, _productButton.imageView.zmc_width);
    
    
    [_productButton addTarget:self action:@selector(clickToChangeKind:) forControlEvents:UIControlEventTouchUpInside];
    [_productButton setBackgroundColor:[UIColor whiteColor]];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = UIColorFromRGB(0xf4f4f4);
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.equalTo(bgView);
        make.left.equalTo(_productButton.mas_right);
        make.centerY.equalTo(bgView);
    }];
    
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.barTintColor = [UIColor whiteColor];
    [_searchBar setBackgroundImage:[UIImage new]];
    _searchBar.showsCancelButton = NO;
    _searchBar.translucent = NO;
    [bgView addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.equalTo(label.mas_right);
        make.right.mas_equalTo(0);
    }];
    
    _searchBar.placeholder = [NSString stringWithFormat:@"搜索%@", _productButton.titleLabel.text];
    _searchBar.delegate = self;
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    
    // Change search bar text color
    searchField.textColor = StringDarkColor;
    searchField.tintColor = [UIColor blueColor];
    self.navigationItem.titleView = bgView;
    
    
    
    [self.view addSubview:self.seachHistoryTable];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancelEdit)];
    tap.delegate = self;
    [_seachHistoryTable addGestureRecognizer:tap];
    
    
}

- (UITableView *)seachHistoryTable
{
    if (!_seachHistoryTable) {
        _seachHistoryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64) style:UITableViewStylePlain];
        _seachHistoryTable.delegate = self;
        _seachHistoryTable.dataSource = self;
        _seachHistoryTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [_seachHistoryTable registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
        _seachHistoryTable.tableHeaderView = [self getHeaderView];
        _seachHistoryTable.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        _seachHistoryTable.separatorColor = UIColorFromRGB(0xe8e8e8);
    }
    return _seachHistoryTable;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 自定义表头
- (UIView *)getHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    return view;
}

//#pragma mark - 取消按钮
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
//    for (id cc in [_searchBar.subviews[0] subviews]) {
//        if ([cc isKindOfClass:[UIButton class]]) {
//            UIButton *btn = (UIButton *)cc;
//            [btn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
//            [btn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
//        }
//    }
//}

- (void)cancelClick{
    [_searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    ZMCLog(@"变不变");
}

#pragma mark- 点击选择种类
- (void)clickToChangeKind:(UIButton *)button
{
    CGPoint point = CGPointMake(_productButton.center.x + 10, _productButton.frame.origin.y + 52);
    
    _popView = [[HZZPopView alloc] initWithOrigin:point Width:80 Height:35 * 3 Type:HZZypeOfUpLeft Color:UIColorFromRGB(0x383838)];
    _popView.dataArray = _kinds;
    _popView.fontSize = 18;
    _popView.row_height = 35;
    _popView.titleTextColor = [UIColor whiteColor];
    _popView.delegate = self;
    [_popView popView];
    
}


- (void)selectIndexPathRow:(NSInteger)index{
    
    [_productButton setTitle:_kinds[index] forState:UIControlStateNormal];
    _searchBar.placeholder = [NSString stringWithFormat:@"搜索%@", _kinds[index]];
    [_popView dismiss];
    
}



#pragma mark- tableview协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    //    if (_wordsArray.count > 0) {
    //        return _wordsArray.count + 1;
    //    }else{
    ZMCLog(@"%ld", _wordsArray.count);
    return _wordsArray.count;
    //    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    
    cell.textLabel.text = _wordsArray[_wordsArray.count - indexPath.row - 1];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = StringDarkColor;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_wordsArray.count == 0) {
        _header_lab.hidden = YES;
        return 0;
    }else{
        _header_lab.hidden = NO;
        return 40;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_wordsArray.count == 0) {
        _footBtn.hidden = YES;
        return 0;
    }else{
        _footBtn.hidden = NO;
        return 60;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 60, 20)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = StringLightColor;
    label.text = @"历史搜索";
    _header_lab = label;
    [view addSubview:label];
    view.backgroundColor = tableView.backgroundColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    //    btn.frame = CGRectMake(0, 0, 100, 40);
    
    [btn.layer setBorderWidth:0.5];
    [btn.layer setBorderColor:[ThemeGreenColor CGColor]];
    [btn.layer setCornerRadius:5.0f];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    _footBtn = btn;
    [view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(35);
    }];
    return view;
    
}

- (void)btnClick{
    ZMCLog(@"清除记录");
    _footBtn.hidden = YES;
    [_wordsArray removeAllObjects];
    
    [USER_DEFAULT setObject:_wordsArray forKey:@"words"];
    [USER_DEFAULT synchronize];
    
    [self.seachHistoryTable reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_wordsArray removeObjectAtIndex:(indexPath.row)];
        
        [USER_DEFAULT setObject:_wordsArray forKey:@"words"];
        [USER_DEFAULT synchronize];
        
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.seachHistoryTable deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self seeResultWithString:cell.textLabel.text];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self clearSearchBar];
}


//#pragma mark- searchbar代理方法
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//    _searchBar.showsCancelButton = NO;
//
//    for (UIView *searchbuttons in [[[searchBar subviews] lastObject] subviews]){
//        if ([searchbuttons isKindOfClass:[UIButton class]]) {
//            UIButton *cancelButton = (UIButton*)searchbuttons;
//            // 修改文字颜色
//            [cancelButton setTitleColor:StringDarkColor forState:UIControlStateNormal];
//            cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        }
//    }
//    return YES;
//}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self clearSearchBar];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if (searchBar.text.length == 0) {
        //        ALERT_MSG(@"提示", @"搜索内容不能为空");
        return;
    } else {
        if (![_wordsArray containsObject:searchBar.text]) {
            [_wordsArray addObject:searchBar.text];
        }
        [USER_DEFAULT setObject:_wordsArray forKey:@"words"];
        [USER_DEFAULT synchronize];
    }
    
    [self seeResultWithString:searchBar.text];
    
    [self clearSearchBar];
}
- (void)clearSearchBar
{
    [_searchBar resignFirstResponder];
    _searchBar.showsCancelButton = NO;
    
    _searchBar.text = @"";
}

- (void)tapCancelEdit
{
    [self clearSearchBar];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return  NO;
}

- (void)seeResultWithString:(NSString *)string
{
    ZMCSearchResultViewController *resultVC = [[ZMCSearchResultViewController alloc] init];
    resultVC.kind = _productButton.titleLabel.text;
    resultVC.searchText = string;
    resultVC.placeholder = @"请输入产品名称搜索";
    [self.navigationController pushViewController:resultVC animated:YES];
}

#pragma mark- 搜索历史相关
- (void)readUserDefault
{
    if (![USER_DEFAULT objectForKey:@"words"]) {
        self.wordsArray = [[NSMutableArray alloc] init];
        return;
    }
    self.wordsArray = [[USER_DEFAULT objectForKey:@"words"] mutableCopy];
    [self.seachHistoryTable reloadData];
}



- (void)viewDidDisappear:(BOOL)animated
{
    [self.view removeFromSuperview];
}
@end
