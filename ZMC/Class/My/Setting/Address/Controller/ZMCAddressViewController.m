//
//  ZMCAddressViewController.m
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAddressViewController.h"
#import "ZMCAddressTableViewCell.h"
#import <Masonry.h>
#import "ZMCAddreceiptViewController.h"
#import "ZMCReviseViewController.h"
#import "Address+CoreDataProperties.h"
#import "AppDelegate.h"
#import "ZMCAddressManger.h"
#import "ZMCPickerViewItem.h"



static NSString *addressID = @"addressID";

@interface ZMCAddressViewController ()<UITableViewDelegate, UITableViewDataSource, WeChatStylePlaceHolderDelegate>

//@property (nonatomic, strong) NSManagedObjectContext *myContext;

@property (nonatomic, strong) NSMutableArray *cellArr;


@property (weak, nonatomic) IBOutlet UITableView *contentTableView;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@end


@implementation ZMCAddressViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.is_order == 9999) {
        self.title = @"选择收货地址";
    }else
        self.title = @"管理收货地址";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    self.myContext = delegate.managedObjectContext;
//    self.allData = [NSMutableArray array];
    
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    
    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCAddressTableViewCell class]) bundle:nil] forCellReuseIdentifier:addressID];
    
    [self.addressBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentTableView.rowHeight = UITableViewAutomaticDimension;
    self.contentTableView.estimatedRowHeight = 40.0f;

    // 隐藏cell间的黑线
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
   
    [SVProgressHUD showWithStatus:@"正在加载..."];
    

}



- (void)loadData{
    [ZMCAddressManger getressMgResult:^(NSDictionary *result) {
        
        [ZMCPickerViewItem  mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"id_":@"id"};
        }];
        
        
//        if ([result[@"error"] isEqualToString:@"YES"]) {
//            [SVProgressHUD dismiss];
//            
//            __weak typeof (self) weakSelf = self;
//            [self.contentTableView setFooterViewNetWorkError:isReachable_client withBlock:^{
//                ZMCLog(@"重新加载网络数据");
//                [weakSelf.contentTableView.tableFooterView removeFromSuperview];
//                [weakSelf loadData];
//            }];
//        }else{
        
            id cellArray = result[@"data"];
            if ([cellArray isKindOfClass:[NSArray class]]) {
                _cellArr = [ZMCPickerViewItem mj_objectArrayWithKeyValuesArray:result[@"data"]];
                
                [self.contentTableView cyl_reloadData];
                
                [SVProgressHUD dismiss];
            }
            
//        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    [self loadData];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 获取数据库中的收货地址
/*
- (void)getAllDataFromCoreData{
  
    
    AppDelegate * delegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext * context = delegate.managedObjectContext;
    
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Address" inManagedObjectContext:context];
 
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    request.entity = entity;

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

    // 获取查询到的内容---是数组
    NSError *error = nil;
    NSArray * array = [context executeFetchRequest:request error:&error];
    [_allData removeAllObjects];
    [_allData addObjectsFromArray:array];
    //遍历查询到的数据,并打印
    if (array == nil) {
        ZMCLog(@"数据错误%@", error);
    }else{
        for (Address * addre in array) {
            ZMCLog(@"%@ %@ %@", addre.name, addre.number, addre.address);
            [self.tableView reloadData];
        }
    }
    
}
*/

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _allData.count;
    return _cellArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMCAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addressID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    /*
    Address *address = self.allData[indexPath.row];
    cell.nameLabel.text = address.name;
    cell.phoneLabel.text = address.number;
    cell.addressLabel.text = [NSString stringWithFormat:@"%@%@", address.provinces, address.address];
    cell.nameLabel.text = _cellDic[@"consignee"];
    cell.phoneLabel.text = _cellDic[@"mobile"];
    
    NSString *is_default = _cellDic[@"is_default"];
    
    if ([is_default isEqualToString:@"YES"]) {
        NSString *str = @"默认";
        cell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@", str, _cellDic[@"province_name"], _cellDic[@"city_name"], _cellDic[@"district_name"], _cellDic[@"street_address"]];
    }else{
        NSString *str = @"";
        cell.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@", str, _cellDic[@"province_name"], _cellDic[@"city_name"], _cellDic[@"district_name"], _cellDic[@"street_address"]];
    }
    */
    
    cell.item = _cellArr[indexPath.row];
    return cell;
    
}



