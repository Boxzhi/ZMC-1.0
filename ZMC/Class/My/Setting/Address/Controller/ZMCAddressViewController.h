//
//  ZMCAddressViewController.h
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCAddressViewController : UIViewController
//@property (nonatomic, strong) NSMutableArray *allData;
@property(nonatomic, assign) int is_order;

@property (nonatomic,strong) void(^getAddress)(NSString *userName,NSString *userMobile,NSString *userAddress,NSString *addressId);

@end
