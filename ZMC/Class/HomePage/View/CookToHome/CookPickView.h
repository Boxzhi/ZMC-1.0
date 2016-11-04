//
//  CookPickView.h
//  ZMC
//
//  Created by Ljun on 16/6/16.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CookPickViewDelegate <NSObject>

-(void)didFinishPickView:(NSString*)date;
-(void)pickerviewbuttonclick:(UIButton *)sender;
-(void)hiddenPickerView;

@end

@interface CookPickView : UIView

@property (nonatomic, copy) NSString *province;
@property(nonatomic,strong)NSDate*curDate;
@property (nonatomic,strong)UITextField *myTextField;
@property(nonatomic, strong) id<CookPickViewDelegate>delegate;
- (void)showInView:(UIView *)view;
- (void)hiddenPickerView;

@end
