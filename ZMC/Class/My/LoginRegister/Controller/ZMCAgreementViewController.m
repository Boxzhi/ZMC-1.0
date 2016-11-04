//
//  ZMCAgreementViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/6/15.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAgreementViewController.h"

@interface ZMCAgreementViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSString *agrStr;

@property (weak, nonatomic) IBOutlet UIWebView *contentView;

@end

@implementation ZMCAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contentView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    self.contentView.delegate = self;
    // 去掉webview下方的一个黑条
    self.contentView.opaque = NO;
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.contentView.scalesPageToFit = YES;
    self.contentView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    
    [self loadAgr];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.contentView loadHTMLString:[NSString stringWithFormat:@"<html><body>%@</body></html>", _agrStr] baseURL:nil];
}

// 加载注册协议
- (void)loadAgr{
    [HYBNetworking getWithUrl:@"http://115.159.227.219:8088/fanfou-api/agreement/registration" refreshCache:YES success:^(id response) {
        
        _agrStr = response[@"result"][@"content"];
        
    } fail:^(NSError *error) {
        ZMCLog(@"加载注册协议失败%@", error);
    }];
}

- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}


// 结束加载
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}


@end
