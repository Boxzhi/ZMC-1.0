//
//  ZMCRegisteredTwoView.m
//  ZMC
//
//  Created by Will on 16/5/13.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCFgpwdTwoView.h"

@implementation ZMCFgpwdTwoView



+ (instancetype)fgpwdTwo{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}
@end

