//
//  ZMCDetailTableHeaderView.h
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCDetailTableHeaderView : UIView

/**
 *  菜的图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPicture;

/**
 *  菜的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *dishName;

/**
 *  这道菜被收藏的人数
 */
@property (weak, nonatomic) IBOutlet UILabel *favoriteNumber;


/**
 *  菜的简介
 */
@property (weak, nonatomic) IBOutlet UILabel *introduction;


+ (ZMCDetailTableHeaderView *)instanceHeaderView;
@end
