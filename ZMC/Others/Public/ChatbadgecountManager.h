//
//  ChatbadgecountManager.h
//  ZMC
//
//  Created by Naive on 16/7/14.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatbadgecountManager : NSObject

@property (nonatomic, assign) NSInteger badgeCount;

/**
 单例
 */
+(ChatbadgecountManager *) share;

@end
