//
//  UIBarButtonItem+NavButton.m
//  OperationsApp
//
//  Created by Daniel on 15/5/21.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import "UIBarButtonItem+NavButton.h"
//#import "UIButton+TapScope.h"
@implementation UIBarButtonItem (NavButton)
+(instancetype)getNavButtomItemWithTarget:(id)target andSel:(SEL)method withTitle:(NSString *)title{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    UIButton *rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 35)];
//    rightButton.backgroundColor = [UIColor redColor];
    [rightButton addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font =[UIFont systemFontOfSize:14];
    [buttomView addSubview:rightButton];
    rightButton.center= CGPointMake(rightButton.center.x, buttomView.center.y);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    return  rightButtonItem;

    
}

+(instancetype)getNavButtomItemWithTarget:(id)target andSel:(SEL)method withImage:(NSString *)imageV left:(BOOL)truebool{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    buttomView.backgroundColor = RedColor;
    if (truebool) {
        
        UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [rightButton addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:[UIImage imageNamed:imageV] forState:UIControlStateNormal];
        [buttomView addSubview:rightButton];
//        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
        rightButton.center= CGPointMake(rightButton.center.x, buttomView.center.y);

    }else{

        UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        [rightButton addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
        [rightButton setImage:[UIImage imageNamed:imageV] forState:UIControlStateNormal];
        [buttomView addSubview:rightButton];
        rightButton.center= CGPointMake(rightButton.center.x, buttomView.center.y);
//        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        
    }
    
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc]initWithCustomView:buttomView];
    rightButtonItem.tag = 0;
    
    return  rightButtonItem;

}

+(instancetype)getBackButtomItemWithTarget:(id)target andSel:(SEL)method{
    
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    [leftButton addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"navBar_BackLeft"] forState:UIControlStateNormal];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    return leftButtonItem;
    
}

/**
 *  //自定义返回按钮

 */
@end
