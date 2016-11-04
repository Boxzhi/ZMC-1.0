//
//  CookDetailViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/4/21.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCCookDetailViewController.h"
#import "ZMCSelectCookTimeViewController.h"
#import "ZMCCookJudgeViewController.h"
#import "UINavigationBar+Awesome.h"
#import "ZMCCookBookTVCell.h"

#import "HomeNetwork.h"
#import "CookDetailInfoModel.h"
#import <UIImageView+WebCache.h>

#import "ZMCCookBookDetailViewController.h"

#import "CookBookModel.h"
#import "CommentsVC.h"

#import "SureChooseCookerView.h"
#import "ChoseCookerToHomeView.h"
#import "CookPickView.h"


@interface ZMCCookDetailViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate, UITextFieldDelegate, CookPickViewDelegate>

{
    CGPoint center;
    
    NSArray *cookBookArray;
    
    NSArray *_markArray;
    
    UIView *_naviView;
    
    UIView *_bgView;
    
    NSNumber *greensId;
    
    CookDetailInfoModel *_cookInfoModel;
    
    SureChooseCookerView *sureChoseView;
    
}
@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) NSMutableArray *cookNsmuArray;
@property (nonatomic, strong) NSMutableArray *arrayMark;
@property (nonatomic, strong) NSNumber *cookPrice;
@property (nonatomic, strong) CookPickView *cuiPickerView;
@end

static NSString *cellReuseId = @"cell";
static NSString *cookCellReuseId = @"CookBookCell";
@implementation ZMCCookDetailViewController

- (NSMutableArray *)cookNsmuArray {
    
    if (!_cookNsmuArray) {
        
        self.cookNsmuArray = [NSMutableArray array];
    }
    return _cookNsmuArray;
}

- (NSMutableArray *)arrayMark {
    
    if (!_arrayMark) {
        
        self.arrayMark = [NSMutableArray array];
    }
    return _arrayMark;
}

#pragma mark- viewcontroller生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    self.navigationItem.title = @"大厨详情";
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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    
    [HomeNetwork requestCookDetailWithCook:_cook_id andCompleteBlock:^(CookDetailInfoModel *model) {
        _cookInfoModel = model;
        
        NSArray *markArrayes = _cookInfoModel.labels;
        
        self.cookPrice = _cookInfoModel.price;
        
        for (NSDictionary *dict in markArrayes) {
            
            NSString *string = [NSString stringWithFormat:@"%@(%@)", dict[@"label_name"], dict[@"quantity"]];
            
            [self.arrayMark addObject:string];
        }
        _detailTableView.tableHeaderView = [self getHeaderView];
        
        _markArray = self.arrayMark;
  
        [_detailTableView reloadData];
    }];
    
    
    
    [self.view addSubview:self.detailTableView];
    
    
    
    [self createBottonButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBackgroundView) name:@"dismissVC" object:nil];
    
    [self getCookBookData];
}

- (void)getCookBookData {
    
    [HomeNetwork getCookerOfHisCook_books:_cook_id andComplockBlock:^(NSArray *cookArray) {
        
        cookBookArray = cookArray;
        
        for (NSDictionary *dic in cookBookArray) {
            CookBookModel *cookModel = [CookBookModel new];
            [cookModel setValuesForKeysWithDictionary:dic];
            
            [self.cookNsmuArray addObject:cookModel];
        }
        [_detailTableView reloadData];
    }];
}

- (UITableView *)detailTableView
{
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight -44 +64) style:UITableViewStylePlain];
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        
        [_detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
        _detailTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [_detailTableView registerNib:[UINib nibWithNibName:@"ZMCCookBookTVCell" bundle:nil] forCellReuseIdentifier:cookCellReuseId];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _detailTableView.tableHeaderView = [self getHeaderView];

    }
    return _detailTableView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//创建底部的选择雇佣大厨时间按钮
- (void)createBottonButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:ThemeGreenColor];
    [button setTitle:@"我要雇佣大厨" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(clickToEmployCook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44);
}

