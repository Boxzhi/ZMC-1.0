//
//  ZMCRegisteredView.m
//  ZMC
//
//  Created by Will on 16/5/4.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCRegisteredView.h"

@interface ZMCRegisteredView()


@end

@implementation ZMCRegisteredView



+ (instancetype)registeredOne{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}







@end
