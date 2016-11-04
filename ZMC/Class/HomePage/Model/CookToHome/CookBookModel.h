//
//  CookBookModel.h
//  ZMC
//
//  Created by Ljun on 16/6/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookBookModel : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *pic;
@property(nonatomic, assign) NSNumber *selected_count;
@property(nonatomic, assign) NSNumber *cookBookId;

@end
