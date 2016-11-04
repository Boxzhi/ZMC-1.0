//
//  Address+CoreDataProperties.h
//  ZMC
//
//  Created by Will on 16/5/10.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Address.h"

NS_ASSUME_NONNULL_BEGIN

@interface Address (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *number;
@property (nullable, nonatomic, retain) NSString *provinces;
@end

NS_ASSUME_NONNULL_END
