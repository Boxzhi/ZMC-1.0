//
//  ZMCCookBookDetailViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCookBookDetailViewController.h"
#import "UINavigationBar+Awesome.h"
#import "ZMCDetailTableHeaderView.h"
#import "ZMCIngredientTableViewCell.h"
#import "ZMCSeasoningsTableViewCell.h"
#import "ZMCCookToHomeViewController.h"

#import "CookBookNetwork.h"
#import "BottomCookBookDetailModel.h"
#import "CookBookDetailFoodMaterialModel.h"
#import <UIImageView+WebCache.h>
#import "ZMCIngredientsItem.h"
#import "ZMCBasketViewController.h"

#import "SureChooseCookerView.h"
#import "ChoseCookerToHomeView.h"
#import "ZMCBasketViewController.h"

@interface ZMCCookBookDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _webCount;
    
    BOOL _isOpen;
    
    BottomCookBookDetailModel *_deatilModel;
    
    
    SureChooseCookerView *sureChoseView;
    
}
@property (nonatomic, strong) UITableView *detailTableView;

@property (nonatomic, weak) ZMCDetailTableHeaderView *tableHeader;

@property (nonatomic, strong) NSDictionary *ingredientsDic;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UILabel *label;

@end


static NSString *cellReuseId = @"cell";
static NSString *ingredientCellReuseId = @"ingredient";
static NSString *seasoningsCellReuseId = @"seasonings";
@implementation ZMCCookBookDetailViewController

#pragma mark- viewController生命周期
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:YES];
    _detailTableView.delegate = self;
    [self scrollViewDidScroll:_detailTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = ThemeGreenColor;
    _detailTableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    
    [SVProgressHUD dismiss];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    导航栏透明
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];

//    从xib加载表头
    _tableHeader = [ZMCDetailTableHeaderView instanceHeaderView];
    self.detailTableView.tableHeaderView = _tableHeader;
    [self.view addSubview:self.detailTableView];
    _tableHeader.dishPicture.contentMode = UIViewContentModeScaleAspectFill;
    
//    加载底部按钮
    [self.view addSubview:[self createBottomButton]];
    [self.view addSubview:[self basketButton]];
    
    [self loadData];
    
    
}


#pragma mark - 加载数据
- (void)loadData{
    [CookBookNetwork requestDishDetailWithDish:_cookBookID andComplete:^(BottomCookBookDetailModel *model) {
        _deatilModel = model;
//        self.navigationItem.title = model.name;
        
        UIView *titleView = [[UIView alloc] init];
        self.navigationItem.titleView = titleView;
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor whiteColor]];
        label.text = model.name;
        [label sizeToFit];
        label.center = CGPointMake(titleView.center.x, 0);
        [titleView addSubview:label];
        self.label = label;
        
        
        [self setHeaerView];
        [_detailTableView reloadData];
        [SVProgressHUD dismiss];
    }];
}


#pragma mark - 添加底部按钮
//添加底部的雇佣大厨的按钮
- (UIButton *)createBottomButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight - 44, 0.62 * kScreenWidth, 44);
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    [button setTitle:@"雇佣大厨" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickToEmployCook) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

