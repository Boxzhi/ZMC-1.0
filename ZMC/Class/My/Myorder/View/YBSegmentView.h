//
//  YBSegmentView.h
//  WashApp
//
//  Created by Daniel on 14/12/19.
//  Copyright (c) 2014年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YBSegmentViewPro <NSObject>
@optional
-(void)YbSegDidSelect:(NSInteger )didSelect;


@end
@interface YBSegmentView : UIView<UIScrollViewDelegate>


@property(nonatomic,strong) NSMutableArray *titleSegBtnAry;

@property(nonatomic) id<YBSegmentViewPro> YBsegDelegete;

@property(nonatomic,strong)   UIView *lineView ;

@property (assign, nonatomic) float scroFlot;

@property (strong, nonatomic) NSMutableArray *centerAry;

@property (assign, nonatomic) NSInteger currentIndex;;

@property(nonatomic,strong)NSMutableArray *numberAry;//红色小标记数组

-(void)showRedLab;

-(void)customScrollview:(NSInteger)currentIndexNew withAnimation:(BOOL)anition;

@end
