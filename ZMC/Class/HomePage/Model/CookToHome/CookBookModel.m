//
//  CookBookModel.m
//  ZMC
//
//  Created by Ljun on 16/6/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "CookBookModel.h"

@implementation CookBookModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.cookBookId = value;
    }
}

@end
