//
//  DistributionTimeVC.m
//  YiHaiFarm
//
//  Created by Naive on 15/12/7.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import "DistributionTimeVC.h"
#import "DistributionHeadCell.h"
#import "DistributionTimeCell.h"
#import "UIBarButtonItem+NavButton.h"

#import "DistributionTimeModel.h"
#import "GetTimeModel.h"


@interface DistributionTimeVC ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    
    /**
     *  派送时间的数据源
     */
    GetTimeModel *getTime_model;
    
    /**
     *  派送时间信息
     */
    NSMutableArray *dateArray;
    
    /**
     *  星期
     */
    NSArray *weekArr;
    /**
     *  天
     */
    NSArray *dayArr;
    
    NSString *date; //选中的日期
    NSString *time; //选中的时间
}

@end

@implementation DistributionTimeVC

- (void)drawView
{
    _tableView = [[UITableView alloc] init];
//    _tableView.backgroundColor = TableViewBColor;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem getNavButtomItemWithTarget:self andSel:@selector(rightClick) withTitle:@"完成"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配送时间";
    
    [self drawView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
   
    
    weekArr = [NSArray arrayWithObjects:@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",nil];
    dayArr = [NSArray arrayWithObjects:@"明天",@"后天",@"大后天",nil];
    
    dateArray = [NSMutableArray array];
    
//    if (self.pre_sale_id) {
//        [self getInfo2];
//    }else
     [self getInfo1];
}

#pragma mark - 获取数据
- (void)getInfo1
{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [CommonHttpAPI getOrderGetTimeWithParameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        ZMCLog(@"%@",responseObject);
        [SVProgressHUD dismiss];
        
        NSDictionary *dic = responseObject;
        
        if ([dic getTheResultForDic]) {
            
            getTime_model = [GetTimeModel mj_objectWithKeyValues:dic];
            [getTime_model.result.date enumerateObjectsUsingBlock:^(GetTimeDate *obj, NSUInteger idx, BOOL *stop) {
                DistributionTimeModel *model = [[DistributionTimeModel alloc] init];
                model.date_name = obj.date;
                model.date = obj.date_name;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat: @"yyyy-MM-dd"];
                NSDate *beginningOfWeek= [dateFormatter dateFromString:obj.date];
                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSDateComponents *com = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:beginningOfWeek];
                NSInteger week = [com weekday];
                model.week = [NSString stringWithFormat:@"%@",[weekArr objectAtIndex:week-1]];
                NSCalendar *calendar = [NSCalendar currentCalendar];
                unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
                NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date] toDate:beginningOfWeek options:0];
                if ([components day] < 4) {
                    model.day = [dayArr objectAtIndex:[components day]];
                }
//                model.shangWuTime = obj.sections[0].sectionTime;
//                model.shangWuTimeName = obj.sections[0].sectionName;
                if (obj.sections.count == 1) {
                    
//                    model.shangWuTime = @"     无";
//                    model.shangWuTimeName = @"暂无配送时间";
//                    model.button1 = -1;
                    model.xiaWuTime = obj.sections[0].sectionTime;
                    model.xiaWuTimeName = obj.sections[0].sectionName;
                }else {
                    model.shangWuTime = obj.sections[0].sectionTime;
                    model.shangWuTimeName = obj.sections[0].sectionName;
                    model.xiaWuTime = obj.sections[1].sectionTime;
                    model.xiaWuTimeName = obj.sections[1].sectionName;
                    model.button1 = 0;
                }
                
//                model.button1 = 0;
                model.button2 = 0;
                [dateArray addObject:model];
            }];
            [_tableView reloadData];
            
        }else {
            [SVProgressHUD showErrorWithStatus:[dic getResultMessage]];
        }

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        ZMCLog(@"%@",error);
    }];
//    [OrderHttpAPI getOrderTimeWithParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [SVProgressHUD dismiss];
////        NSLog(@"-----%@",JsonFromDic(responseObject));
//        NSDictionary *dic = responseObject;
//        
//        if ([dic getTheResultForDic]) {
//            
//            getTime_model = [GetTimeModel mj_objectWithKeyValues:dic];
//            [getTime_model.result.date enumerateObjectsUsingBlock:^(GetTimeDate *obj, NSUInteger idx, BOOL *stop) {
//                DistributionTimeModel *model = [[DistributionTimeModel alloc] init];
//                model.date_name = obj.date;
//                model.date = obj.date_name;
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat: @"yyyy-MM-dd"];
//                NSDate *beginningOfWeek= [dateFormatter dateFromString:obj.date];
//                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//                 NSDateComponents *com = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:beginningOfWeek];
//                NSInteger week = [com weekday];
//                model.week = [NSString stringWithFormat:@"%@",[weekArr objectAtIndex:week-1]];
//                NSCalendar *calendar = [NSCalendar currentCalendar];
//                unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//                NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date] toDate:beginningOfWeek options:0];
//                if ([components day] < 4) {
//                    model.day = [dayArr objectAtIndex:[components day]];
//                }
//                model.shangWuTime = obj.sections[0].sectionTime;
//                model.shangWuTimeName = obj.sections[0].sectionName;
//                model.xiaWuTime = obj.sections[1].sectionTime;
//                model.xiaWuTimeName = obj.sections[1].sectionName;
//                model.button1 = 0;
//                model.button2 = 0;
//                [dateArray addObject:model];
//            }];
//            [_tableView reloadData];
//            
//        }else {
//            [SVProgressHUD showErrorWithStatus:[dic getResultMessage]];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        [SVProgressHUD dismiss];
//        NSLog(@"%@",error);
//    }];
}

