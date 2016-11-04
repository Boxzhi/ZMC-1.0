//
//  UUID.m
//  ZMC
//
//  Created by MindminiMac on 16/7/11.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "UUID.h"

@implementation UUID

+ (NSString *)get_UUID{
    
    CFUUIDRef uuid_ref = CFUUIDCreate(nil);
    
    CFStringRef uuid_string_ref = CFUUIDCreateString(nil, uuid_ref);
    
    CFRelease(uuid_ref);
    
    NSString *uuid=[NSString stringWithString:(__bridge NSString * _Nonnull)(uuid_string_ref)];
    
    CFRelease(uuid_string_ref);
    
    return uuid;
    
}

@end
