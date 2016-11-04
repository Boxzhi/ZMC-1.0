//
//  PopView.h
//  ZMC
//
//  Created by MindminiMac on 16/5/4.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMCPopView;
@protocol ZMCPopViewDelegate <NSObject>

- (void)popView:(ZMCPopView *)popView didSelectButtonWithTag:(NSInteger)tag;

@end
@interface ZMCPopView : UIView


- (id)initWithFrame:(CGRect)frame andButtonTitleArray:(NSArray *)array;


@property (nonatomic, assign) id <ZMCPopViewDelegate> delegate;


@end
