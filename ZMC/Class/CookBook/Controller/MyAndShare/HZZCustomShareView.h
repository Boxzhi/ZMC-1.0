//
//  HZZCustomShareView.h
//  ZMC
//
//  Created by MindminiMac on 16/6/24.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocial.h>
@interface HZZCustomShareView : UIView

+(instancetype)shareViewWithPresentedViewController:(UIViewController *)controller items:(NSArray *)items title:(NSString *)title content:(NSString *)content image:(UIImage *)image urlResource:(NSString *)url shareUrl:(NSString *)shareUrl;


@end
