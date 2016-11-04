//
//  CommentCell.h
//  ZMC
//
//  Created by Naive on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentListModel.h"

@interface CommentCell : UITableViewCell {
    
    CommentListData *comment_model;
}

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName_lab;
@property (weak, nonatomic) IBOutlet UILabel *commentTime_lab;
@property (weak, nonatomic) IBOutlet UILabel *commentGoodsInfo_lab;
@property (weak, nonatomic) IBOutlet UIImageView *starImg;
@property (weak, nonatomic) IBOutlet UILabel *commentInfo;
@property (weak, nonatomic) IBOutlet UILabel *commentInfo_merchant;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg1;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg2;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg3;
@property (weak, nonatomic) IBOutlet UIImageView *commentImg4;

- (void)setCommentList:(CommentListData *)model;

@end
