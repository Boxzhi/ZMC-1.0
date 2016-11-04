//
//  ZMCMarketViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "ZMCMarketViewController.h"
#import "ZMCMarketLeftTableViewCell.h"
#import "ZMCMarcetRightCollectionViewCell.h"
#import "ZMCPulic.h"
#import <UIKit/UIKit.h>
#import "GoodsDetailVC.h"
#import "ZMCSearchViewController.h"

#import "MenuClassifyCell.h"
#import "LineImageVerView.h"
#import "LineImageView.h"
#import "GoodsCell.h"
#import "MallTool.h"
#import "VarietiesChoicePickerView.h"

#import "GoodsCategoryModel.h"
#import "GoodsListModel.h"
#import "HistoryMerchantModel.h"

#import "UITabBar+badge.h"

#import "JSDropDownMenu.h"

#define ButtomBtnTag 500

@interface ZMCMarketViewController ()<UITableViewDataSource,UITableViewDelegate,WeChatStylePlaceHolderDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *secondArray;
@property (nonatomic, strong) NSArray *myData;
@property (nonatomic, assign) NSInteger selectionIndex;
@property (nonatomic, strong) UIButton *historyButton;
@property (nonatomic, strong) UIButton *varietyButton;
@property (nonatomic, strong) UIButton *hotButton;

@property (nonatomic, strong) NSString *category_id;
@property (nonatomic, strong) NSString *merchant_id;
@property (nonatomic, strong) NSString *sale_sort;

@property (nonatomic, strong) GoodsCategoryChildsChilds *goodsCategoryChildsChilds_model;
@end

@implementation ZMCMarketViewController

{
    NSInteger number;
    BOOL isOpen;
    int currentClickIndex;
    
    NSString *market_id;
    
    /**
     *  左侧TableView
     */
    UITableView *_leftTableView;
    /**
     *  右侧TableView
     */
    UITableView *_rightTableView;
    
    /**
     *  标记数组 标记展开还是收缩
     */
    NSMutableArray *_signArr;
    
    /**
     *  商品分类列表的数据源
     */
    GoodsCategoryModel *categoryModel;
    
    /**
     *  商品列表的数据源
     */
//    GoodsListModel *goodsList_model;
    
    /**
     *  历史商家的数据源
     */
    HistoryMerchantModel *historyMerchant_model;
    
    /**
     *  品种的数据源
     */
    GoodsCategoryChilds *goodsCategoryChilds_model;
    
    
    BOOL is_start;
    
    NSInteger signNum;
    
    BOOL is_hot;
    
    NSIndexPath *select_indexPath;
    
    NSIndexPath *s_indexPath;
    
    NSString *categ_id;
    
    int is_back;
    
    NSMutableArray *_data1;
    NSMutableArray *_data2;
}

#pragma mark - 视图
- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    if (market_id) {
        NSString *str = Market_id;
        if (![market_id isEqualToString:str]) {
            [categoryModel.result removeAllObjects];
            [self getGoodsCategoryInfo];
            [self getGoodsListInfo];
            historyMerchant_model.result.data = nil;
            [self getHistoryMerchantInfo];
        }
    }
    
    
    if (!Market_id) {
        ALERT_MSG(@"提示", @"未选择菜场，请前往首页选择菜场");
//        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"未选择菜场，请前往首页选择菜场" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }
    
    if (!historyMerchant_model) {
        [self getHistoryMerchantInfo];
    }
    
    if (!categoryModel) {
    
        [self getGoodsCategoryInfo];
//        is_start = NO;
    }else {
        is_back = 1;
        [self getGoodsListInfo];
    }
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"逛菜场";
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"search"] highImage:[UIImage imageNamed:@"search"] target:self action:@selector(clickToSearch) title:nil];


    self.tabBarController.tabBar.hidden = NO;
    
//    self.navigationItem.hidesBackButton = YES;
    
    currentClickIndex = -1;
    
    [self GetRightTableView];
    
    /**
     *  2个筛选按钮
     */
    [self getButton];
//    [self screenButton];
    
    
    _signArr = [NSMutableArray array];
    
    _rightTableView.tableFooterView = [UIView new];
    
    self.refreshTableView = _rightTableView;
    self.currentPage = 1;
    
    __weak typeof(self) blockSelf = self;
    [self setAnimationMJrefreshHeader:^{
        [blockSelf loadNewData];
    }];
    
    [self setMJrefreshFooter:^{
        [blockSelf loadMoreData];
    }];
    
    [self getHistoryMerchantInfo];
    
//    [self getGoodsCategoryInfo];
    
