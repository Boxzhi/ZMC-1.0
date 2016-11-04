//
//  ShareMenuViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCShareMenuViewController : UIViewController

/**
 *  宴会的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *menuPicture;

/**
 *  宴会的时间，现在的时间
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;








/**
 *  分享到微信
 */
@property (weak, nonatomic) IBOutlet UIView *shareToWeiXin;

/**
 *  分享到微信朋友圈
 */
@property (weak, nonatomic) IBOutlet UIView *shareToPengYouQuan;

/**
 *  分享到qq好友
 */
@property (weak, nonatomic) IBOutlet UIView *shareToQQ;

/**
 *  分享到qq空间
 */
@property (weak, nonatomic) IBOutlet UIView *shareToQzone;

@end
