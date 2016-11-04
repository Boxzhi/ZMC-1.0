//
//  ZMCGuidepageViewController.h
//  ZMC
//
//  Created by MindminiMac on 16/6/22.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectDelegate <NSObject>

-(void)click;

@end

@interface ZMCGuidepageViewController : UIViewController

+ (BOOL)isShow;
@property (nonatomic, assign) id<selectDelegate> delegate;
@end
