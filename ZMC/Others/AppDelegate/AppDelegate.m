//
//  AppDelegate.m
//  ZMC
//
//  Created by 睿途网络 on 16/4/25.
//  Copyright © 2016年 ruitu. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import "ZMCCustomeTabBarController.h"
#import <UMSocialWechatHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocial.h>
#import <AlipaySDK/AlipaySDK.h>
#import "PayManager.h"
#import "ZMCMyorderViewController.h"
#import "ZMCGuidepageViewController.h"
#import "GoodsDetailVC.h"
#import <Bugly/Bugly.h>
#import "UUID.h"
#import "SSKeychain.h"
#import <Bugly/BuglyConfig.h>
#import "ZMCActivityViewController.h"
#import <Appirater/Appirater.h>
#import <RNCachingURLProtocol/RNCachingURLProtocol.h>

@interface AppDelegate ()<WXApiDelegate, selectDelegate>

@end

@implementation AppDelegate


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{ 
    // JPush sdk 
    [JPUSHService registerDeviceToken:deviceToken]; 
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo { 
    // JPush sdk
    [JPUSHService handleRemoteNotification:userInfo];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (badge > 0) {
        [JPUSHService setBadge:badge - 1];
        if (badge == 1) {
            [JPUSHService resetBadge];
        }
    }


    ZMCLog(@"推送信息--->>>>%@", userInfo);
//    [self gotoVcWith:userInfo];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    ZMCLog(@"后台切换到前台");
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

//IOS7 only  
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {    
    [JPUSHService handleRemoteNotification:userInfo];   
    completionHandler(UIBackgroundFetchResultNewData);
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (badge > 0) {
        [JPUSHService setBadge:badge - 1];
        if (badge == 1) {
            [JPUSHService resetBadge];
        }
    }
    
//    [self gotoVcWith:userInfo];
}


// 点击推送信息跳转
//- (void)gotoVcWith:(NSDictionary *)msgDic{
//    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
//    NSString *str = [NSString stringWithFormat:@"%lu", (unsigned long)tabBarVc.selectedIndex];
//    NSInteger selected = [str integerValue];
//    UINavigationController *nav = tabBarVc.childViewControllers[selected];
//    
//    if (msgDic[@"url"] != nil && msgDic[@"title"] != nil) {
//        ZMCActivityViewController *activityVc = [[ZMCActivityViewController alloc] init];
//        activityVc.strUrl = msgDic[@"url"];
//        activityVc.navTitle = msgDic[@"title"];
//        [nav pushViewController:activityVc animated:YES];
//    }
//}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //  启动页显示时间
//    [NSThread sleepForTimeInterval:1.0];
    
    [Appirater setAppId:@"1125326330"];
    [Appirater setDaysUntilPrompt:5];
    [Appirater setUsesUntilPrompt:10];
    [Appirater setSignificantEventsUntilPrompt:-1];
    [Appirater setTimeBeforeReminding:1];
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
    
    // UIWebView页面信息的离线缓存
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];
    
    //JPush sdk
    [JPUSHService setupWithOption:launchOptions appKey:JPUSHKey channel:CHANNEL apsForProduction:NO advertisingIdentifier:nil];

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1 
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) { 
        //可以添加自定义categories 
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | 
                                                          UIUserNotificationTypeSound | 
                                                          UIUserNotificationTypeAlert)  
                                              categories:nil];  
    } else {    
        //categories 必须为nil 
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |   
                                                          UIRemoteNotificationTypeSound |   
                                                          UIRemoteNotificationTypeAlert)    
                                              categories:nil];  
    }   
#else   
    //categories 必须为nil 
    [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |   
                                                      UIRemoteNotificationTypeSound |   
                                                      UIRemoteNotificationTypeAlert)    
                                          categories:nil];  
#endif    

    
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    if (badge > 0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:badge - 1];
    }
    
    //Bugly
    BuglyConfig *config = [[BuglyConfig alloc] init];
