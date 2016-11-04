//
//  ZMCCollectionViewController.m
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCollectionViewController.h"
#import "ZMCCollectionViewCell.h"
#import "ZMCCollectionManger.h"
#import "ZMCCollectionItem.h"
#import "ShopsDetailVC.h"
#import "ZMCRefreshHeader.h"


static NSString * const ID = @"Collectioncell";
@interface ZMCCollectionViewController ()<UITableViewDelegate, UITableViewDataSource>

// 每一行收藏的数据数组
@property (nonatomic, strong) NSMutableArray *celldata;
// 总收藏数
@property (nonatomic ,assign) NSInteger totalNumber;
@end

@implementation ZMCCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    self.weChatStylePlaceHolderTitle = @"没有收藏";
    self.weChatStylePlaceHolderContent = @"没有收藏数据啊";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCCollectionViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    // 去掉上下滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    // 隐藏cell间的黑线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self loadData];
}



#pragma mark - 获取收藏列表数据
- (void)loadData{
    
    [ZMCCollectionManger getCollectList:^(NSDictionary *result) {
    
        [ZMCCollectionItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"item_id" : @"id"};
        }];
        
        _celldata = [ZMCCollectionItem mj_objectArrayWithKeyValuesArray:result[@"data"]];
        ZMCLog(@"每行的数据-->%@    收藏总数%@", _celldata, result[@"total"]);
        
        [self.tableView cyl_reloadData];
        
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - Tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _celldata.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZMCCollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.item = _celldata[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cell.selected = NO;
    });
    
    // 点击后跳转控制器
    ShopsDetailVC *vc = [[ShopsDetailVC alloc] initWithNibName:@"ShopsDetailVC" bundle:nil];
    ZMCCollectionItem *item = _celldata[indexPath.row];
    ZMCLog(@"商品的ID---->>>%@", item);
//    NSString *str = [NSString stringWithFormat:@"%@",item.fav_id];
    vc.merchant_id = ChangeNSIntegerToStr(item.fav_id);
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - 左滑删除所有方法
// UITableView进入编辑模式
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"取消收藏";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        ZMCCollectionItem *item = _celldata[indexPath.row];
        [self.celldata removeObjectAtIndex:indexPath.row];
        
        [ZMCCollectionManger deleteFavoriteFav_id:ChangeNSIntegerToStr(item.fav_id) result:^(NSString *result) {
            if (![result isEqualToString:@"OK"]) {
                
                [SVProgressHUD showErrorWithStatus:result];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
        }];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView cyl_reloadData];
        
    }];
    
    deleteRowAction.backgroundColor = RGB(255, 37, 55);
    
    return @[deleteRowAction];
}

#pragma mark - 占位视图
//- (UIView *)makePlaceHolderView{
//    UIView *weChatStyle = [self weChatStylePlaceHolder];
//    weChatStyle.userInteractionEnabled = NO;
//    return weChatStyle;
//}
//
//- (UIView *)weChatStylePlaceHolder{
//    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableView.frame];
//    
//    weChatStylePlaceHolder.delegate = self;
//    weChatStylePlaceHolder.imageName = @"wu.png";
//    weChatStylePlaceHolder.title = @"没有收藏";
//    weChatStylePlaceHolder.content = @"快去收藏喜欢的商品吧~";
//    
//    return weChatStylePlaceHolder;
//}
//
//- (void)emptyOverlayClicked:(id)sender {
//}
//
//- (BOOL)enableScrollWhenPlaceHolderViewShowing{
//    return YES;
//}

@end
