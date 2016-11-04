//
//  ImageInfoModel.h
//  YiHaiFarm
//
//  Created by Naive on 16/3/7.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageInfoResult;

@interface ImageInfoModel : NSObject

@property (nonatomic, strong) NSArray<ImageInfoResult *> *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface ImageInfoResult : NSObject

@property (nonatomic, copy) NSString *picId;

@property (nonatomic, assign) NSInteger width;

@property (nonatomic, assign) NSInteger height;

@property (nonatomic, copy) NSString *url;

@end