#pragma mark- 设置表头,主要是大厨的头像,名字,评分的信息
- (UIView *)getHeaderView
{
    //    模糊的背景图片
    UIImageView *bgImage = [[UIImageView alloc] init];
    bgImage.frame = CGRectMake(0, 0, kScreenWidth, 279);
    bgImage.image = [UIImage imageNamed:@"beijing"];
    
    //    清晰的头像
    UIImageView *headImage = [[UIImageView alloc] init];
    [headImage sd_setImageWithURL:[NSURL URLWithString:_cookInfoModel.avatar] placeholderImage:[UIImage imageNamed:@"dachu"]];
    headImage.layer.cornerRadius = 135/2.0;
    headImage.layer.masksToBounds = YES;
    headImage.layer.borderWidth = 2;
    headImage.layer.borderColor = [UIColor orangeColor].CGColor;
    [bgImage addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(135, 135));
        make.center.equalTo(bgImage);
    }];
    
    //    大厨的名字
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = _cookInfoModel.name;
    [bgImage addSubview:nameLabel];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgImage);
        make.centerY.equalTo(headImage).offset(83);
        make.size.mas_equalTo(CGSizeMake(64, 16));
        
    }];
    
    //    大厨的评分
    UILabel *markLabel = [[UILabel alloc] init];
    markLabel.textColor = [UIColor orangeColor];
    markLabel.font = [UIFont systemFontOfSize:18];
    markLabel.text = [NSString stringWithFormat:@"%.1f",[_cookInfoModel.star intValue]/2.0];
    [bgImage addSubview:markLabel];
    [markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headImage);
        make.bottom.equalTo(nameLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 18));
    }];
    
    //    大厨的评分对应的星星
    //根据不同的评分加载不同的星星图片
    UIImageView *starsImage = [[UIImageView alloc] init];
    starsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"star_%d",[_cookInfoModel.star intValue]/2]];
    [bgImage addSubview:starsImage];
    [starsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(markLabel).offset(30);
        make.bottom.equalTo(markLabel);
        make.size.mas_equalTo(CGSizeMake(89, 15));
    }];
    
    return bgImage;
}


#pragma mark- tableView的协议方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ==0 ?3:cookBookArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        第0区第0行,展示大厨个人信息
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"Profile"];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = StringMiddleColor;
            cell.textLabel.text = [NSString stringWithFormat:@"%@岁 | %@ | %@ | %@",_cookInfoModel.age,_cookInfoModel.birth_place,_cookInfoModel.is_married == 0 ?@"未婚":@"已婚",_cookInfoModel.language];
            return cell;
        }
//        第0区第一行,展示大厨的自我介绍
        if (indexPath.row == 1) {
            cell.textLabel.text = _cookInfoModel.intro;
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.numberOfLines = 0;
            return cell;
        }
//        第0区第二行,展示大厨的标签
        if (indexPath.row == 2) {
            CGFloat positonX = 10;
            for (int i = 0; i <_markArray.count; i ++) {
                UILabel *themeLabel = [[UILabel alloc] init];
                themeLabel.font = [UIFont systemFontOfSize:13];
                themeLabel.textColor = [UIColor whiteColor];
                themeLabel.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
                themeLabel.text = _markArray[i];
                themeLabel.textAlignment = NSTextAlignmentCenter;
                themeLabel.layer.cornerRadius = 4;
                themeLabel.layer.masksToBounds = YES;
                [cell.contentView addSubview:themeLabel];
                [themeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(positonX);
                    make.top.mas_equalTo(12);
                    make.size.mas_equalTo(CGSizeMake([self getWidthWithString:themeLabel.text andFont:12] + 20, 21));
                }];
                positonX = positonX + [self getWidthWithString:themeLabel.text andFont:12] + 10 +10;
            }
            
            UIButton *judgeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [cell addSubview:judgeButton];
            [judgeButton setTitle:@"评价>" forState:UIControlStateNormal];
            [judgeButton setTitleColor:StringLightColor forState:UIControlStateNormal];
            judgeButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [judgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-10);
                make.top.mas_equalTo(40);
                make.size.mas_equalTo(CGSizeMake(40, 14));
            }];
            [judgeButton addTarget:self action:@selector(clickToJudge) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
    }
    
//    第一区可以重用菜谱界面的cell----
    ZMCCookBookTVCell *cell = [tableView dequeueReusableCellWithIdentifier:cookCellReuseId forIndexPath:indexPath];
    
    CookBookModel *cookModel = self.cookNsmuArray[indexPath.row];
    
    greensId = cookModel.cookBookId;
    
    [cell getModelDataToControl:cookModel];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return section ==0 ?0 :40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return 44;
        }
        if (indexPath.row == 1) {
            return [self getHeightWithString:_cookInfoModel.intro];
        } else {
            return 60;
        }
    }
    return 150;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] init];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 50, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = StringMiddleColor;
        label.text = @"拿手菜";
        [view addSubview:label];
        return view;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        CookBookModel *cookModel = self.cookNsmuArray[indexPath.row];
        
        ZMCCookBookDetailViewController *cookbookVC = [[ZMCCookBookDetailViewController alloc] init];
        //应该传个菜谱id过去的
        cookbookVC.cookBookID = [cookModel.cookBookId intValue];
        [self.navigationController pushViewController:cookbookVC animated:YES];
    }
}


#pragma mark- 根据偏移量，设置导航条背景颜色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = ThemeGreenColor;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > -64.0) {
        CGFloat alpha = MIN(1, (64 +offsetY)/214.0);
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}


