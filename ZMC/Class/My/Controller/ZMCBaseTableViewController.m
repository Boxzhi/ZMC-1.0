//
//  ZMCBaseTableViewController.m
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCBaseTableViewController.h"
@interface ZMCBaseTableViewController ()

@end

@implementation ZMCBaseTableViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    self.view.backgroundColor = RGB(244, 244, 244);
}

- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}
//- (void)viewDidLoad
//{
//    // 注册cell
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZMCOrderCell class]) bundle:nil]  forCellReuseIdentifier:@"myOrderCell"];
//}
- (NSMutableArray *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 取出组模型
    ZMCMyGroupItem *group = self.groups[section];
    return group.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 5;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 40;
    }else{
        return 5;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
    header.backgroundColor = UIColorFromRGB(0xF1F1F1);
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        footer.backgroundColor = UIColorFromRGB(0xF1F1F1);
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"iPhone版 V%@", CLIENT_VERSION];
        [label setFont:[UIFont systemFontOfSize:11.0f]];
        label.textColor = RGB(124, 126, 132);
        [footer addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(footer.mas_centerX);
            make.centerY.equalTo(footer.mas_centerY);
        }];
        
        return footer;
    }else{
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        footer.backgroundColor = UIColorFromRGB(0xF1F1F1);
        return footer;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZMCMyCell *cell = [ZMCMyCell cellWithTabelView:tableView];
    
    // 取出组模型
    ZMCMyGroupItem *group = self.groups[indexPath.section];
    // 取出行模型
//    NSLog(@"-----%ld",indexPath.row);
    ZMCMyItem *item = group.items[indexPath.row];
    cell.item = item;
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 取出组模型
    ZMCMyGroupItem *group = self.groups[indexPath.section];
    // 取出行模型
    ZMCMyItem *item = group.items[indexPath.row];
    
    if (item.operationBlock) {
        item.operationBlock(indexPath);
    }else if ([item isKindOfClass:[ZMCMyArrowItem class]]) {
        // 只有箭头模型才具备跳转
        ZMCMyArrowItem *arrowItem = (ZMCMyArrowItem *)item;
        if (arrowItem.desVc) {
            UIViewController *vc = [[arrowItem.desVc alloc] init];
            
            vc.navigationItem.title = item.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    ZMCMyGroupItem *group = self.groups[section];
//    NSLog(@"hederTitle-----%@",group.hederTitle);
//    return group.hederTitle;
//}
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    ZMCMyGroupItem *group = self.groups[section];
//    return group.footTitle;
//}

@end
