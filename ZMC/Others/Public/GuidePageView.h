//
//  GuidePageView.h
//  WashApp
//
//  Created by Daniel on 15/1/14.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePageView : UIView

@property (copy,nonatomic) dispatch_block_t dismiss;

+(BOOL)shouShowGuideView;
@end