#pragma mark- 点击跳转到评价界面
- (void)clickToJudge
{
//    ZMCCookJudgeViewController *judgeVC = [[ZMCCookJudgeViewController alloc] init];
//    [self.navigationController pushViewController:judgeVC animated:YES];
    
    CommentsVC *vc = [[CommentsVC alloc] initWithNibName:@"CommentsVC" bundle:nil];
    vc.cook_id = [NSString stringWithFormat:@"%@",_cookInfoModel.ID];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- 点击选择雇佣大厨的时间
- (void)clickToEmployCook
{
//    [self addBackgroundView];
//    ZMCSelectCookTimeViewController *timeVC = [[ZMCSelectCookTimeViewController alloc] init];
//    //    模态弹出一个半透明的viewcontroller
//    timeVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    timeVC.cookerId = self.cook_id;
//    [self presentViewController:timeVC animated:YES completion:nil];
    
    Check_Login
    
    sureChoseView = [[SureChooseCookerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    [self.view addSubview:sureChoseView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    NSString *string = [NSString stringWithFormat:@"%@元", self.cookPrice];
    
    sureChoseView.addChoseCookerView.priceLabel.text = string;
    
    sureChoseView.addChoseCookerView.getTimeTF.delegate = self;
    
    [sureChoseView.alphaiView addGestureRecognizer:tap];
    
    [sureChoseView.addChoseCookerView.sureChoseCookerButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    _cuiPickerView = [[CookPickView alloc]init];
    _cuiPickerView.frame = CGRectMake(0, sureChoseView.frame.size.height + 65, sureChoseView.frame.size.width, 240);
    
    //这一步很重要
    _cuiPickerView.myTextField = sureChoseView.addChoseCookerView.getTimeTF;
    
    _cuiPickerView.delegate = self;
    _cuiPickerView.curDate=[NSDate date];
    [self.view addSubview:_cuiPickerView];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    [_cuiPickerView showInView:self.view];
}

-(void)didFinishPickView:(NSString *)date
{
    sureChoseView.addChoseCookerView.dataString = date;
    sureChoseView.addChoseCookerView.getTimeTF.text = date;
}

- (void)sure {

    if ((sureChoseView.addChoseCookerView.timeString == nil || [sureChoseView.addChoseCookerView.getTimeTF.text isEqualToString:@""])) {

        [SVProgressHUD showErrorWithStatus:@"请选择上门时间或服务时长"];

        [self performSelector:@selector(dismissSVP) withObject:nil afterDelay:1.5];

    }else {

        NSDictionary *dict = @{
                               @"item_id" : self.cook_id,
                               @"quantity" : sureChoseView.addChoseCookerView.timeString,
                               @"start_time" : sureChoseView.addChoseCookerView.getTimeTF.text,
                               @"type" : @2
                               };
        [HomeNetwork sureOfTheCookerToHome:dict andCompleteBlock:^(NSString *cookString) {


            if ([cookString isEqualToString:@"OK"]) {

                [SVProgressHUD showSuccessWithStatus:@"雇佣成功"];

                [self performSelector:@selector(dismissSVPSuess) withObject:nil afterDelay:1.5];
            }else {

                [SVProgressHUD showErrorWithStatus:@"您已选择一位大厨,请勿多选"];

                [self performSelector:@selector(dismissSVP) withObject:nil afterDelay:1.5];
            }
        }];
    }
}

-(void)dismiss {
    
    [_cuiPickerView hiddenPickerView];
    
    __weak typeof(self)weakSelf = self;
    
    center.y = center.y+self.view.frame.size.height;
    
    [UIView animateWithDuration: 0.35 animations: ^{
        
        sureChoseView.frame =CGRectMake(0, weakSelf.view.frame.size.height, weakSelf.view.frame.size.width, weakSelf.view.frame.size.height);
        
        weakSelf.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        
        weakSelf.view.center = weakSelf.view.center;
        
    } completion: nil];
    
}

- (void)dismissSVPSuess {
    
    [self dismiss];
    [SVProgressHUD dismiss];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = ThemeGreenColor;
    [self.navigationController.navigationBar lt_reset];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    

}

- (void)dismissSVP {

    [SVProgressHUD dismiss];

}

// 添加半透明阴影效果
- (void)addBackgroundView
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgView.alpha = 0.3;
    _bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_bgView];
}
- (void)removeBackgroundView
{
    [_bgView removeFromSuperview];
    
    _bgView = nil;
    
//    [self performSelector:@selector(goToRootVc) withObject:nil afterDelay:1.0];
//    [self goToRootVc];
}

- (void)goToRootVc {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark- 根据给定的字符串固定高度计算高度/宽度
- (CGFloat)getHeightWithString:(NSString *)string
{
    CGRect stringRect = [string boundingRectWithSize:CGSizeMake(kScreenWidth -20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return stringRect.size.height;
}
- (CGFloat)getWidthWithString:(NSString *)string andFont:(CGFloat)font
{
    CGRect stringRect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return stringRect.size.width;
}

@end
