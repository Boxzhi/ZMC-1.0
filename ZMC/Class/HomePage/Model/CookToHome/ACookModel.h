//
//  ACookModel.h
//  ZMC
//
//  Created by MindminiMac on 16/5/23.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACookModel : NSObject

@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *birth_place;
@property (nonatomic, strong) NSNumber *follow_num;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *like_num;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *star;
@property (nonatomic, strong) NSArray *cook_books;
@property (nonatomic, strong) NSString *food_category;
@end
