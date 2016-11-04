//
//  DistributionTimeModel.h
//  YiHaiFarm
//
//  Created by Naive on 16/1/4.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistributionTimeModel : NSObject

@property (nonatomic, copy) NSString *date_name;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, copy) NSString *shangWuTime;
@property (nonatomic, copy) NSString *shangWuTimeName;
@property (nonatomic, copy) NSString *xiaWuTime;
@property (nonatomic, copy) NSString *xiaWuTimeName;
@property (nonatomic, assign) NSInteger button1;
@property (nonatomic, assign) NSInteger button2;

@end
