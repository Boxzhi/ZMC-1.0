//
//  MenuDetailViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMenuDetailViewController.h"
#import "ZMCMenuDetailTableViewCell.h"
#import "ZMCMenuDetailTableHeaderView.h"
#import "ZMCThird.h"
#import "ZMCMyDetailItem.h"
#import "ZMCMyDetailHeaderItem.h"
#import "ZMCCookBookDetailViewController.h"




@interface ZMCMenuDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZMCMenuDetailTableViewCell *cell;

@property (nonatomic, strong) UITableView *menuTableView;
/**
 *  保存cell内容的模型数组
 */
@property (nonatomic, strong) NSArray *detailArry;

@property (nonatomic, strong) NSMutableDictionary *resultDic;


@property (nonatomic, weak) ZMCMenuDetailTableHeaderView *headerView;

@end


static NSString *cellReuseId = @"cell";
@implementation ZMCMenuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"菜单详情";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"caipushare"] highImage:nil target:self action:@selector(shareRecipes) title:nil];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [self setHeaderView];
    
    [self loadDataId:_detail_id];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setHeaderView{
    _headerView = [ZMCMenuDetailTableHeaderView instanceHeaderView];
    self.menuTableView.tableHeaderView = _headerView;
    [self.view addSubview:self.menuTableView];
    
    [_headerView.deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 删除宴会
- (void)deleteClick{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        
        NSString *deleteStr = [NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/cookbook/share/delete/%@?access_token=%@", _detail_id, token];
        
        __weak typeof(self) blockself = self;
        [HYBNetworking postWithUrl:deleteStr refreshCache:YES params:nil success:^(id response) {
            
            if ([response[@"err_msg"] isEqualToString:@"OK"]) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [blockself.navigationController popViewControllerAnimated:YES];
                    [SVProgressHUD dismiss];
                });
            }else{
//                [SVProgressHUD showInfoWithStatus:response[@"err_msg"]];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
                ALERT_MSG(nil, response[@"err_msg"]);
            }
            
        } fail:^(NSError *error) {
            ZMCLog(@"删除宴会失败");
        }];
        
    }];
    
}


#pragma mark - 右上角分享按钮
- (void)shareRecipes{
    if ([_resultDic[@"status_name"] isEqualToString:@"已结束"]) {
        ALERT_MSG(@"提示", @"对不起，该宴会已结束");
    }else{
        
        NSString *idStr = [NSString stringWithFormat:@"http://weixin.zenmechi.cc/?from=groupmessage&isappinstalled=0#chooseMenu/%@", _resultDic[@"id"]];
        HZZCustomShareView *shareView = [HZZCustomShareView shareViewWithPresentedViewController:self items:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone] title:_resultDic[@"title"] content:@"我在怎么吃分享了菜谱，快来点菜吧~" image:[UIImage imageNamed:@"fenxiang"] urlResource:nil shareUrl:idStr];
        [[UIApplication sharedApplication].keyWindow addSubview:shareView];
    }
    
}


- (UITableView *)menuTableView
{
    if (!_menuTableView) {
        _menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
        _menuTableView.delegate = self;
        _menuTableView.dataSource = self;
        _menuTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTableView.backgroundColor = RGB(241, 241, 241);
        [_menuTableView registerNib:[UINib nibWithNibName:@"ZMCMenuDetailTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    }
    return _menuTableView;
}

- (void)loadDataId:(NSNumber *)Id{
    
    [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
        NSString *urlStr = [NSString stringWithFormat:uCMyDetail, Id, token];
        
        [HYBNetworking getWithUrl:urlStr refreshCache:YES success:^(id response) {
            [ZMCMyDetailItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{@"detail_Id" : @"id"};
            }];
            
            _resultDic = response[@"result"];
            _detailArry = [ZMCMyDetailItem mj_objectArrayWithKeyValuesArray:response[@"result"][@"cookbook_members"]];
            ZMCMyDetailHeaderItem *item = [ZMCMyDetailHeaderItem mj_objectWithKeyValues:response[@"result"]];
            _headerView.item = item;
            [self.menuTableView reloadData];
            [SVProgressHUD dismiss];
        } fail:^(NSError *error) {
            
        }];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- tableview协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _detailArry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell.item = _detailArry[indexPath.row];
    
    _cell.dishPictureOne.userInteractionEnabled = YES;
    _cell.dishPictureTwo.userInteractionEnabled = YES;
    _cell.dishPictureThree.userInteractionEnabled = YES;
    
    
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onePicClick:)];
    [_cell.dishPictureOne addGestureRecognizer:tapOne];
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoPicClick:)];
    [_cell.dishPictureTwo addGestureRecognizer:tapTwo];
    UITapGestureRecognizer *tapThree = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(threePicClick:)];
    [_cell.dishPictureThree addGestureRecognizer:tapThree];
    
    return _cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 225;
}


/**
 *  第一张图片点击
 */
- (void)onePicClick:(UITapGestureRecognizer *)ges{
    ZMCLog(@"点击了第一张图片");
    // 算出图片所在cell的indexpath.row
    CGPoint point = ((UIImageView *)ges.view).center;
    point = [self.menuTableView convertPoint:point fromView:((UIImageView *)ges.view).superview];
    NSIndexPath *indexpath = [self.menuTableView indexPathForRowAtPoint:point];
    ZMCLog(@"%ld", indexpath.row);
    
    // 跳转
    [self istodetailVc:indexpath.row count:0];
}
/**
 *  第二张图片点击
 */
- (void)twoPicClick:(UITapGestureRecognizer *)ges{
    ZMCLog(@"点击了第二张图片");
    CGPoint point = ((UIImageView *)ges.view).center;
    point = [self.menuTableView convertPoint:point fromView:((UIImageView *)ges.view).superview];
    NSIndexPath *indexpath = [self.menuTableView indexPathForRowAtPoint:point];
    ZMCLog(@"%ld", indexpath.row);
    
    [self istodetailVc:indexpath.row count:1];
}
/**
 *  第三张图片点击
 */
- (void)threePicClick:(UITapGestureRecognizer *)ges{
    ZMCLog(@"点击了第三张图片");
    CGPoint point = ((UIImageView *)ges.view).center;
    point = [self.menuTableView convertPoint:point fromView:((UIImageView *)ges.view).superview];
    NSIndexPath *indexpath = [self.menuTableView indexPathForRowAtPoint:point];
    ZMCLog(@"%ld", indexpath.row);
    
    [self istodetailVc:indexpath.row count:2];
}
/**
 *  判断是否跳转
 */
- (void)istodetailVc:(NSInteger)cellrow count:(NSInteger)count{
    ZMCMyDetailItem *item = _detailArry[cellrow];
    if (item.bookcook_selected.count != 0) {
        NSString *urlStr = [NSString stringWithFormat:uCDetail, [item.bookcook_selected[count][@"cookbook_id"] longValue]];
        [HYBNetworking getWithUrl:urlStr refreshCache:NO success:^(id response) {
            ZMCLog(@"------>>>%@", response[@"err_msg"]);
            if ([response[@"err_code"]  isEqual: @10000]) {
                [SVProgressHUD showInfoWithStatus:response[@"err_msg"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }else{
                ZMCCookBookDetailViewController *detailVC = [[ZMCCookBookDetailViewController alloc] init];
                detailVC.cookBookID = [item.bookcook_selected[count][@"cookbook_id"] longValue];
                detailVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        } fail:^(NSError *error) {
            
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"无此菜品"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];

        });
    }

}


@end
