//
//  DistributionHeadCell.h
//  YiHaiFarm
//
//  Created by Naive on 15/12/7.
//  Copyright © 2015年 Naive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributionHeadCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *headTitle;

- (void)headShow;

@end
