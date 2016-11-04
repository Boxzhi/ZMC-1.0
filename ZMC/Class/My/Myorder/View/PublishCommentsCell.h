//
//  PublishCommentsCell.h
//  ZMC
//
//  Created by Naive on 16/6/2.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishCommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsName_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice_lab;
@property (weak, nonatomic) IBOutlet UILabel *goodsTime_lab;
@property (weak, nonatomic) IBOutlet UIImageView *starImgView;
@property (weak, nonatomic) IBOutlet UIButton *starBtn1;
@property (weak, nonatomic) IBOutlet UIButton *starBtn2;
@property (weak, nonatomic) IBOutlet UIButton *starBtn3;
@property (weak, nonatomic) IBOutlet UIButton *starBtn4;
@property (weak, nonatomic) IBOutlet UIButton *starBtn5;

@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn1;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn2;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn3;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn4;
@property (weak, nonatomic) IBOutlet UILabel *comments_lab;
@end