// 添加底部的菜篮子按钮
- (UIButton *)basketButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.62 * kScreenWidth, kScreenHeight - 44, 0.38 * kScreenWidth, 44);
    btn.backgroundColor = ThemeGreenColor;
    [btn setImage:[UIImage imageNamed:@"Cart"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Cart"] forState:UIControlStateHighlighted];
    [btn setTitle:@"菜篮子" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBasket) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

//根据model，给表头设置数据
- (void)setHeaerView
{
        [_tableHeader.dishPicture sd_setImageWithURL:[NSURL URLWithString:_deatilModel.detail_pic] placeholderImage:[UIImage imageNamed:@"caipuxiangqing"]];
    
    if (_deatilModel.favorite_count != NULL) {
        _tableHeader.favoriteNumber.text = [NSString stringWithFormat:@"%@人收藏",_deatilModel.favorite_count];
    }else{
        _tableHeader.favoriteNumber.text = @"0人收藏";
    }
    
    _tableHeader.dishName.text = _deatilModel.name;
    
    _tableHeader.introduction.text = _deatilModel.short_intro;
}

//加载tableview
- (UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight -44 +64) style:UITableViewStyleGrouped];
        [_detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
        [_detailTableView registerNib:[UINib nibWithNibName:@"ZMCIngredientTableViewCell" bundle:nil] forCellReuseIdentifier:ingredientCellReuseId];
        [_detailTableView registerNib:[UINib nibWithNibName:@"ZMCSeasoningsTableViewCell" bundle:nil] forCellReuseIdentifier:seasoningsCellReuseId];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = [UIColor whiteColor];
        _detailTableView.separatorColor = UIColorFromRGB(0xf4f4f4);
    }
    return _detailTableView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- 根据偏移量，设置导航条背景颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    UIColor * color = ThemeGreenColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -64.0) {
        _tableHeader.dishPicture.frame = CGRectMake(offsetY / 2 + 32, offsetY + 65, kScreenWidth - offsetY - 64, kScreenWidth * 56 / 75 - offsetY - 64);
    }else{
        _tableHeader.dishPicture.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 56 / 75);
    }
    
    if (offsetY > -64.0) {
        CGFloat alpha = MIN(1, (64 +offsetY)/214.0);
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        
        self.label.alpha = alpha;
        
    } else {
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        
        self.label.alpha = 0;
 
    }
    
    ZMCLog(@"%f------>>%f--->>%f--->>%f--->>%F", scrollView.contentOffset.y, _tableHeader.dishPicture.frame.origin.x, _tableHeader.dishPicture.frame.origin.y, _tableHeader.dishPicture.frame.size.width, _tableHeader.dishPicture.frame.size.height);
}


#pragma mark- tableview协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _deatilModel.foodmaterials.count;
    }
    if (section == 1) {
        return _deatilModel.ingredients_lists.count;
    }
    
    return _webCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        ZMCIngredientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ingredientCellReuseId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.addBasketButton.tag = indexPath.row + 450;
        [cell.addBasketButton addTarget:self action:@selector(addToBasket:) forControlEvents:UIControlEventTouchUpInside];
        
        CookBookDetailFoodMaterialModel *model = _deatilModel.foodmaterials[indexPath.row];
        
        
        [cell.ingredientPicture sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"home_square"]];
        cell.ingredientName.text = model.name;
        cell.ingredientPrice.text = [NSString stringWithFormat:@"%@元",model.price];
        cell.ingredientCount.text = [NSString stringWithFormat:@"%@", model.weight];
        cell.unitAndUnit_name.text = [NSString stringWithFormat:@"/%@%@",model.unit,model.unit_name];
        return cell;
    }
    if (indexPath.section == 1) {
        ZMCSeasoningsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:seasoningsCellReuseId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        ZMCIngredientsItem *item = _deatilModel.ingredients_lists[indexPath.row];
        _ingredientsDic = [item mj_JSONObject];
        
        cell.kindOne.text = [NSString stringWithFormat:@"%@", _ingredientsDic[@"name"]];
        cell.countOne.text = [NSString stringWithFormat:@"%@", _ingredientsDic[@"quantity"]];

        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];

    
    
    UIWebView *webView = (UIWebView *)[cell viewWithTag:100];
    if (!webView) {
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 155)];
        webView.tag = 100;

        webView.backgroundColor = [UIColor whiteColor];
        NSString *htmlStr = [NSString stringWithFormat:@"<html><body>%@</body></html>", _deatilModel.intro];
        [webView loadHTMLString:htmlStr baseURL:nil];
        
        [cell addSubview:webView];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 111 ;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return kScreenHeight - 155;
            break;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    0区和1区是同一种格式的区头
    if (section == 0 || section == 1) {
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth -20, 40)];
        label.text = section == 0 ?@"主料": @"辅料";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = StringMiddleColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = UIColorFromRGB(0xf4f4f4);
        label.layer.cornerRadius = 4;
        label.layer.masksToBounds= YES;
        [view addSubview:label];
        return view;
    }
