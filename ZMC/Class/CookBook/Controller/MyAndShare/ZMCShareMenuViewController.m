//
//  ShareMenuViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCShareMenuViewController.h"
#import "CuiPickerView.h"
#import <UMSocial.h>



@interface ZMCShareMenuViewController ()<UITextFieldDelegate, CuiPickViewDelegate>
// 当前时间
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
/**
 *  宴会的名称
 */
@property (weak, nonatomic) IBOutlet UITextField *activityName;
/**
 *  宴会开始时间
 */
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;



@property (nonatomic, strong) CuiPickerView *timePickerView;


@end

@implementation ZMCShareMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"分享菜谱";
    
    self.activityName.delegate = self;
    self.timeTextField.delegate = self;
    self.timeTextField.tintColor = [UIColor clearColor];
    
    [self getCurrentTime];
    
    [self getTimePickerView];
    
    UITapGestureRecognizer *weixinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.shareToWeiXin addGestureRecognizer:weixinTap];
    
    UITapGestureRecognizer *friendsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.shareToPengYouQuan addGestureRecognizer:friendsTap];
    
    UITapGestureRecognizer *qqTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.shareToQQ addGestureRecognizer:qqTap];

    UITapGestureRecognizer *qzoneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.shareToQzone addGestureRecognizer:qzoneTap];

}

// 获取当前时间日期
- (void)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    ZMCLog(@"当前时间%@", dateTime);
    self.currentTime.text = dateTime;
}

#pragma mark - 日期选择器
- (void)getTimePickerView{
    
    _timePickerView = [[CuiPickerView alloc] init];
    _timePickerView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    _timePickerView.myTextField = _timeTextField;
    
    _timePickerView.delegate = self;
    _timePickerView.curDate = [NSDate date];
    
    [self.view addSubview:_timePickerView];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _timeTextField) {
        textField.inputView = [[UIView alloc] initWithFrame:CGRectZero];
        [_timePickerView showInView:self.view];
        
    }else if (textField == _activityName){
        [_timePickerView hiddenPickerView];
    }
}



- (void)didFinishPickView:(NSString *)date{
    _timeTextField.text = date;
}

//-(void)pickerviewbuttonclick:(UIButton *)sender{
//    
//}
//-(void)hiddenPickerView{
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- textfield协议方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - 分享调用的方法
- (void)click:(UITapGestureRecognizer *)ges
{

    if ([_activityName.text isEqualToString:@""] || _activityName.text == NULL) {
        [SVProgressHUD showInfoWithStatus:@"请输入宴会名称"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else if ([_timeTextField.text isEqualToString:@""] || _timeTextField.text == NULL){
        [SVProgressHUD showInfoWithStatus:@"请选择宴会开始时间"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        
        NSString *createdAtString = [NSString stringWithFormat:@"%@:00", self.timeTextField.text];
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *createdAtDate = [fmt dateFromString:createdAtString];
        
        NSDate *nowDate = [NSDate date];
        NSComparisonResult result = [nowDate compare:createdAtDate];
        ZMCLog(@"__>>%ld", (long)result);
        if (result == NSOrderedAscending) {
            
            NSString *str = [NSString stringWithFormat:@"%@:00 +0800", self.timeTextField.text];
            fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
            NSDate *date = [fmt dateFromString:str];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit type = NSCalendarUnitYear |
            NSCalendarUnitMonth |
            NSCalendarUnitDay |
            NSCalendarUnitHour |
            NSCalendarUnitMinute |
            NSCalendarUnitSecond;
            
            NSDateComponents *cmps = [calendar components:type fromDate:nowDate toDate:date options:0];
            ZMCLog(@"%ld年%ld月%ld日%ld小时%ld分钟%ld秒钟", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
            if (cmps.year != 0 || cmps.month != 0 || cmps.day != 0 || cmps.hour >= 3) {
                
                [ZMCTokenToolShared getAccess_tokenWithRefresh_token:^(NSString *token) {
                    
                    NSDictionary *params = @{
                                             @"title" : _activityName.text,
                                             @"dinner_time" : _timeTextField.text
                                             };
                    
                    [HYBNetworking postWithUrl:[NSString stringWithFormat:@"http://115.159.227.219:8088/fanfou-api/cookbook/share?access_token=%@", token] refreshCache:YES params:params success:^(id response) {
                        
                        NSArray *items = [NSArray arrayWithObjects:UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQQ, UMShareToQzone, nil];
                        
                        NSInteger ViewTag = ((UIView *)ges.view).tag;
                        
                        NSInteger index = ViewTag - 2001;
                        
                        NSString *idStr = [NSString stringWithFormat:
                                           @"http://weixin.zenmechi.cc/?from=groupmessage&isappinstalled=0#chooseMenu/%@", response[@"result"][@"id"]];
                        
                        ZMCLog(@"%@", idStr);
                        
                        // 分享成功后toast提示位置
                        [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionCenter];
                        /**
                         *  微信好友
                         */
                        [UMSocialData defaultData].extConfig.wechatSessionData.url = idStr;
                        [UMSocialData defaultData].extConfig.wechatSessionData.title = _activityName.text;
                        /**
                         *  微信朋友圈
                         */
                        [UMSocialData defaultData].extConfig.wechatTimelineData.url = idStr;
                        [UMSocialData defaultData].extConfig.wechatTimelineData.title = _activityName.text;
                        /**
                         *  QQ好友
                         */
                        [UMSocialData defaultData].extConfig.qqData.url = idStr;
                        [UMSocialData defaultData].extConfig.qqData.title = _activityName.text;
                        /**
                         *  QQ空间
                         */
                        [UMSocialData defaultData].extConfig.qzoneData.url = idStr;
                        [UMSocialData defaultData].extConfig.qzoneData.title = _activityName.text;
                        
                        //                UMSocialUrlResource *urlRes = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];

                        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[items [index]] content:@"我在怎么吃分享了菜谱，快来点菜吧~" image:[UIImage imageNamed:@"fenxiang"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                            if (response.responseCode == UMSResponseCodeSuccess) {
                                NSLog(@"分享成功！");
                            }
                        }];
                        
                    } fail:^(NSError *error) {
                        ZMCLog(@"%@", error);
                    }];
                    
                  }];
                    
            }else{
                ALERT_MSG(@"提示", @"请选择3个小时之后的时间");
            }
            
        }else if (result == NSOrderedDescending){
            ALERT_MSG(@"提示", @"请选择3个小时之后的时间");
        }else{
            ALERT_MSG(@"提示", @"请选择3个小时之后的时间");
        }
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_timePickerView hiddenPickerView];
    [self.view endEditing:YES];
}
@end
