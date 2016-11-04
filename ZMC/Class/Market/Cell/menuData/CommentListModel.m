//
//  CommentListModel.m
//  ZMC
//
//  Created by Naive on 16/6/7.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "CommentListModel.h"

@implementation CommentListModel

@end

@implementation CommentListResult

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CommentListData class]};
}

@end

@implementation CommentListData

+ (NSDictionary *)objectClassInArray{
    return @{@"labels" : [CommentListLabels class],@"childs":[CommentListChilds class],@"picList" : [CommentListPicList class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"childs_id" : @"id"
             };
}
@end

@implementation CommentListChilds

@end

@implementation CommentListLabels
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"label_id" : @"id"
             };
}
@end

@implementation CommentListPicList

@end

