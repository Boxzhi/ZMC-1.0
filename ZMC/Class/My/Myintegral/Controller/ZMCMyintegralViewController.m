//
//  ZMCMyintegralViewController.m
//  ZMC
//
//  Created by Will on 16/5/2.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyintegralViewController.h"
#import "ZMCMyintegralManger.h"

@interface ZMCMyintegralViewController ()<UIWebViewDelegate>

@property (nonatomic, copy) NSString *contentStr;

@property (weak, nonatomic) IBOutlet UIView *SignView;

// 未签到/已签到
@property (weak, nonatomic) IBOutlet UILabel *signedLabel;
// 本次签到积分
@property (weak, nonatomic) IBOutlet UILabel *points;
// 已签到总次数
@property (weak, nonatomic) IBOutlet UILabel *signin_times;
// 明天签到得分
@property (weak, nonatomic) IBOutlet UILabel *tomorrow_points;
// 总积分
@property (weak, nonatomic) IBOutlet UILabel *total_points;

@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@end

@implementation ZMCMyintegralViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"签到积分";
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    
    // 圆角
    [self setSignLayer];
    // 点击手势
    [self setSignTap];
    
    self.contentView.delegate = self;
    self.contentView.scalesPageToFit = YES;
    self.contentView.scrollView.bounces = NO;

    [self loadMember];

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self loadDatais_signin:@"0"];
   
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    ZMCLog(@"---->>%@", _contentStr);
    [self.contentView loadHTMLString:[NSString stringWithFormat:@"<html><body>%@</body></html>", _contentStr] baseURL:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - 设置圆角
- (void)setSignLayer{
    self.SignView.layer.cornerRadius = 46.5;
    self.SignView.layer.masksToBounds = YES;
    
    CALayer *layer = [_SignView layer];
    layer.borderColor = RGB(147, 218, 164).CGColor;
    layer.borderWidth = 3.0f;

}

- (void)setSignTap{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(qiaoDao)];
    [self.SignView addGestureRecognizer:tap];
}

- (void)qiaoDao{
    ZMCFunc;
    
    [self loadDatais_signin:@"1"];
}


#pragma mark - 请求积分数据
- (void)loadDatais_signin:(NSString *)signin{
    
    [ZMCMyintegralManger is_signin:signin andResult:^(NSDictionary *result) {
        NSNumber *number = result[@"has_signed"];
        switch ([number integerValue]) {
            case 0:
                _signedLabel.text = @"签到";
                break;
            case 1:
                _signedLabel.text = @"已签到";
                break;
        };
        _points.text = [NSString stringWithFormat:@"+%@ 积分", result[@"points"]];
        _signin_times.text = [NSString stringWithFormat:@"%@", result[@"signin_times"]];
        _total_points.text = [NSString stringWithFormat:@"我的积分: %@", result[@"total_points"]];
        _tomorrow_points.text = [NSString stringWithFormat:@"%@", result[@"tomorrow_points"]];
    }];
    
}

#pragma mark - 请求积分规则
- (void)loadMember{
    
    [ZMCMyintegralManger getMemberPoints:^(NSDictionary *result) {
        _contentStr = result[@"result"][@"content"];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark - 改变webview内容字体大小
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // js代码
    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '200%'";
    [self.contentView stringByEvaluatingJavaScriptFromString:str];
}


@end