//    is_start = YES;
    signNum = 0;
    self.sale_sort = @"DESC";
    is_hot = NO;
    select_indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    s_indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    
    /**
     *  !!!!暂时写在这，后期需写在获取的数据后面
     */
//    for (int i=0; i<8; i++) {
//        [_signArr addObject:@"0"];
//    }
}


#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    self.currentPage = 1;
    [self getGoodsListInfo];
    
}

- (void)loadMoreData{
    
    self.currentPage = self.currentPage + 1;
    [self getGoodsListInfo];
    
}

//请求商品分类列表数据
- (void)getGoodsCategoryInfo {
    

    [CommonHttpAPI getGoodsCategoriesWithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            categoryModel = [GoodsCategoryModel mj_objectWithKeyValues:responseObject];
            [_signArr removeAllObjects];
            for (int i=0; i<categoryModel.result.count; i++) {
                if (i==0) {
                    [_signArr addObject:@"1"];
                }else
                    [_signArr addObject:@"0"];
            }
            [_leftTableView reloadData];
//            if (is_start) {
            if (categoryModel.result.count != 0) {
                if (categoryModel.result[0].childs.count != 0) {
                    NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:1];
                    [_leftTableView selectRowAtIndexPath:first animated:NO scrollPosition:UITableViewScrollPositionNone];
                    self.category_id = ChangeNSIntegerToStr(categoryModel.result[0].childs[0].child_id);
                    categ_id = self.category_id;
                    
                }
            }
;
            
//                self.category_id = ChangeNSIntegerToStr(categoryModel.result[0].childs[0].child_id);

                self.merchant_id = @"";
                [self getGoodsListInfo];
//            }
//            [_leftTableView reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

//请求商品列表数据
- (void)getGoodsListInfo {
//    CHECK_VALUE(Market_id)
    
    market_id = Market_id;
    [CommonHttpAPI getGoodsListWithParameters:[CommonRequestModel getGoodsListInfoWithPageNO:ChangeNSIntegerToStr(self.currentPage) page_size:@"15" category_id:CHECK_VALUE(self.category_id) market_id:Market_id merchant_id:CHECK_VALUE(self.merchant_id) sale_sort:self.sale_sort] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            if (self.currentPage == 1) {
                [self.totalDataAry removeAllObjects];
            }
            
            GoodsListModel *goodsList_model = [GoodsListModel mj_objectWithKeyValues:responseObject];
            
            [goodsList_model.result.data enumerateObjectsUsingBlock:^(GoodsListData *obj, NSUInteger idx, BOOL *stop) {
                
                [self.totalDataAry addObject:obj];
            }];
            
            
            
            [self.refreshTableView cyl_reloadData];
            [self endRefresh];
            if (self.currentPage >= goodsList_model.result.total_pages) {
                
                [self hidenFooterView];
                
            }
            
            if (is_back != 1) {
                if (goodsList_model.result.data.count > 0 && self.currentPage == 1) {
                    [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                
            }else {
                is_back = 0;
            }
            
            

            
        }else {
            [self endRefresh];
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
        [self endRefresh];
    }];
}

//请求历史商家数据
- (void)getHistoryMerchantInfo {
    
    [CommonHttpAPI getMemberHistoryWithParameters:[CommonRequestModel getMemberHistoryWithPageNO:@"1" page_size:@"5"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
            historyMerchant_model = [HistoryMerchantModel mj_objectWithKeyValues:responseObject];
            
            [_leftTableView reloadData];
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method 没有数据界面显示

- (UIView *)makePlaceHolderView {
    
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.refreshTableView.frame];
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"抱歉了，暂无此类商品";
    weChatStylePlaceHolder.content = @"要不换其他商品看看吧";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
    [self beginFresh];
}


/**
 *
 */


- (void)getButton {
    
#pragma market ------ 添加button;
    
//    // 历史商家button
//    self.historyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    
//    self.historyButton.frame = CGRectMake(0, 0, kScreenWidth/3, 46);
//    
//    [self.historyButton setTitle:@"历史商家" forState:(UIControlStateNormal)];
//    
//    [self.historyButton addTarget:self action:@selector(historyButton:) forControlEvents:(UIControlEventTouchUpInside)];
//    
//    self.historyButton.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:self.historyButton];
    
    // 品种button
    self.varietyButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.varietyButton.frame = CGRectMake(kScreenWidth/3, 0, kScreenWidth/3, 44);
    
    [self.varietyButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    self.varietyButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.varietyButton setTitle:@"品种" forState:(UIControlStateNormal)];
    
    [self.varietyButton addTarget:self action:@selector(varietyButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.varietyButton.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.varietyButton];
    
    //分割线
    LineImageVerView *bgView = [[LineImageVerView alloc] initWithFrame:CGRectMake(kScreenWidth/3*2, 0, 1, 44)];
    
    bgView.backgroundColor = MAIN_BALCOLOR;
    
    [self.view addSubview:bgView];
    
    // 热门button
    self.hotButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    self.hotButton.frame = CGRectMake(kScreenWidth*2/3+1, 0, kScreenWidth/3-1, 44);
    
    [self.hotButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    self.hotButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [self.hotButton setTitle:@"热门" forState:(UIControlStateNormal)];
    
    [self.hotButton addTarget:self action:@selector(hotButton:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.hotButton.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.hotButton];
    
    LineImageView *lineView = [[LineImageView alloc] initWithFrame:CGRectMake(kScreenWidth/3, 44, kScreenWidth/3*2, 1)];
    
    lineView.backgroundColor = MAIN_BALCOLOR;
    
    [self.view addSubview:lineView];
}

- (void)GetRightTableView {
    
#pragma mark------ 添加CollectionView
    
//    UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
//    
//    flowayout.minimumInteritemSpacing = 0.f;
//    flowayout.minimumLineSpacing = 0.5f;
//    
//    _rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(100, 46, kScreenWidth - 100, kScreenHeight - 100) collectionViewLayout:flowayout];
//    
//    [_rightCollectionView registerClass:[ZMCMarcetRightCollectionViewCell class] forCellWithReuseIdentifier:@"ZMCMarcetRightCollectionViewCell"];
//    
//    [_rightCollectionView setBackgroundColor:[UIColor whiteColor]];
//
//    _rightCollectionView.delegate = self;
//    
//    _rightCollectionView.dataSource = self;
//    
//    [self.view addSubview:_rightCollectionView];
    
#pragma mark----- 添加tableView
    
    _leftTableView = [[UITableView alloc] init];
    //隐藏分割线
    [_leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_leftTableView];
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.equalTo(@(SCREEN_W*0.3));
    }];
    
    _rightTableView = [[UITableView alloc] init];
    [self.view addSubview:_rightTableView];
    [_rightTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.equalTo(_leftTableView.mas_right);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    LineImageVerView *bgView = [[LineImageVerView alloc] init];
    
    bgView.backgroundColor = MAIN_BALCOLOR;
    
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(_leftTableView.mas_right);
        make.width.equalTo(@1);
        make.bottom.equalTo(self.view);
    }];
    
}

#pragma mark-------- 实现添加button方法
#pragma mark- 点击导航栏右侧按钮搜索
- (void)clickToSearch
{
    ZMCSearchViewController *searchVC = [[ZMCSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];

}
- (void)clickToRemoveView
{
    [[self.view viewWithTag:240] removeFromSuperview];
}

- (void)varietyButton:(UIButton *)sender {
    
    
    VarietiesChoicePickerView *varietiesPickerView = [[VarietiesChoicePickerView alloc]init];
    varietiesPickerView.childs_model = categoryModel.result[s_indexPath.section-1].childs[s_indexPath.row];
    varietiesPickerView.block = ^(VarietiesChoicePickerView *view,UIButton *btn,GoodsCategoryChildsChilds *model){

        
        [self.varietyButton setTitle:model.name forState:UIControlStateNormal];
        if (model.child_id == -1) {
            self.category_id = categ_id;
        }else {
            self.category_id = ChangeNSIntegerToStr(model.child_id);
        }
        [self getGoodsListInfo];
    };
    [varietiesPickerView show];
    
}

- (void)hotButton:(UIButton *)sender {
    
    if (!is_hot) {
        self.sale_sort = @"ASC";
        [self getGoodsListInfo];
        [sender setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
        is_hot = YES;
    }else {
        self.sale_sort = @"DESC";
        [self getGoodsListInfo];
        [sender setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        is_hot = NO;
    }
    
    
}

#pragma market -------- UIPickerView方法实现
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return categoryModel.result[select_indexPath.section-1].childs[select_indexPath.row].childs.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.varietyButton setTitle:categoryModel.result[select_indexPath.section-1].childs[select_indexPath.row].childs[row].name forState:UIControlStateNormal];
    
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return categoryModel.result[select_indexPath.section-1].childs[select_indexPath.row].childs[row].name;
}



#pragma market -------- tableView方法实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([tableView isEqual:_leftTableView]) {
        
        if (section == 0) {
            if (signNum == 1) {
                return historyMerchant_model.result.data.count;
            }
            return 0;
        }
        NSString *signStr=[_signArr objectAtIndex:section-1];
        if ([@"1" isEqualToString:signStr]) {
            return [categoryModel.result[section-1].childs count];
        }
        return 0;
        
    }else if([tableView isEqual:_rightTableView]) {
        
        return self.totalDataAry.count;
        
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual:_leftTableView]) {
        return categoryModel.result.count+1;
    }else if([tableView isEqual:_rightTableView]) {
        
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_leftTableView]) {
        return 44;
    }else if([tableView isEqual:_rightTableView]) {
        
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_leftTableView]) {
        return 44;
    }
    if ([tableView isEqual:_rightTableView]) {
        return 115;
    }
    return 44;
}

 //500~600