//- (void)getInfo2
//{
//    [HomeHttpAPI getPreSaleGetTimeWithEspecId:[NSString stringWithFormat:@"/%ld",(long)self.pre_sale_id] WithParameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",JsonFromDic(responseObject));
//        NSDictionary *dic = responseObject;
//        if ([dic getTheResultForDic]) {
//            
//            getTime_model = [GetTimeModel mj_objectWithKeyValues:dic];
//            [getTime_model.result.date enumerateObjectsUsingBlock:^(GetTimeDate *obj, NSUInteger idx, BOOL *stop) {
//                DistributionTimeModel *model = [[DistributionTimeModel alloc] init];
//                model.date_name = obj.date;
//                model.date = obj.date_name;
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//                [dateFormatter setDateFormat: @"yyyy-MM-dd"];
//                NSDate *beginningOfWeek= [dateFormatter dateFromString:obj.date];
//                NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//                NSDateComponents *com = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:beginningOfWeek];
//                NSInteger week = [com weekday];
//                model.week = [NSString stringWithFormat:@"%@",[weekArr objectAtIndex:week-1]];
//                NSCalendar *calendar = [NSCalendar currentCalendar];
//                unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
//                NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date] toDate:beginningOfWeek options:0];
////                if ([components day] < 4) {
////                    model.day = [dayArr objectAtIndex:[components day]];
////                }
//                model.shangWuTime = obj.sections[0].sectionTime;
//                model.shangWuTimeName = obj.sections[0].sectionName;
//                model.xiaWuTime = obj.sections[1].sectionTime;
//                model.xiaWuTimeName = obj.sections[1].sectionName;
//                model.button1 = 0;
//                model.button2 = 0;
//                [dateArray addObject:model];
//            }];
//            [_tableView reloadData];
//            
//        }else {
//            [SVProgressHUD showErrorWithStatus:[dic getResultMessage]];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dateArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 64;
    }else {
        return 90;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 3) {
//        return 0;
//    }
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (indexPath.section == 0) {
        
        static NSString *identifier = @"DistributionHeadCell";
        
        DistributionHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DistributionHeadCell" owner:nil options:nil]firstObject];
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        cell.headTitle.text = getTime_model.result.desc;
        [cell headShow];
        
        return cell;
        
    }else {
        static NSString *identifier = @"DistributionTimeCell";
        
        DistributionTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DistributionTimeCell" owner:nil options:nil]firstObject];
        }
        
        if (dateArray != nil) {
            [cell setDistributionTime:dateArray[indexPath.section-1]];
        }
    
        cell.shangWuButton.tag = indexPath.section-1;
        cell.xiaWuButton.tag = indexPath.section-1;
        DistributionTimeModel *model = dateArray[indexPath.section-1];
        if (!model.shangWuTime) {
            cell.shangWuButton.hidden = YES;
        }else {
            cell.shangWuButton.hidden = NO;
        }
        [cell.shangWuButton addTarget:self action:@selector(shangWuClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.xiaWuButton addTarget:self action:@selector(xiaWuClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
    return nil;
}

#pragma mark - 点击事件
- (void)rightClick {
    if (date && time) {
        [self.navigationController popViewControllerAnimated:YES];
        self.getTime(date,time);
    }else {
        [OMGToast showWithText:@"请选择时间"];
    }
    
}

- (void)shangWuClick:(UIButton *)button {
    for (int i=0; i<dateArray.count; i++) {
        ((DistributionTimeModel *)dateArray[i]).button1 = 0;
        ((DistributionTimeModel *)dateArray[i]).button2 = 0;
    }
    ((DistributionTimeModel *)dateArray[button.tag]).button1 = 1;
    date = ((DistributionTimeModel *)dateArray[button.tag]).date_name;
    time = ((DistributionTimeModel *)dateArray[button.tag]).shangWuTime;
    [_tableView reloadData];
}

- (void)xiaWuClick:(UIButton *)button {
    for (int i=0; i<dateArray.count; i++) {
//        DistributionTimeModel *model = [[DistributionTimeModel alloc] init];
        DistributionTimeModel *model = dateArray[i];
        model.button1 = 0;
        ((DistributionTimeModel *)dateArray[i]).button1 = 0;
        ((DistributionTimeModel *)dateArray[i]).button2 = 0;
    }
    ((DistributionTimeModel *)dateArray[button.tag]).button2 = 1;
    date = ((DistributionTimeModel *)dateArray[button.tag]).date_name;
    time = ((DistributionTimeModel *)dateArray[button.tag]).xiaWuTime;
    [_tableView reloadData];
}
@end
