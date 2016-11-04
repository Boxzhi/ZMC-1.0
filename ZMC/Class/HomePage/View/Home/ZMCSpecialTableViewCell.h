//
//  SpecialTableViewCell.h
//  ZMC
//
//  Created by MindminiMac on 16/4/19.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCSpecialTableViewCell : UITableViewCell

//最大的imageview
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

//右边上面的imageView
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

//右边下面的1个imageView
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@end
