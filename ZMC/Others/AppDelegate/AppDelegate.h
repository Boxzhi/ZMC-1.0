//
//  AppDelegate.h
//  ZMC
//
//  Created by 睿途网络 on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 上下文对象
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
// 数据模型对象
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
// 持久性存储区
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

