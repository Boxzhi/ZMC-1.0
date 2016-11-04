//
//  ZMCsettingController.h
//  ZMC
//
//  Created by Will on 16/4/28.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ZMCsettingController : UIViewController

@property(nonatomic, strong) UITableView *tableView;

// 头像
@property (nonatomic, weak) UIImage *avatar;
// 昵称
@property (nonatomic, strong) NSString *nick_name;
// 签名
@property (nonatomic, strong) NSString *signature;


@end
