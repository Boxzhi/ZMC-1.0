//
//  ZMCSearchResultViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/12.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCSearchResultViewController.h"

#import "HomeNetwork.h"
#import "ZMCSearchGoodsTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "GoodsSearchResultModel.h"

#import "LocationMarketModel.h"

#import "ZMCHomePageViewController.h"
#import "GoodsDetailVC.h"

#import "ShopsDetailVC.h"
#import "MerchantDetailModel.h"

#import "ZMCListCaipuItem.h"
#import "ZMCListCaipuTableViewCell.h"
#import "ZMCCookBookDetailViewController.h"
#import "ZMCRefreshFooter.h"


@interface ZMCSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate, WeChatStylePlaceHolderDelegate>
{
    
//    UISearchBar *_searchBar;
    
    NSMutableArray *_searchResultArray;
    
    CGFloat _rowHeight;
    
    NSArray *_allKinds;
}

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) UITableView *searchResultTableView;

@property (nonatomic, strong) UIButton *productButton;
@end

static NSString *searchGoods = @"goods";
static NSString *searchShop = @"shop";
static NSString *searchCaipu = @"caipu";
@implementation ZMCSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    self.navigationItem.title = _searchText;

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self searchResultTableView];
    
//    _searchBar.userInteractionEnabled = NO;
//    _searchBar.showsCancelButton = NO;
    
    
    self.searchResultTableView.mj_footer = [ZMCRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    _allKinds = @[@"商品", @"店铺", @"菜谱"];
    

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCancelEdit)];
//    tap.delegate = self;
//    [_searchResultTableView addGestureRecognizer:tap];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNewData];
}


- (void)loadNewData{
    self.currentPage = 1;
    [self loadData];
}

- (void)loadMoreData{
    self.currentPage += 1;
    [self loadData];
}


