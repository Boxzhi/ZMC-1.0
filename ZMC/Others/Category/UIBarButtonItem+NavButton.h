//
//  UIBarButtonItem+NavButton.h
//  OperationsApp
//
//  Created by Daniel on 15/5/21.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NavButton)

+(instancetype)getNavButtomItemWithTarget:(id)target andSel:(SEL)method withTitle:(NSString *)title;

/**
 *  通用增加 左右按钮
 *
 *  @param target   <#target description#>
 *  @param method   <#method description#>
 *  @param imageV   <#imageV description#>
 *  @param truebool <#truebool description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)getNavButtomItemWithTarget:(id)target andSel:(SEL)method withImage:(NSString *)imageV left:(BOOL)truebool;


+(instancetype)getBackButtomItemWithTarget:(id)target andSel:(SEL)method;


@end
