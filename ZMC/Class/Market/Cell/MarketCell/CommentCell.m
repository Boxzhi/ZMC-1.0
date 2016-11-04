//
//  CommentCell.m
//  ZMC
//
//  Created by Naive on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "CommentCell.h"
#import "WLAvatarBrower.h"


@implementation CommentCell

- (void)setCommentList:(CommentListData *)model
{
    
    comment_model = model;
//    [self.userImg sd_setImageWithURL:GET_IMAGEURL_URL(model.pics) placeholderImage:[UIImage imageNamed:@"shangdian-touxiang.png"]];
    
    [self.userImg sd_setImageWithURL:[NSURL URLWithString:model.avatar_url] placeholderImage:[UIImage imageNamed:@"my"]];
    self.userName_lab.text = model.mobile;
    self.commentTime_lab.text = model.create_time;
    self.commentGoodsInfo_lab.text = @"";
    self.commentInfo.text = model.content;
    if (![model.result isEqualToString:@""]) {
        self.commentInfo_merchant.text = [NSString stringWithFormat:@"店主有话说：%@",model.result];
    }else {
        self.commentInfo_merchant.hidden = YES;
    }
    
    if (model.score >= 2) {
        self.starImg.image = [UIImage imageNamed:@"star_1.png"];
        if(model.score >= 4) {
            self.starImg.image = [UIImage imageNamed:@"star_2.png"];
            if(model.score >= 6) {
                self.starImg.image = [UIImage imageNamed:@"star_3.png"];
                if(model.score >= 8) {
                    self.starImg.image = [UIImage imageNamed:@"star_4.png"];
                    if(model.score >= 10) {
                        self.starImg.image = [UIImage imageNamed:@"star_5.png"];
                    }
                }
            }
        }
    }
    
    if (model.picList.count >= 1) {
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        NSMutableString *pic = [[NSMutableString alloc] init];
        [pic appendString:[model.picList[0].pic substringToIndex:[model.picList[0].pic length] - 4]];
        [pic appendFormat:@"_60x60.jpg"];
        ZMCLog(@"%@",pic);
        [self.commentImg1 sd_setImageWithURL:GET_IMAGEURL_URL(pic) placeholderImage:[UIImage imageNamed:@"punlun.png"]];
        //        [self.commentImg1.image setAccessibilityIdentifier:model.picList[0].pic];
        [self.commentImg1 addGestureRecognizer:tap1];
        self.commentImg1.tag = 0;
        
        if (model.picList.count >= 2) {
            NSMutableString *pic1 = [[NSMutableString alloc] init];
            [pic1 appendString:[model.picList[1].pic substringToIndex:[model.picList[1].pic length] - 4]];
            [pic1 appendFormat:@"_60x60.jpg"];
            
            [self.commentImg2 sd_setImageWithURL:GET_IMAGEURL_URL(pic1) placeholderImage:[UIImage imageNamed:@"punlun.png"]];
            UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
            [self.commentImg2 addGestureRecognizer:tap2];
            self.commentImg2.tag = 1;
            
            if (model.picList.count >= 3) {
                NSMutableString *pic2 = [[NSMutableString alloc] init];
                [pic2 appendString:[model.picList[2].pic substringToIndex:[model.picList[2].pic length] - 4]];
                [pic2 appendFormat:@"_60x60.jpg"];
                [self.commentImg3 sd_setImageWithURL:GET_IMAGEURL_URL(pic2) placeholderImage:[UIImage imageNamed:@"punlun.png"]];
                UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
                [self.commentImg3 addGestureRecognizer:tap3];
                self.commentImg3.tag = 2;
                
                if (model.picList.count >= 4) {
                    NSMutableString *pic3 = [[NSMutableString alloc] init];
                    [pic3 appendString:[model.picList[3].pic substringToIndex:[model.picList[3].pic length] - 4]];
                    [pic3 appendFormat:@"_60x60.jpg"];
                    [self.commentImg4 sd_setImageWithURL:GET_IMAGEURL_URL(pic3) placeholderImage:[UIImage imageNamed:@"punlun.png"]];
                    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
                    [self.commentImg4 addGestureRecognizer:tap4];
                    self.commentImg4.tag = 3;
                }
            }
        }
    }
    
}

#pragma mark - 点击事件
- (void)tapImageView:(UITapGestureRecognizer *)tapGes{
    
    [((UIImageView *)tapGes.view) sd_setImageWithURL:GET_IMAGEURL_URL(comment_model.picList[tapGes.view.tag].pic) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [WLAvatarBrower showImage:(UIImageView *)tapGes.view];
    }];
}

@end
