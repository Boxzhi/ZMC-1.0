//
//  ZMCTableViewController.m
//  ZMC
//
//  Created by MindminiMac on 16/8/30.
//  Copyright © 2016年 hezhizhi. All rights reserved.
//

#import "ZMCTableViewController.h"

@interface ZMCTableViewController ()<WeChatStylePlaceHolderDelegate>

@end

@implementation ZMCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.tableView.mj_header = [ZMCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];

}

#pragma mark - 占位视图
- (UIView *)makePlaceHolderView{
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    weChatStyle.userInteractionEnabled = NO;
    return weChatStyle;
}

- (UIView *)weChatStylePlaceHolder{
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableView.frame];
    
    weChatStylePlaceHolder.delegate = self;
    weChatStylePlaceHolder.imageName = @"wu";
    weChatStylePlaceHolder.title = _weChatStylePlaceHolderTitle;
    weChatStylePlaceHolder.content = _weChatStylePlaceHolderContent;
    
    return weChatStylePlaceHolder;
}

- (void)emptyOverlayClicked:(id)sender {
}

- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return YES;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}



@end
