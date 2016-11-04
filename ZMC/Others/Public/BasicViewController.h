//
//  BasicViewController.h
//  ThailandGo
//
//  Created by Daniel on 15/9/28.
//  Copyright © 2015年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+Category.h"
#import "WLNetworkErrorView.h"
@interface BasicViewController : UIViewController
/**
 *  返回一个包含自己的UINavigationController
 *
 *  @return UINavigationController
 */
+ (UINavigationController *)navigationControllerContainSelf;
//7265231C-39B4-402C-89E1-16167C4CC990


-(void)presentLoginVCAction;

-(void)backAction;

//- (void)networkErrorShow;
//- (void)networkErrorRemove;

/**
 *  协议跳转各个页面
 活动链接如果想调用本地页面,配置的链接必须遵守以下格式：
 xixi://number_value
 number 代表需要跳转的事件代号
 value是参数
 例如 farm://1
 1表示进入原生FAQ 界面 无需参数
	farm://2_12
 2表示进入服务页面 _后面的参数 表示parentId 是12
 
 1 表示进入FAQ页面  无需参数
 2 表示进入热门页面 无需参数
 3 表示进入今日特价页面 无需参数
 4 表示进入限时抢购页面 无需参数
 5 表示进入我的订单页面 无需参数
 6表示进入到个人中心  无需参数
 7 表示进入到我的优惠券页面 无需参数
 8 表示进入意见反馈页面  无需参数
 9 表示进入充值界面  无需参数
 10表示进入商品详情页 后面接商品编号
 
 协议开头：farm://
 
 
 *
 *  @param eventId 事件id
 *  @param value   参数
 */
-(void)actionWithEventId:(NSString *)eventId andValue:(NSString *)value;


-(void)returnUrl:(NSString *)urlpatch EventIdAndValue:(void (^)(NSString *eventId,NSString *value))eventBlock andComwebBlock:(dispatch_block_t)comwebBlcok;
@end
