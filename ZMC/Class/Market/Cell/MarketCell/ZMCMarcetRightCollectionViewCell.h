//
//  ZMCMarcetRightCollectionViewCell.h
//  ZMC
//
//  Created by 睿途网络 on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCMarcetRightCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *marketRightImageView;

@property (strong, nonatomic) IBOutlet UILabel *marketNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *shopName;

@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@property (strong, nonatomic) IBOutlet UIButton *plusButton;

@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) IBOutlet UIButton *minusButton;



@end
