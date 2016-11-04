//
//  ZMCHealthyViewController.m
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCHealthyViewController.h"


@interface ZMCHealthyViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ZMCHealthyViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"健康知识";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    self.webView.delegate = self;
    // 去掉webview下方的一个黑条
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weixin.zenmechi.cc/#health/1"]]];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