#if DEBUG == 1
    config.debugMode = YES;
#else
    config.debugMode = NO;
#endif
    // 发布渠道
    config.channel = CHANNEL;
    // 开启/关闭卡顿监听上报
    config.blockMonitorEnable = YES;
    // 非正常退出事件记录开关，默认关闭
    config.unexpectedTerminatingDetectionEnable = YES;
    
    [Bugly startWithAppId:BuglyAppKey config:config];
    
    if(![SSKeychain passwordForService:kService account:kAccount])
    {
        
        NSString *uuid = [UUID get_UUID];
        
        [SSKeychain setPassword:uuid forService:kService account:kAccount];
        
    }
    NSString *retrieveuuid = [SSKeychain passwordForService:kService account:kAccount];
    
    [Bugly setUserIdentifier:retrieveuuid];

    ZMCLog(@"标识符--->>>>>>UUID----%@", retrieveuuid);

    
    
    // 友盟Social
    [UMSocialData setAppKey:UMAppKey];
    
    [UMSocialWechatHandler setWXAppId:WeChatAppId appSecret:WeChatAppSecret url:nil];

    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@"http://www.baidu.com"];
    
    
    // 微信支付

    [WXApi registerApp:WeChatAppId];
    // 微信分享
//    [WXApi registerApp:@"wxb66128d48a4d6928"];

    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    
    // 设置状态栏及导航条颜色
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x29b43d)];

    [[UINavigationBar appearance]  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    ZMCLog(@"%f", IOS_VERSION);
    
    if(IOS_VERSION >= 8.0 && [UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
    // 根控制器
    
//    self.window.rootViewController = [[ZMCCustomeTabBarController alloc] init];
    BOOL y = [ZMCGuidepageViewController isShow];
    if (y) {
        ZMCGuidepageViewController *xt = [[ZMCGuidepageViewController alloc] init];
        self.window.rootViewController = xt;
        xt.delegate = self;
    }else{
        [self click];
    }


  
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"first" localizedTitle:@"菜谱" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"caipu-3D"] userInfo:nil];
    
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"second" localizedTitle:@"逛菜场" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"guangcaichang-3D"] userInfo:nil];
    
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"three" localizedTitle:@"我的订单" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithTemplateImageName:@"dingdan-3D"] userInfo:nil];
    
    
    ZMCLog(@"%.1f", IOS_VERSION);
    if (IOS_VERSION >= 9.0) {
        application.shortcutItems = @[item3, item2, item1];
    }
    
    return YES;
}


- (void)click{
    self.window.rootViewController = [[ZMCCustomeTabBarController alloc] init];
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    
    NSString *str = [NSString stringWithFormat:@"%lu", (unsigned long)tabBarVc.selectedIndex];
    ZMCLog(@"%@", str);
    NSInteger selected = [str integerValue];
    
    UINavigationController *nav = tabBarVc.childViewControllers[selected];

    if ([shortcutItem.type isEqualToString:@"first"]) {
        
        tabBarVc.selectedIndex = 1;
        
    }else if ([shortcutItem.type isEqualToString:@"second"]){
        
        tabBarVc.selectedIndex = 2;
        
    }else if ([shortcutItem.type isEqualToString:@"three"]){
        
        if (TOKEN) {
    
            ZMCMyorderViewController *orderVc = [[ZMCMyorderViewController alloc] init];
            
            [nav pushViewController:orderVc animated:YES];
            
        }else{
        
            [nav presentViewController:[ZMCLoginViewController shared] animated:YES completion:nil];
        
        }
        
    }

}





#pragma mark - 处理回调设置delegate
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{

    return [WXApi handleOpenURL:url delegate:self];

}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ALIPAY object:resultDic];
                NSString *str = resultDic[@"memo"];
                if (resultDic){
                    if ([@"9000" isEqualToString:[resultDic objectForKey:@"resultStatus"]]){
                        
                        [SVProgressHUD showSuccessWithStatus:@"充值成功"];
                        
                    }
                    else{
                        //交易失败
                        
                            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                            [SVProgressHUD showErrorWithStatus:str];
                    }
                }
                else{
                    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];

                    //交易失败
                    [SVProgressHUD showErrorWithStatus:@"充值失败"];
                }
                
            }];
        }else{
            [WXApi handleOpenURL:url delegate:self];
        }
        return YES;

    }
    return result;

    
}



