//
//  ChatbadgecountManager.m
//  ZMC
//
//  Created by Naive on 16/7/14.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ChatbadgecountManager.h"

@implementation ChatbadgecountManager
+(ChatbadgecountManager *) share
{
    static dispatch_once_t pred;
    static ChatbadgecountManager *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[ChatbadgecountManager alloc] init];
    });
    return shared;
}
@end
