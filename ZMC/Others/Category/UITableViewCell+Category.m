//
//  UITableViewCell+Category.m
//  YueDongApp
//
//  Created byDaniel on 14-8-5.
//  Copyright (c) 2014年Daniel. All rights reserved.
//

#import "UITableViewCell+Category.h"

@implementation UITableViewCell (Category)

+ (NSString *)cellIdentifier
{
    static NSString *identifier;
    identifier = [NSString stringWithUTF8String:object_getClassName(self)];
    return identifier;
}

@end