//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 80;
//}
//
//#pragma mark - 添加地址View
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footView = [[UIView alloc] init];
//
//    UIButton *arButton = [[UIButton alloc] init];
//    [arButton setTitle:@"+添加新地址" forState:UIControlStateNormal];
//    arButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    [arButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
//    [arButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [footView addSubview:arButton];
//    
//    [arButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.bottom.equalTo(footView);
//
//    }];
//    footView.backgroundColor = UIColorFromRGB(0xf4f4f4);
//    
//    return footView;
//}


- (void)buttonClick{
    ZMCAddreceiptViewController *receiptVc = [[ZMCAddreceiptViewController alloc] init];
    [self.navigationController pushViewController:receiptVc animated:YES];
}

#pragma mark - 点击地址的cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.is_order == 9999) {
        
//        ZMCPickerViewItem *item = [[ZMCPickerViewItem alloc] init];
        ZMCPickerViewItem *item = _cellArr[indexPath.row];
        
        [self.navigationController popViewControllerAnimated:YES];
        self.getAddress(item.consignee,item.mobile,[NSString stringWithFormat:@"%@%@%@%@",item.province_name,item.city_name,item.district_name,item.street_address],[NSString stringWithFormat:@"%@",item.id_]);
        
    }else {
        ZMCLog(@"点击了地址的cell");
        ZMCReviseViewController *reviseVc = [[ZMCReviseViewController alloc] init];
        reviseVc.allData = _cellArr;
        reviseVc.cellRow = indexPath.row;
        [self.navigationController pushViewController:reviseVc animated:YES];
    }
    
}

#pragma mark - 左滑删除
// 进入编辑模式, 使其有左滑删除功能
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //获取当前cell代表的数据
        Address *add = _allData[indexPath.row];
        
        //修改数据源
        [self.allData removeObject:add];
        
        //更新UI
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        //将临时数据库里进行删除并进行本地持久化
        [self.myContext deleteObject:add];
        
        [self.myContext save:nil];
        
        [self.tableView reloadData];
    }
    */
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        //  点击删除按钮调用
        
            //获取当前cell代表的数据
//            Address *add = _allData[indexPath.row];
        
            //修改数据源
//            [self.allData removeObject:add];
        ZMCPickerViewItem *item = _cellArr[indexPath.row];
        [ZMCAddressManger deldteAddressId:item.id_ result:^(NSDictionary *result) {
            
            if ([result[@"err_code"] integerValue] != 0) {
                [SVProgressHUD showErrorWithStatus:result[@"err_msg"]];
                [self performSelector:@selector(SVPdismiss) withObject:nil afterDelay:2];
                
            }else{
                
                [self.cellArr removeObjectAtIndex:indexPath.row];
                //更新UI
                [self.contentTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                [self.contentTableView cyl_reloadData];
            }
        }];
        
        
            //将临时数据库里进行删除并进行本地持久化
//            [self.myContext deleteObject:add];
        
//            [self.myContext save:nil];
        

    }];
    UITableViewRowAction *editRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        // 点击编辑按钮调用
        ZMCReviseViewController *reviseVc = [[ZMCReviseViewController alloc] init];
        reviseVc.allData = _cellArr;
        reviseVc.cellRow = indexPath.row;
        [self.navigationController pushViewController:reviseVc animated:YES];
    }];
    
    deleteRoWAction.backgroundColor = RGB(255, 37, 55);
    editRowAction.backgroundColor = RGB(0, 124, 223);
    return @[deleteRoWAction,editRowAction];
}


- (void)SVPdismiss{
    [SVProgressHUD dismiss];
}


- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.contentTableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu.png";
    weChatStylePlaceHolder.title = @"没有收货地址";
    weChatStylePlaceHolder.content = @"点击下方按钮新增";
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}


@end