- (void)loadData{

    if ([_kind isEqualToString:@"商品"]) {
        _rowHeight = 110;
        [self.searchResultTableView.mj_footer endRefreshingWithNoMoreData];
        [self.searchResultTableView registerNib:[UINib nibWithNibName:@"ZMCSearchGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:searchGoods];
        [HomeNetwork requestGoodsWithName:_searchText andPage:1 andPageSize:15 andCompleteBlock:^(NSMutableArray *array) {
            _searchResultArray = array;
            
            [_searchResultTableView cyl_reloadData];
        }];
    }
    
    if ([_kind isEqualToString:@"店铺"]) {
        _rowHeight = 110;
        [self.searchResultTableView.mj_footer endRefreshingWithNoMoreData];
        [CommonHttpAPI getMerchantSearchWithParameters:[CommonRequestModel getMerchantSearchWithMarket_id:Market_id name:_searchText page:@"1" page_size:@"30"] success:^(NSURLSessionDataTask *task, id responseObject) {
            ZMCLog(@"%@",responseObject);
            if ([responseObject getTheResultForDic]) {
                
                _searchResultArray = [MerchantDetailResult mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
                
                [_searchResultTableView cyl_reloadData];
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];

    }else if ([_kind isEqualToString:@"菜谱"]){
        
        _rowHeight = 150;
        [self.searchResultTableView registerNib:[UINib nibWithNibName:@"ZMCListCaipuTableViewCell" bundle:nil] forCellReuseIdentifier:searchCaipu];
        
        [HomeNetwork getHomeSearchListWithKeyword:_searchText search_type:@3 page:[NSNumber numberWithInteger:_currentPage]  page_size:@20 listBlock:^(NSDictionary *result){
            
            [ZMCListCaipuItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"caipu_Id":@"id"};
            }];
            if (_currentPage == 1) {
                
                _searchResultArray = [ZMCListCaipuItem mj_objectArrayWithKeyValuesArray:result[@"result"][@"data"]];
            }else{
                NSArray *moreArr = [ZMCListCaipuItem mj_objectArrayWithKeyValuesArray:result[@"result"][@"data"]];
                [_searchResultArray addObjectsFromArray:moreArr];
            }
            
            [_searchResultTableView cyl_reloadData];
            if (_currentPage == [result[@"result"][@"total_pages"] integerValue]) {
                [self.searchResultTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                [self.searchResultTableView.mj_footer endRefreshing];
            }
        }];
        
    }else if ([_kind isEqualToString:@"菜场"]){
        _rowHeight = 44;
        
        [self.searchResultTableView.mj_footer endRefreshingWithNoMoreData];
        [CommonHttpAPI getMarketSearchWithParameters:[CommonRequestModel getMarketSearchWithAddress:_searchText city_id:_pccInfo[@"city"] county_id:_pccInfo[@"country"] province_id:_pccInfo[@"province"]] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);

            if ([responseObject getTheResultForDic]) {
                
                _searchResultArray = [LocationMarketModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"list"]];
                
                [_searchResultTableView cyl_reloadData];

                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
    }
}



- (UITableView *)searchResultTableView
{
    if (!_searchResultTableView) {
        _searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _searchResultTableView.delegate = self;
        _searchResultTableView.dataSource = self;
        _searchResultTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _searchResultTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [self.view addSubview:_searchResultTableView];
//        _searchResultTableView.tableHeaderView = [self getHeaderView];
        
        _searchResultTableView.separatorColor = UIColorFromRGB(0xe8e8e8);
    }
    
    return _searchResultTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 自定义表头
//- (UIView *)getHeaderView
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
//    
//    //为了设置圆角，需要一个背景的view
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, kScreenWidth - 20, 40)];
//    [view addSubview:bgView];
//    bgView.backgroundColor = [UIColor whiteColor];
//    
//    //选择种类按钮
//    _productButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_productButton setTitle:_kind forState:UIControlStateNormal];
//    _productButton.titleLabel.font = [UIFont systemFontOfSize:14];
//    [_productButton setTitleColor:StringMiddleColor forState:UIControlStateNormal];
//    [bgView addSubview:_productButton];
//    [_productButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.mas_equalTo(0);
//        make.width.mas_equalTo(70);
//    }];
//    [_productButton addTarget:self action:@selector(clickToChangeKind:) forControlEvents:UIControlEventTouchUpInside];
//    [_productButton setBackgroundColor:[UIColor whiteColor]];
//    
//    //按钮和搜索框之间的分割线
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = UIColorFromRGB(0xf4f4f4);
//    [bgView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(1);
//        make.height.equalTo(bgView);
//        make.left.equalTo(_productButton.mas_right);
//        make.centerY.equalTo(bgView);
//    }];
//    
//    //搜索框
//    _searchBar = [[UISearchBar alloc] init];
//    _searchBar.barTintColor = [UIColor whiteColor];
//    [_searchBar setBackgroundImage:[UIImage new]];
//    _searchBar.translucent = NO;
//    [bgView addSubview:_searchBar];
//    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(0);
//        make.left.equalTo(label.mas_right);
//        make.right.mas_equalTo(0);
//    }];
//    _searchBar.tintColor = StringDarkColor;
//    _searchBar.text = _searchText;
//    _searchBar.placeholder = @"输入商品名称搜索";
//    _searchBar.delegate = self;
//    // Get the instance of the UITextField of the search bar
//    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
//    
//    // Change search bar text color
//    searchField.textColor = StringDarkColor;
//    
//    //倒三角图片
//    UIImageView *smallIcon = [[UIImageView alloc] init];
//    smallIcon.image = [UIImage imageNamed:@"xiala"];
//    [bgView addSubview:smallIcon];
//    [smallIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(bgView);
//        make.left.mas_equalTo(60);
//        make.width.mas_equalTo(6);
//        make.height.mas_equalTo(3);
//    }];
//    
//    //设置圆角
//    bgView.layer.cornerRadius = 4;
//    bgView.layer.masksToBounds = YES;
//    
//    
//    return view;
//}

- (void)clickToChangeKind:(UIButton *)button
{
    
}

#pragma mark- tableview协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_kind isEqualToString:@"商品"]) {
        ZMCSearchGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchGoods forIndexPath:indexPath];
        GoodsSearchResultModel *model = _searchResultArray[indexPath.row];
        
        [cell.goodsPicture sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"shouye3"]];
        
        cell.goodsName.text = model.name;
        cell.price.text = [NSString stringWithFormat:@"%.2f元",[model.price floatValue]];
        cell.unitAndName.text = [NSString stringWithFormat:@"/%@%@",model.unit,model.unit_name];
        cell.shopName.text = model.merchant_name;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }else if ([_kind isEqualToString:@"店铺"]) {
//        ZMCSearchGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchGoods forIndexPath:indexPath];
        static NSString *identifier = @"ZMCSearchGoodsTableViewCell";
        
        ZMCSearchGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ZMCSearchGoodsTableViewCell" owner:nil options:nil] firstObject];
        }
        MerchantDetailResult *model = _searchResultArray[indexPath.row];
        
        [cell.goodsPicture sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"shouye3"]];
        
        cell.goodsName.text = model.name;
        cell.price.text = [NSString stringWithFormat:@"收藏%ld个",(long)model.collection_count];
        cell.price.textColor = [UIColor lightGrayColor];
        cell.price.font = [UIFont systemFontOfSize:13];
        cell.unitAndName.text = @"";
        cell.shopName.text = [NSString stringWithFormat:@"共有%ld个商品",(long)model.kind_count];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;

    }else if ([_kind isEqualToString:@"菜谱"]){
        
        ZMCListCaipuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCaipu forIndexPath:indexPath];
        ZMCListCaipuItem *item = _searchResultArray[indexPath.row];
        
        [cell.caipuImage sd_setImageWithURL:[NSURL URLWithString:item.thumb] placeholderImage:[UIImage imageNamed:@"caipu1"]];
        
        cell.caipuLabel.text = item.name;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
        
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        
        LocationMarketModel *model = _searchResultArray[indexPath.row];
        cell.textLabel.text = model.name;
        cell.textLabel.textColor = StringMiddleColor;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.text = model.address;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_kind isEqualToString:@"商品"]) {
        
        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
        GoodsSearchResultModel *model = _searchResultArray[indexPath.row];
        vc.goods_id = [NSString stringWithFormat:@"%@",model.goods_id];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([_kind isEqualToString:@"店铺"]) {
        
        ShopsDetailVC *vc = [[ShopsDetailVC alloc] initWithNibName:@"ShopsDetailVC" bundle:nil];
        MerchantDetailResult *model = _searchResultArray[indexPath.row];
        vc.merchant_id = [NSString stringWithFormat:@"%ld",(long)model.merchant_id];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    if ([_kind isEqualToString:@"菜场"]) {
        LocationMarketModel *model = _searchResultArray[indexPath.row];
//        self.returnMarketModelBlock(model);
        
        ZMCHomePageViewController *vc = self.navigationController.viewControllers[0];
        vc.locationModel = model;
        [self.navigationController popToViewController:vc animated:YES];
    }
    
    if ([_kind isEqualToString:@"菜谱"]) {
        
        ZMCCookBookDetailViewController *detaVc = [[ZMCCookBookDetailViewController alloc] init];
        ZMCListCaipuItem *item = _searchResultArray[indexPath.row];
        detaVc.cookBookID = [item.caipu_Id longValue];
        [self.navigationController pushViewController:detaVc animated:YES];
    }
}

//- (void)returnMarketModel:(returnMarketModelBlock)block
//{
//    self.returnMarketModelBlock = block;
//}

- (void)tapCancelEdit
{
//    [_searchBar resignFirstResponder];;
}

#pragma mark- searchbar代理方法
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    _searchBar.showsCancelButton = YES;
    
    return YES;
}


#pragma mark - 占位视图
- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:_searchResultTableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"暂无数据";
    weChatStylePlaceHolder.content = @"换个关键词搜索试试吧";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}

@end
