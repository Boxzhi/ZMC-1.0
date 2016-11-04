//
//  GetTimeModel.h
//  YiHaiFarm
//
//  Created by Naive on 16/1/11.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GetTimeResult,GetTimeDate,GetTimeSections;
@interface GetTimeModel : NSObject

@property (nonatomic, strong) GetTimeResult *result;

@property (nonatomic, assign) NSInteger err_code;

@property (nonatomic, copy) NSString *err_msg;

@end

@interface GetTimeResult : NSObject

@property (nonatomic, strong) NSArray<GetTimeDate *> *date;

@property (nonatomic, copy) NSString *desc;

@end

@interface GetTimeDate : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, copy) NSString *date_name;

@property (nonatomic, strong) NSArray<GetTimeSections *> *sections;

@end

@interface GetTimeSections : NSObject

@property (nonatomic, copy) NSString *sectionName;

@property (nonatomic, copy) NSString *sectionTime;

@end

