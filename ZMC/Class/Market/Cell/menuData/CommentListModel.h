//
//  CommentListModel.h
//  ZMC
//
//  Created by Naive on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommentListResult,CommentListData,CommentListChilds,CommentListLabels,CommentListPicList;
@interface CommentListModel : NSObject

@property (nonatomic, strong) CommentListResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface CommentListResult : NSObject

@property (nonatomic, strong) NSArray<CommentListData *> *data;

@property (nonatomic, assign) NSInteger bask_num;

@property (nonatomic, assign) NSInteger good_num;

@property (nonatomic, assign) NSInteger moderate_num;

@property (nonatomic, assign) NSInteger negative_num;

@property (nonatomic, assign) NSInteger total_num;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger total_pages;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) NSInteger page_size;

@end

@interface CommentListData : NSObject

@property (nonatomic, copy) NSString *avatar_url;

@property (nonatomic, strong) NSArray<CommentListChilds *> *childs;

@property (nonatomic, strong) NSArray<CommentListLabels *> *labels;

@property (nonatomic, strong) NSArray<CommentListPicList *> *picList;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, copy) NSString *result;

@property (nonatomic, assign) NSInteger childs_id;

@property (nonatomic, copy) NSString *pics;

@property (nonatomic, copy) NSString *create_time;

@property (nonatomic, assign) NSInteger parent_id;

@property (nonatomic, assign) NSInteger goods_id;

@end

@interface CommentListChilds : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *create_time;

@end

@interface CommentListLabels : NSObject

@property (nonatomic, assign) NSInteger label_id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger type;

@end

@interface CommentListPicList : NSObject

@property (nonatomic, copy) NSString *pic;

@end