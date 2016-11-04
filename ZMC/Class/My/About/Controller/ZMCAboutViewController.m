//
//  ZMCAboutViewController.m
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAboutViewController.h"


@interface ZMCAboutViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *web;

@end

@implementation ZMCAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    UIWebView *webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    webview.delegate = self;
    
    // 去掉webview下方的一个黑条
//    webview.opaque = NO;
    webview.backgroundColor = RGB(242, 242, 242);
    _web = webview;
    webview.scalesPageToFit = YES;
    webview.dataDetectorTypes = UIDataDetectorTypeAll;
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://weixintest.zenmechi.cc/#menu/1"]]];
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
 
    if (kScreenWidth == 320.0f || kScreenHeight == 568.0f) {
        ZMCLog(@"手机是5S或5");
        // js代码  改字体大小
        NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '80%'";
        [webView stringByEvaluatingJavaScriptFromString:str];
        //    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f",30.f];
        //    [webView stringByEvaluatingJavaScriptFromString:jsString];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}




/*
- (void)setContentView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ZMC" ]];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(127, 190));
        make.top.equalTo(self.view).offset(55);
        make.centerX.equalTo(self.view);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"服务条款" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"buyg_bg"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.view.mas_bottom).offset(-30);
}];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Copyright© 2016";
    label.textColor = UIColorFromRGB(0xCFCFCF);
    label.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
*/

@end