//!!!:tag

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_leftTableView]) {
        
        static NSString *identifier = @"HeaderView";
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (headerView == nil) {
            headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
        }
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        [headerView setFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        
        UIImageView *signImage = (UIImageView *)[headerView.contentView viewWithTag:800];
        if (signImage == nil) {
            signImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerView.contentView.frame.size.width, 44)];
        }
        //    signImage.backgroundColor = [UIColor whiteColor];
//        signImage.backgroundColor = ThemeGreenColor;
        [signImage setImage:[UIImage imageNamed:@"market_left_bgImg.png"]];
        signImage.tag = 800;
        
//        if ([_signArr[section-1] isEqualToString:@"1"]) {
//            signImage.alpha = 1;
//        }else
//            signImage.alpha = 0;
        [headerView.contentView addSubview:signImage];
        
        UILabel *titleLab = (UILabel *)[headerView.contentView viewWithTag:1001];
        if (titleLab == nil) {
            titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, headerView.contentView.frame.size.width, 44)];
        }
        //    titleLab.text = categoryModel.result[section-1].name;
        if (section == 0) {
            titleLab.text = @"历史商家";
        }else {
            titleLab.text = categoryModel.result[section-1].name;
        }
        
        //    titleLab.backgroundColor = [UIColor redColor];
        titleLab.font = [UIFont systemFontOfSize:14];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor darkGrayColor];
        
        titleLab.tag = 1001;
        [headerView.contentView addSubview:titleLab];
        
        if (_signArr.count!=0&&section!=0) {
            if ([_signArr[section-1] isEqualToString:@"1"]) {
                signImage.alpha = 1;
                titleLab.textColor = [UIColor whiteColor];
            }else {
                signImage.alpha = 0;
                titleLab.textColor = [UIColor darkGrayColor];
            }
        }else {
            signImage.alpha = 0;
            titleLab.textColor = [UIColor darkGrayColor];
        }
        
        
        UIButton *buttomBtn = (UIButton *)[headerView.contentView viewWithTag:ButtomBtnTag+section];
        if (buttomBtn == nil) {
            buttomBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, headerView.contentView.frame.size.width, 44)];
        }
        buttomBtn.backgroundColor = [UIColor clearColor];
        buttomBtn.tag = ButtomBtnTag+section;
        [buttomBtn addTarget:self action:@selector(hideOrShow:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.contentView addSubview:buttomBtn];
        
        return headerView;
        
    }
    if ([tableView isEqual:_rightTableView]) {
        
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    if ([tableView isEqual:_leftTableView]) {
        
        static NSString *identifier1 = @"MenuClassifyCell";
        
        MenuClassifyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuClassifyCell" owner:nil options:nil] firstObject];
        }
        
//        [cell setMenuClassify:categoryModel.result[indexPath.section-1].childs[indexPath.row]];
        
        if (signNum == 1) {
            [cell setMenuMercant:historyMerchant_model.result.data[indexPath.row]];
        }else {
            [cell setMenuClassify:categoryModel.result[indexPath.section-1].childs[indexPath.row]];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else if([tableView isEqual:_rightTableView]) {
        
        static NSString *identifier2 = @"GoodsCell";
        
        GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil] firstObject];
        }
        cell.goodsReduce_btn.alpha = 0;
        