/**
 *  iOS9 代理调用方法
 */
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
   
    NSString *strUrl = [NSString stringWithFormat:@"%@", url];
    ZMCLog(@"跳转过来的url--->>>%@ ----- %@", strUrl, url.host);
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"支付结果  result = %@",resultDic);
                
                NSString *str = resultDic[@"memo"];
                
                [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                    NSLog(@"result = %@",resultDic);
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_ALIPAY object:resultDic];
                    if (resultDic){
                        if ([@"9000" isEqualToString:[resultDic objectForKey:@"resultStatus"]]){
                            
                            [SVProgressHUD showSuccessWithStatus:@"充值成功"];
                            
                        }
                        else{
                            //交易失败
                            [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                            [SVProgressHUD showErrorWithStatus:str];
                        }
                    }
                    else{
                        //交易失败
                        [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                        
                        [SVProgressHUD showErrorWithStatus:@"充值失败"];
                    }
                    
                }];
                
                
            }];
            // zenmechi://zmcclient/?id=108
//        }else if ([url.host isEqualToString:@"zmcclient"]){
//            
//            NSRange range = [strUrl rangeOfString:@"id="];
//            
//            if (range.location != NSNotFound) {
//                NSString *idStr = [strUrl substringFromIndex:25];
//                ZMCLog(@"截取后的字符串----%@", idStr);
//                [self gotoControllerID:idStr];
//            }
//            
        }else{
            
            [WXApi handleOpenURL:url delegate:self];
            
        }
        return YES;

    }
    
    return result;
    
}


///**
// *  跳转方法
// */
//- (void)gotoControllerID:(NSString *)id_{
//
//    
//    GoodsDetailVC *gdVc = [[GoodsDetailVC alloc] init];
//    
//    gdVc.goods_id = id_;
//    
//    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
//
//    NSString *str = [NSString stringWithFormat:@"%lu", (unsigned long)tabBarVc.selectedIndex];
//    ZMCLog(@"%@", str);
//    NSInteger selected = [str integerValue];
//    UINavigationController *nav = tabBarVc.childViewControllers[selected];
//    [nav pushViewController:gdVc animated:YES];
//}



// 微信支付回调代理方法
- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
//                strMsg = @"支付结果：成功！";
                ZMCLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"wu"]];
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                    [SVProgressHUD dismiss];
                });
                break;
//            case WXErrCodeUserCancel:
//                
//                //                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                ZMCLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
//                [SVProgressHUD showErrorWithStatus:@"用户取消"];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
//                });
            default:
                [SVProgressHUD setErrorImage:[UIImage imageNamed:@"wu"]];
                [SVProgressHUD showErrorWithStatus:@"支付失败"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                
                break;
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    }

}

//- (void)payResult:(BOOL)isSuccess{
//    [PayManager payResult:isSuccess];
//}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    
//  清除userdefault的缓存
    [USER_DEFAULT setObject:nil forKey:@"infoArray"];
    [USER_DEFAULT setObject:nil forKey:@"cateIDs"];
    

    // APP中断时保存
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Lj.ZMC" in the application's documents directory.
    /*
     获取数据的存放路径
     存在沙盒的document中
     */
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

// 数据模型的建立
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    
    // 懒加载
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    // 获得模型的URL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ZMC" withExtension:@"momd"];
    // 通过url获得managedObjectModel
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// 持久化存储的设置
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    // 持久化存储控制器
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    // 获得存储的位置
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ZMC.sqlite"];
    
    // 设置存储方式,存储位置,得到定义好的持久化存储位置
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end