//    2区单独一种区头，点击按钮可以展开一个网页
    if (section == 2) {
        UIView *view = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 35, 40)];
        label.text = @"步骤";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = StringMiddleColor;
        [view addSubview:label];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 10 -14, 16, 14, 8)];
        imageView.image = [UIImage imageNamed:@"xiala_icon"];
        
        CGFloat angle = _isOpen ? 0: -M_PI_2;
        imageView.transform = CGAffineTransformMakeRotation(angle);
        imageView.tag = 10;
        [view addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToExpand:)];
        [view addGestureRecognizer:tap];
        return view;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = section == 0?[UIColor whiteColor]: UIColorFromRGB(0xf4f4f4);
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark- 点击加入购物车按钮的方法
- (void)addToBasket:(UIButton *)cartButton
{
    if (TOKEN) {
        
        NSInteger cellrow = cartButton.tag - 450;
        CookBookDetailFoodMaterialModel *model = _deatilModel.foodmaterials[cellrow];
        
        NSString *good_id = [NSString stringWithFormat:@"%@", model.goods_id];
        
        [CommonHttpAPI postGoodsIncreaseWithParameters:[CommonRequestModel getGoodsIncreaseryWithItem_id:good_id quantity:@"1" start_time:@"" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
            
            ZMCLog(@"%@",responseObject);
            
            
            
            if ([responseObject getTheResultForDic]) {
                
                [SVProgressHUD showSuccessWithStatus:@"已加入菜篮子"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
            }else {
                
                [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
                
            }
            
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            ZMCLog(@"%@",error);
        }];
        
    }else{
        [self presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
    }
//    ALERT_MSG(@"温馨提示", @"加入购物车成功！");
}

#pragma mark- 点击最下面的雇佣大厨按钮
- (void)clickToEmployCook
{
    ZMCCookToHomeViewController *cookVC = [[ZMCCookToHomeViewController alloc] init];
    [self.navigationController pushViewController:cookVC animated:YES];
//    __weak typeof(self)weakSelf = self;
//    
//    sureChoseView = [[SureChooseCookerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
//
//    [self.view addSubview:sureChoseView];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
//    
//    [sureChoseView.alphaiView addGestureRecognizer:tap];
//    
//    [sureChoseView.addChoseCookerView.sureChoseCookerButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];

    
}

//-(void)dismiss {
//    
//    __weak typeof(self)weakSelf = self;
//    
//    center.y = center.y+self.view.frame.size.height;
//    
//    [UIView animateWithDuration: 0.35 animations: ^{
//        
//        sureChoseView.frame =CGRectMake(0, weakSelf.view.frame.size.height, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
//        
//        weakSelf.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        
//        weakSelf.view.center = weakSelf.view.center;
//        
//    } completion: nil];
//    
//}

//- (void)sure {
//    
//    if ((sureChoseView.addChoseCookerView.timeString == nil || [sureChoseView.addChoseCookerView.getTimeTF.text isEqualToString:@""])) {
//        
//        [SVProgressHUD showErrorWithStatus:@"请选择上门时间或服务时长"];
//        
//        [self performSelector:@selector(dismissSVP) withObject:nil afterDelay:1.5];
//        
//    }else {
//        
//        NSDictionary *dict = @{
//                               @"item_id" : self.cook_id,
//                               @"quantity" : sureChoseView.addChoseCookerView.timeString,
//                               @"start_time" : sureChoseView.addChoseCookerView.getTimeTF.text,
//                               @"type" : @2
//                               };
//        [HomeNetwork sureOfTheCookerToHome:dict andCompleteBlock:^(NSString *cookString) {
//            
//            
//            if ([cookString isEqualToString:@"OK"]) {
//                
//                [SVProgressHUD showSuccessWithStatus:@"雇佣成功"];
//                
//                [self performSelector:@selector(dismissSVPSuess) withObject:nil afterDelay:1.5];
//            }else {
//                
//                [SVProgressHUD showErrorWithStatus:cookString];
//                
//                [self performSelector:@selector(dismissSVP) withObject:nil afterDelay:1.5];
//            }
//        }];
//    }
//}
//
//- (void)dismissSVPSuess {
//    
//    [SVProgressHUD dismiss];
//    
//}
//
//- (void)dismissSVP {
//    
//    [SVProgressHUD dismiss];
//    
//}

#pragma maek - 最下面菜篮子按钮点击
- (void)goBasket{
//    ZMCBasketViewController *basketVc = [[ZMCBasketViewController alloc] init];
//    self.tabBarController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:basketVc animated:YES];
    self.tabBarController.selectedIndex = 3;
}

#pragma mark- 点击查看详细的步骤
- (void)clickToExpand:(UIGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)[gesture.view viewWithTag:10];
    CGFloat angle = _isOpen ? 0 : - M_PI_2;
    imageView.transform = CGAffineTransformMakeRotation(angle);
    
    _isOpen = !_isOpen;

    
    _webCount = _isOpen? 1:0;
    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:2];
    [_detailTableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSIndexPath *indexPath = _isOpen? [NSIndexPath indexPathForRow:0 inSection:2] : [NSIndexPath indexPathForRow:_deatilModel.ingredients_lists.count - 1  inSection:1];
    
    [_detailTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}



- (void)dealloc
{
    
}
@end