//        cell.goodsIncrease_btn
        
//        [[cell.goodsReduce_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[[cell.goodsReduce_btn
               rac_signalForControlEvents:UIControlEventTouchUpInside]
              takeUntil:cell.rac_prepareForReuseSignal]
             subscribeNext:^(UIButton *x) {
                 
              Check_Login
                 cell.goodsReduce_btn.userInteractionEnabled = NO;
                 cell.goodsIncrease_btn.userInteractionEnabled = NO;
            
            
//            GoodsListData *data = self.totalDataAry[indexPath.row];
            
            [CommonHttpAPI postGoodsDecreaseWithParameters:[CommonRequestModel getGoodsDecreaseryWithItem_id:ChangeNSIntegerToStr(((GoodsListData *)self.totalDataAry[indexPath.row]).goods_id) quantity:@"1" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                
                if ([responseObject getTheResultForDic]) {
                    
                    [ZMCPulic minusTapped:cell.goodsReduce_btn getCountLabel:cell.goodsNumber_lab];
                    
                    [ChatbadgecountManager share].badgeCount --;
                    if ([ChatbadgecountManager share].badgeCount <= 0) {
                        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
                    }else {
                        [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%ld",(long)[ChatbadgecountManager share].badgeCount]];
                    }
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
                cell.goodsReduce_btn.userInteractionEnabled = YES;
                cell.goodsIncrease_btn.userInteractionEnabled = YES;
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
                cell.goodsReduce_btn.userInteractionEnabled = YES;
                cell.goodsIncrease_btn.userInteractionEnabled = YES;
            }];
            
            
        }];
        [[[cell.goodsIncrease_btn
           rac_signalForControlEvents:UIControlEventTouchUpInside]
          takeUntil:cell.rac_prepareForReuseSignal]
         subscribeNext:^(UIButton *x) {
             
             Check_Login
             
             cell.goodsReduce_btn.userInteractionEnabled = NO;
             cell.goodsIncrease_btn.userInteractionEnabled = NO;

             
             [CommonHttpAPI postGoodsIncreaseWithParameters:[CommonRequestModel getGoodsIncreaseryWithItem_id:ChangeNSIntegerToStr(((GoodsListData *)self.totalDataAry[indexPath.row]).goods_id)  quantity:@"1" start_time:@"" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 ZMCLog(@"%@",responseObject);

                 
                 if ([responseObject getTheResultForDic]) {
                     
                     [ZMCPulic plusTapped:cell.goodsIncrease_btn getMinusButton:cell.goodsReduce_btn getCountLabel:cell.goodsNumber_lab];
                     
                     CGPoint exactTouchPosition = [cell.goodsImgView convertPoint:cell.goodsIncrease_btn.center toView:self.view];
                     
                     UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 40, 40)];
                     imageView.image =cell.goodsImgView.image;
                     
                     //显示
//                     [self.tabBarController.tabBar showBadgeOnItemIndex:3];
                     
                     [ChatbadgecountManager share].badgeCount ++;
                     
                     if ([ChatbadgecountManager share].badgeCount <= 0) {
                         [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:nil];
                     }else {
                         [[[[[self tabBarController] tabBar] items] objectAtIndex:3] setBadgeValue:[NSString stringWithFormat:@"%ld",(long)[ChatbadgecountManager share].badgeCount]];
                     }
                     
                     //成功动画
                     [MallTool addSHopAnimation:imageView withPoint:exactTouchPosition perform:^(CALayer *imgLayer) {
                         [imgLayer removeAllAnimations];
                         [imgLayer removeFromSuperlayer];
                     }];
                     
                     cell.goodsReduce_btn.userInteractionEnabled = YES;
                     cell.goodsIncrease_btn.userInteractionEnabled = YES;
                     
                 }else {
                     
                     [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                     
                 }
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 ZMCLog(@"%@",error);
                 cell.goodsReduce_btn.userInteractionEnabled = YES;
                 cell.goodsIncrease_btn.userInteractionEnabled = YES;
             }];

         }];
        /*
        [[cell.goodsIncrease_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            Check_Login
            
//                                [ZMCPulic plusTapped:cell.goodsIncrease_btn getMinusButton:cell.goodsReduce_btn getCountLabel:cell.goodsNumber_lab];
            ZMCLog(@"------------");
//
            [CommonHttpAPI postGoodsIncreaseWithParameters:[CommonRequestModel getGoodsIncreaseryWithItem_id:ChangeNSIntegerToStr(((GoodsListData *)self.totalDataAry[indexPath.row]).goods_id)  quantity:@"1" start_time:@"" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
                
                ZMCLog(@"%@",responseObject);
                
                if ([responseObject getTheResultForDic]) {
                    
                    [ZMCPulic plusTapped:cell.goodsIncrease_btn getMinusButton:cell.goodsReduce_btn getCountLabel:cell.goodsNumber_lab];
                    
                    CGPoint exactTouchPosition = [cell.goodsImgView convertPoint:cell.goodsIncrease_btn.center toView:self.view];
                    
                    UIImageView *imageView =[[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 40, 40)];
                    imageView.image =cell.goodsImgView.image;
                    
                    //显示
                    [self.tabBarController.tabBar showBadgeOnItemIndex:3];
                    
                    //成功动画
                    [MallTool addSHopAnimation:imageView withPoint:exactTouchPosition perform:^(CALayer *imgLayer) {
                        [imgLayer removeAllAnimations];
                        [imgLayer removeFromSuperlayer];
                    }];
                    
                }else {
                    
                    [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                    
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                ZMCLog(@"%@",error);
            }];
         
            
        }];
        */
        
        if (self.totalDataAry.count != 0) {
            [cell setGoodsInfo:self.totalDataAry[indexPath.row]];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    
    return nil;
    
}

