//
//  SpecialViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/20.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCSpecialViewController.h"
#import "ZMCCustomTableViewCell.h"
#import "HomeNetwork.h"
#import <UIImageView+WebCache.h>
#import "SpecialTodayModel.h"
#import "GoodsDetailVC.h"

@interface ZMCSpecialViewController ()<UITableViewDelegate,UITableViewDataSource,WeChatStylePlaceHolderDelegate>

{
    UITableView *_mainTableView;
    
    NSArray *_specialArray;
}
@end

static NSString *cellReuseId = @"cell";
@implementation ZMCSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"今日特价";

    
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64) style:UITableViewStylePlain];
    _mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [_mainTableView registerNib:[UINib nibWithNibName:@"ZMCCustomTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    [self.view addSubview:_mainTableView];
    
    
    self.refreshTableView = _mainTableView;
    self.currentPage = 1;
    
    __weak typeof(self) blockSelf = self;
    [self setAnimationMJrefreshHeader:^{
        [blockSelf loadNewData];
    }];
    
//    [self setMJrefreshFooter:^{
//        [blockSelf loadMoreData];
//    }];

//    [HomeNetwork requestSpecialTodayGoodsWithPage:1 andPageSize:15 andCompleteBlock:^(NSArray *array) {
//        _specialArray = array;
//        [_mainTableView reloadData];
//    }];
    
    [self geiInfo];
    
    
}


#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    
    self.currentPage = 1;
    [self geiInfo];
    
}

- (void)loadMoreData{
    
    self.currentPage = self.currentPage + 1;
    [self geiInfo];
    
}

- (void)geiInfo {
    
    [CommonHttpAPI getGoodsSpecialsWithParameters:[CommonRequestModel getGoodsSpecialstWithMarket_id:Market_id pageNO:ChangeNSIntegerToStr(self.currentPage) page_size:@"60"] success:^(NSURLSessionDataTask *task, id responseObject) {
        ZMCLog(@"++++++++%@",responseObject);
        if ([responseObject getTheResultForDic]) {
            
//            if (self.currentPage == 1) {
//                [self.totalDataAry removeAllObjects];
//            }
            
            NSArray *array = responseObject[@"result"][@"data"];
            
            NSMutableArray *specials = [SpecialTodayModel mj_objectArrayWithKeyValuesArray:array];
//            _specialArray = specials;
            self.totalDataAry = specials;
//            [self.totalDataAry addObjectsFromArray:specials];
//            [_mainTableView reloadData];
            [self.refreshTableView cyl_reloadData];
            
            
        }else {
            
            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
            
        }
        [self endRefresh];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
        [self endRefresh];
    }];
    
}

#pragma mark - CYLTableViewPlaceHolderDelegate Method 没有数据界面显示

- (UIView *)makePlaceHolderView {
    
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.refreshTableView.frame];
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"暂无特价商品";
//    weChatStylePlaceHolder.content = @"要不换其他商品看看吧";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}


- (void)clickToLastView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- 表的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.totalDataAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    SpecialTodayModel *model = self.totalDataAry[indexPath.row];
    
    [cell.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"tejia1"]];
    
    cell.goodsTitleLabel.text = model.name;
    cell.referencePrice.text = [NSString stringWithFormat:@"市场参考价：%.2f元/%.2f%@",[model.original_price doubleValue] ,[model.market_unit floatValue],model.market_unit_name];
    cell.realPrice.text = [NSString stringWithFormat:@"%.2f元",[model.special_price floatValue]];
    cell.unitLabel.text = [NSString stringWithFormat:@"/%@%@",model.unit,model.unit_name];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialTodayModel *model = self.totalDataAry[indexPath.row];
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] initWithNibName:@"GoodsDetailVC" bundle:nil];
    vc.goods_id = [NSString stringWithFormat:@"%@",model.goods_id];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
