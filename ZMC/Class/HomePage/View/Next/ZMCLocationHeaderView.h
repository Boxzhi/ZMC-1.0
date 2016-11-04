//
//  ZMCLocationHeaderView.h
//  ZMC
//
//  Created by MindminiMac on 16/5/12.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCLocationHeaderView : UIView

/**
 *  搜索框
 */
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

///**
// *  省
// */
//@property (weak, nonatomic) IBOutlet UIButton *provinceButton;
//
///**
// *  市
// */
//@property (weak, nonatomic) IBOutlet UIButton *cityButton;
//
///**
// *  区
// */
//@property (weak, nonatomic) IBOutlet UIButton *areaButton;


/**
 *  定位按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *locateButton;





+ (ZMCLocationHeaderView *)instanceHeaderView;

@end
