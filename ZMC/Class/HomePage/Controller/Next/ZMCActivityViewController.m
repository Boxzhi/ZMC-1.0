//
//  ZMCActivityViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/5/6.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCActivityViewController.h"

@interface ZMCActivityViewController ()<UIWebViewDelegate> {
    
//    UITableView *_tableView;
}

@end

@implementation ZMCActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_navTitle == nil) {
        self.navigationItem.title = @"活动";
    }else{
        self.navigationItem.title = _navTitle;
    }

    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-NAV_H-20)];
    
    if (_strUrl == nil) {
        NSString *strUrl = @"http://weixin.zenmechi.cc/#activity/1";
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
    }else{
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strUrl]]];
    }
//    webView.delegate = self;
    
    [self.view addSubview:webView];
    
//    [self getActivityInfo];
    
}

- (BOOL)webView: (UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSURL *url = [request URL];
    
    NSLog(@"%@",request);
    NSLog(@"%@",url);
    NSLog(@"%@",[url scheme]);
    
//    if ( [[url scheme] isEqualToString:@"myapp"] )
//    {
//        NSString *slug = [url path];
//        [self performSegueWithIdentifier:@"heroSegue" sender:slug];
//        return NO;
//    }
    return YES;
}

//- (void)getActivityInfo {
//    
//    [CommonHttpAPI getActNutritionListWithParameters:[CommonRequestModel getActNutritionListWithPageNO:@"1" page_size:@"15" type:@"1"] success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        if ([responseObject getTheResultForDic]) {
//            
//            
//            
//        }else {
//            
//            [SVProgressHUD showErrorWithStatus:[responseObject getResultMessage]];
//            
//        }
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

@end
