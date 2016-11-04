//
//  BottomCookBookModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomCookBookModel : NSObject


@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *short_intro;
@property (nonatomic, strong) NSNumber *favourite_count;
@property (nonatomic, strong) NSNumber *selected_count;
@property (nonatomic, strong) NSNumber *has_selected;


@end
