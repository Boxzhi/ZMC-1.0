//
//  CookPickView.m
//  ZMC
//
//  Created by Ljun on 16/6/16.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "CookPickView.h"
#define screenWith  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface CookPickView ()<UIPickerViewDataSource, UIPickerViewDelegate>

{
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    NSCalendar *calendar;
    NSInteger days;
    NSInteger hour;
    NSInteger newHour;
    
    BOOL isDayMove;
    BOOL isMinuHas;
    BOOL isHourMove;
    //左边退出按钮
    UIButton *cancelButton;
    //右边的确定按钮
    UIButton *chooseButton;
    
}

@property (nonatomic, copy) NSArray *provinces;//请假类型
@property (nonatomic, copy) NSArray *selectedArray;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic,strong) NSString *string;

@end

@implementation CookPickView

- (id)init {
    if (self = [super init]) {
        
        isDayMove = NO;
        isMinuHas = NO;
        isHourMove = NO;
        
        self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 180)];
        self.pickerView.backgroundColor = [UIColor whiteColor]
        ;
        self.pickerView.dataSource=self;
        self.pickerView.delegate=self;
        [self addSubview:self.pickerView];
        //盛放按钮的View
        UIView *upVeiw = [[UIView alloc]initWithFrame:CGRectMake(-2, 0, [UIScreen mainScreen].bounds.size.width+4, 40)];
        upVeiw.backgroundColor = [UIColor grayColor];
        [self addSubview:upVeiw];
        //左边的取消按钮
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(12, 0, 40, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(hiddenPickerView) forControlEvents:UIControlEventTouchUpInside];
        [upVeiw addSubview:cancelButton];
        
        //右边的确定按钮
        chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 40, 40);
        [chooseButton setTitle:@"确定" forState:UIControlStateNormal];
        chooseButton.backgroundColor = [UIColor clearColor];
        [chooseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [chooseButton addTarget:self action:@selector(hiddenPickerViewRight) forControlEvents:UIControlEventTouchUpInside];
        [upVeiw addSubview:chooseButton];
        
        
        
        
        NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
        NSDateComponents *comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
        NSInteger year=[comps year];
        
        startYear=year-15;
        yearRange=30;
        selectedYear=2000;
        selectedMonth=1;
        selectedDay=1;
        selectedHour=0;
        selectedMinute=0;
        dayRange=[self isAllDay:startYear andMonth:1];
        [self hiddenPickerView];
    }
    return self;
}

#pragma mark --
#pragma mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}


//确定每一列返回的东西
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            if (dayRange - selectedDay + 1 > 3) {
                
                return 3;
                
            }else {
                
                return dayRange - selectedDay + 1;
            }
        }
            break;
        case 3:
        {
            if (isDayMove == NO) {
                
                return 24 - selectedHour-2;
                
            }else {
                
                return 24;
            }
            
        }
            break;
        case 4:
        {
            return 2;
        }
            break;
            
        default:
            break;
    }
    return 0;
}

#pragma mark -- UIPickerViewDelegate
//默认时间的处理
-(void)setCurDate:(NSDate *)curDate
{
    //获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents *comps = [calendar0 components:unitFlags fromDate:curDate];
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    days=[comps day];
    hour=[comps hour];
    NSInteger minute=[comps minute];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=days;
    selectedHour=hour;
    selectedMinute=minute;
    
    dayRange=[self isAllDay:year andMonth:month];
    
    [self.pickerView selectRow:year-startYear inComponent:0 animated:true];
    [self.pickerView selectRow:month-1 inComponent:1 animated:true];
    [self.pickerView selectRow:days-1 inComponent:2 animated:true];
    [self.pickerView selectRow:hour inComponent:3 animated:true];
    [self.pickerView selectRow:minute inComponent:4 animated:true];
    
    [self.pickerView reloadAllComponents];
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(screenWith*component/6.0, 0,screenWith/6.0, 30)];
    label.font=[UIFont systemFontOfSize:15.0];
    label.tag=component*100+row;
    label.textAlignment=NSTextAlignmentCenter;
    switch (component) {
        case 0:
        {
            label.frame=CGRectMake(5, 0,screenWith/4.0, 30);
            label.text=[NSString stringWithFormat:@"%ld 年",(long)(selectedYear + row)];
        }
            break;
        case 1:
        {
            label.frame=CGRectMake(screenWith/4.0, 0, screenWith/8.0, 30);
            label.text=[NSString stringWithFormat:@"%ld 月",(long)selectedMonth+row];
        }
            break;
        case 2:
        {
            label.frame=CGRectMake(screenWith*3/8, 0, screenWith/8.0, 30);
            label.text=[NSString stringWithFormat:@"%ld 日",(long)days+row];
        }
            break;
        case 3:
        {
            label.textAlignment=NSTextAlignmentRight;
            if (isDayMove == NO) {
                
                label.text=[NSString stringWithFormat:@"%ld 时",(long)hour+row+3];
                
            }else {
                
                label.text=[NSString stringWithFormat:@"%ld 时",row];
                
            }
            
        }
            break;
        case 4:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.text=[NSString stringWithFormat:@"%ld 分",(long)row*30];
        }
            break;
            //        case 5:
            //        {
            //            label.textAlignment=NSTextAlignmentRight;
            //            label.frame=CGRectMake(screenWith*component/6.0, 0, screenWith/6.0-5, 30);
            //            label.text=[NSString stringWithFormat:@"%ld 秒",(long)row];
            //        }
            //            break;
            
        default:
            break;
    }
    return label;
}

// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            selectedYear=startYear + row;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            //            [self.pickerView reloadComponent:2];
        }
            break;
        case 1:
        {
            selectedMonth=row+1;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            //            [self.pickerView reloadComponent:2];
        }
            break;
        case 2:
        {
            selectedDay=days+row;
            if (selectedDay==days) {
                
                isDayMove = NO;
            }else {
                isDayMove = YES;
            }
            
            
            [self.pickerView reloadComponent:3];
        }
            break;
        case 3:
        {
            isHourMove = YES;
            
            if (isDayMove == NO) {
                newHour = row;
                selectedHour=hour+row;
            }else {
                
                newHour = row;
                selectedHour=row;
            }
            
            //            [self.pickerView reloadComponent:3];
        }
            break;
        case 4:
        {
            isMinuHas = YES;
            selectedMinute=row*30;
        }
            break;
            
        default:
            break;
    }
    
    
    
}



#pragma mark -- show and hidden
- (void)showInView:(UIView *)view {
    
    [UIView animateWithDuration:0.7f animations:^{
        self.frame = CGRectMake(0, view.frame.size.height-200, view.frame.size.width, 200);
        // self.backgroundColor = [UIColor redColor];
    } completion:^(BOOL finished) {
        //self.frame = CGRectMake(0, view.frame.size.height-200, view.frame.size.width, 200);
    }];
}


//隐藏View
//取消的隐藏
- (void)hiddenPickerView
{
    [UIView animateWithDuration:0.7f animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        // self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
    [self.myTextField resignFirstResponder];
}

//确认的隐藏
-(void)hiddenPickerViewRight
{
    if (isMinuHas == NO) {
        if (isDayMove == YES) {
            
            selectedHour = newHour;
            selectedMinute=0;
            _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
        }else {
            
            if (selectedDay == days) {
                
                selectedHour = hour+newHour+3;
            }else {
                
                selectedHour = selectedHour + 1;
            }
            
            
            selectedMinute=0;
            _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
        }
        
    }else {
        
        if (isDayMove == YES) {
            
            selectedHour = newHour;
            //            selectedMinute=0;
            _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
        }else {
            
            if (selectedDay == days) {
                
                selectedHour = hour+newHour+1;
            }else {
                
                selectedHour = selectedHour + 1;
            }
            
            
            //            selectedMinute=0;
            _string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld %.2ld:%.2ld",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute];
        }
        
    }
    
    
    [UIView animateWithDuration:0.7f animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        // self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    if ([self.delegate respondsToSelector:@selector(didFinishPickView:)]) {
        
        [self.delegate didFinishPickView:_string];
    }
    
    [self.myTextField resignFirstResponder];
    
}


#pragma mark -- setter getter
- (NSArray *)provinces {
    if (!_provinces) {
        self.provinces = [@[] mutableCopy];
    }
    return _provinces;
}

- (NSArray *)selectedArray {
    if (!_selectedArray) {
        self.selectedArray = [@[] mutableCopy];
    }
    return _selectedArray;
}




-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}

@end
