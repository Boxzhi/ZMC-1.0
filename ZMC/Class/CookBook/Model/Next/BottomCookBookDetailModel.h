//
//  BottomCookBookDetailModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomCookBookDetailModel : NSObject

@property (nonatomic, strong) NSString *pic;

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *intro;
// 主料
@property (nonatomic, strong) NSArray *foodmaterials;

@property (nonatomic, strong) NSString *detail_pic;
@property (nonatomic, strong) NSString *detail_url;
@property (nonatomic, strong) NSString *short_intro;
@property (nonatomic, strong) NSNumber *favorite_count;
@property (nonatomic, strong) NSNumber *selected_count;
@property (nonatomic, assign) BOOL has_selected;
@property (nonatomic, strong) NSArray *pic_list;

// 辅料
@property (nonatomic, strong) NSArray *ingredients_lists;

@end