#pragma mark -- tableView headerView点击事件
- (void)hideOrShow:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSInteger tag = button.tag-1;

    
    if (tag-ButtomBtnTag+1 == 0) {
        
        Check_Login
        
        UITableViewHeaderFooterView *view = [_leftTableView headerViewForSection:tag-ButtomBtnTag+1];
        //    UIImageView *flagImage = (UIImageView *)[view.contentView viewWithTag:1111];
        UIImageView *signImage = (UIImageView *)[view.contentView viewWithTag:800];
        UILabel *titleLab = (UILabel *)[view.contentView viewWithTag:1001];
        
        NSMutableArray *a = [NSMutableArray array];
        
        if (historyMerchant_model.result.data.count > 0) {
            for (int i=0;i<historyMerchant_model.result.data.count;i++) {
                NSIndexPath *updated = [NSIndexPath indexPathForRow:i inSection:tag-ButtomBtnTag+1];
                [a addObject:updated];
            }
            a = (NSMutableArray *)[[a reverseObjectEnumerator] allObjects];
        }
        
        if (signNum == 0) {
            for (int i=0; i<_signArr.count; i++) {
                NSString *str = [_signArr objectAtIndex:i];
                if ([@"1" isEqualToString:str]) {
                    UITableViewHeaderFooterView *view1 = [_leftTableView headerViewForSection:i+1];
                    //                UIImageView *flagImage1 = (UIImageView *)[view1.contentView viewWithTag:1111];
                    UIImageView *signImage1 = (UIImageView *)[view1.contentView viewWithTag:800];
                    UILabel *titleLab1 = (UILabel *)[view1.contentView viewWithTag:1001];
                    signImage1.alpha = 0;
                    titleLab1.textColor = [UIColor darkGrayColor];
                    //                [UIView animateWithDuration:0.3 animations:^{
                    //                    flagImage1.transform = CGAffineTransformMakeRotation(M_PI * 2);
                    //                }];
                    [_signArr replaceObjectAtIndex:i withObject:@"0"];
                    NSMutableArray *arr = [NSMutableArray array];
                    if (categoryModel.result[i].childs.count > 0) {
                        for (int j = 0; j < categoryModel.result[i].childs.count; j++) {
                            NSIndexPath *updated = [NSIndexPath indexPathForRow:j inSection:i+1];
                            [arr addObject:updated];
                        }
                        arr = (NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
                    }
                    if (categoryModel.result[i].childs.count >0) {
                        
                        [_leftTableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                        
                    }
                }
            }
            signNum = 1;
            if (historyMerchant_model.result.data.count >0) {
                
                [_leftTableView insertRowsAtIndexPaths:a withRowAnimation:UITableViewRowAnimationFade];
                
            }
            
            
            
            signImage.alpha = 1;
            titleLab.textColor = [UIColor whiteColor];
        }else {
            
            signNum = 0;
            if (historyMerchant_model.result.data.count >0) {
            
                    [_leftTableView deleteRowsAtIndexPaths:a withRowAnimation:UITableViewRowAnimationFade];

            }
            signImage.alpha = 0;
            titleLab.textColor = [UIColor darkGrayColor];
        }
        
        return;
    }
    
    

    
    NSString *str = [_signArr objectAtIndex:tag-ButtomBtnTag];
    UITableViewHeaderFooterView *view = [_leftTableView headerViewForSection:tag-ButtomBtnTag+1];
    //    UIImageView *flagImage = (UIImageView *)[view.contentView viewWithTag:1111];
    UIImageView *signImage = (UIImageView *)[view.contentView viewWithTag:800];
    UILabel *titleLab = (UILabel *)[view.contentView viewWithTag:1001];
    
    NSMutableArray *a = [NSMutableArray array];
    
    
    
    if (categoryModel.result[tag-ButtomBtnTag].childs.count > 0) {
        for (int i = 0; i < categoryModel.result[tag-ButtomBtnTag].childs.count; i++) {
            NSIndexPath *updated = [NSIndexPath indexPathForRow:i inSection:tag-ButtomBtnTag+1];
            [a addObject:updated];
        }
        a = (NSMutableArray *)[[a reverseObjectEnumerator] allObjects];
    }
    
    for (int j=0; j<3; j++) {
        NSUInteger newIndex[] = {0, j};
        NSIndexPath *newPath = [[NSIndexPath alloc] initWithIndexes:newIndex length:2];
        MenuClassifyCell *cell = [_leftTableView cellForRowAtIndexPath:newPath];
        cell.selected = NO;
    }
    
    
    if ([@"0" isEqualToString:str]) {
        
        if (signNum == 1) {
            
            signNum = 0;
            
            UITableViewHeaderFooterView *view1 = [_leftTableView headerViewForSection:0];
            //                UIImageView *flagImage1 = (UIImageView *)[view1.contentView viewWithTag:1111];
            UIImageView *signImage1 = (UIImageView *)[view1.contentView viewWithTag:800];
            UILabel *titleLab1 = (UILabel *)[view1.contentView viewWithTag:1001];
            signImage1.alpha = 0;
            titleLab1.textColor = [UIColor darkGrayColor];
            
            NSMutableArray *arr = [NSMutableArray array];
            if (historyMerchant_model.result.data.count > 0) {
                for (int j = 0; j < historyMerchant_model.result.data.count; j++) {
                    NSIndexPath *updated = [NSIndexPath indexPathForRow:j inSection:0];
                    [arr addObject:updated];
                }
                arr = (NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
            }
            if (historyMerchant_model.result.data.count >0) {
                
                    [_leftTableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                
            }
//            signNum = 0;

        }
        
        for (int i=0; i<_signArr.count; i++) {
            NSString *str = [_signArr objectAtIndex:i];
            if ([@"1" isEqualToString:str]) {
                UITableViewHeaderFooterView *view1 = [_leftTableView headerViewForSection:i+1];
                //                UIImageView *flagImage1 = (UIImageView *)[view1.contentView viewWithTag:1111];
                UIImageView *signImage1 = (UIImageView *)[view1.contentView viewWithTag:800];
                UILabel *titleLab1 = (UILabel *)[view1.contentView viewWithTag:1001];
                signImage1.alpha = 0;
                titleLab1.textColor = [UIColor darkGrayColor];
                //                [UIView animateWithDuration:0.3 animations:^{
                //                    flagImage1.transform = CGAffineTransformMakeRotation(M_PI * 2);
                //                }];
                [_signArr replaceObjectAtIndex:i withObject:@"0"];
                NSMutableArray *arr = [NSMutableArray array];
                if (categoryModel.result[i].childs.count > 0) {
                    for (int j = 0; j < categoryModel.result[i].childs.count; j++) {
                        NSIndexPath *updated = [NSIndexPath indexPathForRow:j inSection:i+1];
                        [arr addObject:updated];
                    }
                    arr = (NSMutableArray *)[[arr reverseObjectEnumerator] allObjects];
                }
                if (categoryModel.result[i].childs.count >0) {
                    
                    [_leftTableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
                    
                }
            }
        }
        
        [_signArr replaceObjectAtIndex:tag-ButtomBtnTag withObject:@"1"];
        
        if (categoryModel.result[tag-ButtomBtnTag].childs.count >0) {
            
            [_leftTableView insertRowsAtIndexPaths:a withRowAnimation:UITableViewRowAnimationFade];
            
        }
        
        self.category_id = ChangeNSIntegerToStr(categoryModel.result[tag-ButtomBtnTag].list_id);
        self.currentPage = 1;
        [self getGoodsListInfo];
        
        signImage.alpha = 1;
        titleLab.textColor = [UIColor whiteColor];
        
        
    }else {
        
        [_signArr replaceObjectAtIndex:tag-ButtomBtnTag withObject:@"0"];
        if (categoryModel.result[tag-ButtomBtnTag].childs.count >0) {
            
            [_leftTableView deleteRowsAtIndexPaths:a withRowAnimation:UITableViewRowAnimationFade];
            
        }
        signImage.alpha = 0;
        titleLab.textColor = [UIColor darkGrayColor];
    }
//    signNum = 0;
}


-(void)click:(UIButton*)btn
{
    NSMutableDictionary *dict = [_dataArray objectAtIndex:btn.tag];
    if ([dict[@"type"]isEqualToString:@"1"]) {
        [dict setObject:@"0" forKey:@"type"];
    }else{
        [dict setObject:@"1" forKey:@"type"];
    }
    
    
    NSIndexSet *indexSet = [[NSIndexSet alloc]initWithIndex:btn.tag];
    [_leftTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 30;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 35;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_leftTableView]) {
        
        if (indexPath.section == 0) {
            
            self.category_id = @"";
            self.merchant_id = ChangeNSIntegerToStr(historyMerchant_model.result.data[indexPath.row].data_id);
            categ_id = self.category_id;
            
        }else {
            self.category_id = ChangeNSIntegerToStr(categoryModel.result[indexPath.section-1].childs[indexPath.row].child_id);
            s_indexPath = indexPath;
            self.merchant_id = @"";
            categ_id = self.category_id;
        }
        [self.varietyButton setTitle:@"品种" forState:UIControlStateNormal];
//        self.category_id = ChangeNSIntegerToStr(categoryModel.result[indexPath.section-1].childs[indexPath.row].child_id);
//        self.merchant_id = @"";
//        goodsCategoryChilds_model = categoryModel.result[indexPath.section-1].childs;
        select_indexPath = indexPath;
        self.currentPage = 1;
        [self getGoodsListInfo];
        
    }else if([tableView isEqual:_rightTableView]) {
        
        self.tabBarController.tabBar.hidden = YES;
        
        GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
        vc.goods_id = ChangeNSIntegerToStr(((GoodsListData *)self.totalDataAry[indexPath.row]).goods_id);
        [self.navigationController pushViewController:vc animated:YES];
        
//        UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"MarketStoryboard" bundle:nil];
//        
//        ZMCGoodsDetailsViewController *goodsDetailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"GoodsDetailVC"];
//        
//        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }
    
    
}

//#pragma mark -------- CollectionView代理方法
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    
//    return _myData.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    ZMCMarcetRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZMCMarcetRightCollectionViewCell" forIndexPath:indexPath];
//    
//    // 根据左边点击的indepath更新右边的内容
//    switch (_selectionIndex) {
//        case 0:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"2"];
////            [self changeCollectionViewFram];
//            break;
//        case 1:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"3"];
////            [self changeCollectionViewFram];
//            break;
//        case 2:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"2"];
////            [self changeCollectionViewFram];
//            break;
//        case 3:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"3"];
////            [self changeCollectionViewFram];
//            break;
//        case 4:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"2"];
////            [self changeCollectionViewFram];
//            break;
//        case 5:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"3"];
////            [self changeCollectionViewFram];
//            break;
//        case 6:
//            cell.marketRightImageView.image = [UIImage imageNamed:@"2"];
////            [self changeCollectionViewFram];
//            break;
//        default:
//            break;
//    }
//    
//    cell.marketNameLabel.text = _myData[indexPath.row];
//    
//    cell.countLabel.text = @"0";
//    
//    [cell.plusButton addTarget:self action:@selector(plusTappde:) forControlEvents:(UIControlEventTouchUpInside)];
//    
//    [cell.minusButton addTarget:self action:@selector(minusTappde:) forControlEvents:(UIControlEventTouchUpInside)];
//    
//    return cell;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake(kScreenWidth - 100, 110);
//}
//
//
//#pragma mark ------ 加号方法
//
//- (void)plusTappde:(UIButton *)sender {
//    
//    ZMCMarcetRightCollectionViewCell *cell = (ZMCMarcetRightCollectionViewCell *)sender.superview.superview;
//    
//    [ZMCPulic plusTapped:cell.plusButton getMinusButton:cell.minusButton getCountLabel:cell.countLabel];
//}
//
//#pragma mark ------- 减号方法
//
//- (void)minusTappde:(UIButton *)sender {
//    
//    ZMCMarcetRightCollectionViewCell *cell = (ZMCMarcetRightCollectionViewCell *)sender.superview.superview;
//    
//    [ZMCPulic minusTapped:cell.minusButton getCountLabel:cell.countLabel];
//
//}
//
//#pragma mark -------- 点击cell跳转方法
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    self.tabBarController.tabBar.hidden = YES;
//    
//    UIStoryboard *detailStoryboard = [UIStoryboard storyboardWithName:@"MarketStoryboard" bundle:nil];
//    
//    ZMCGoodsDetailsViewController *goodsDetailVC = [detailStoryboard instantiateViewControllerWithIdentifier:@"GoodsDetailVC"];
//    
//    [self.navigationController pushViewController:goodsDetailVC animated:YES];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
