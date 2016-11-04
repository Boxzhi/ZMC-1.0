//
//  ZMCCookToHomeViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCookToHomeViewController.h"
#import "ZMCCookTableViewCell.h"
#import "ZMCCookDetailViewController.h"
#import "ZMCSelectCookTimeViewController.h"
#import "HomeNetwork.h"
#import "ACookModel.h"

#import <UIImageView+WebCache.h>

@interface ZMCCookToHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *_historyCooks;
    
    NSArray *_recommendCooks;
    
}

@property (nonatomic, strong) UITableView *cookTableView;
@end

static NSString *cellReuseId = @"cell";
@implementation ZMCCookToHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"大厨到家";
//    NSLog(@"%@",Market_id);
    [HomeNetwork requestCookListWithPage:1 andCompleteBlock:^(NSArray *array1, NSArray *array2) {
        _historyCooks = array1;
        _recommendCooks = array2;
        [_cookTableView reloadData];
    }];
    
    [self.view addSubview:self.cookTableView];
}

- (UITableView *)cookTableView
{
    if (!_cookTableView) {
        _cookTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -64) style:UITableViewStylePlain];
        _cookTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //隐藏分割线
        [_cookTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _cookTableView.showsVerticalScrollIndicator = NO;
        _cookTableView.delegate = self;
        _cookTableView.dataSource = self;
        _cookTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [_cookTableView registerNib:[UINib nibWithNibName:@"ZMCCookTableViewCell" bundle:nil] forCellReuseIdentifier:cellReuseId];
    }
    return _cookTableView;
}

#pragma mark- tableview的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_historyCooks.count == 0) {
        
        return 1;
    }else {
       return 2;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_historyCooks.count == 0) {
        
        return _recommendCooks.count;
    }else {
        return section == 0 ? _historyCooks.count : _recommendCooks.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCCookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    
    if (_historyCooks.count == 0) {
        
        ACookModel *model = _recommendCooks[indexPath.row];
        [cell.cookHeaderView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"dachu"]];
        cell.cookName.text = model.name;
        cell.cookAgeAndFrom.text = [NSString stringWithFormat:@"%@岁 | %@",model.age,model.birth_place];
        NSDictionary *dict = model.cook_books[0];
        cell.dishName.text = dict[@"name"];
        cell.cookStyle.text = model.food_category;
        
        //星星，星星图片和星级对应起来
        cell.markStarsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallstar_%d",[model.star intValue]/2]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        
        if (indexPath.section == 0) {
            
            ACookModel *model = _historyCooks[indexPath.row];
            [cell.cookHeaderView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"dachu"]];
            cell.cookName.text = model.name;
            cell.cookStyle.text = model.food_category;
            cell.cookAgeAndFrom.text = [NSString stringWithFormat:@"%@岁 | %@",model.age,model.birth_place];
            
            //星星，星星图片和星级对应起来
            cell.markStarsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallstar_%d",[model.star intValue]/2]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        } else {
            ACookModel *model = _recommendCooks[indexPath.row];
            [cell.cookHeaderView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"dachu"]];
            cell.cookName.text = model.name;
            cell.cookAgeAndFrom.text = [NSString stringWithFormat:@"%@岁 | %@",model.age,model.birth_place];
            
            //星星，星星图片和星级对应起来
            cell.markStarsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"smallstar_%d",[model.star intValue]/2]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 63, 20)];
    if (_historyCooks.count == 0) {
        
        label.text = @"大厨推荐";
    }else {
        
        label.text = section==0 ?@"历史大厨":@"大厨推荐";
    }
    label.textColor = StringMiddleColor;
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}


// 选中表中的某一行,跳转到大厨详情界面
// 大厨拿手菜可以重用菜谱界面的自定义单元格
// 和菜谱详情界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZMCCookDetailViewController *cookDetailVC = [[ZMCCookDetailViewController alloc] init];
    
    if (_historyCooks.count == 0) {
        
        ACookModel *model = _recommendCooks[indexPath.row];
        
        cookDetailVC.cook_id = model.ID;
    }else {
        
        ACookModel *model = indexPath.section == 0? _historyCooks[indexPath.row] : _recommendCooks[indexPath.row];
        
        cookDetailVC.cook_id = model.ID;
    }
    
    [self.navigationController pushViewController:cookDetailVC animated:YES];
    
}
@end
