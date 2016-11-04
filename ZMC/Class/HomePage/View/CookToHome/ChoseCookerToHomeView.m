//
//  ChoseCookerToHomeView.m
//  ZMC
//
//  Created by Ljun on 16/6/15.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ChoseCookerToHomeView.h"
#import "CuiPickerView.h"

@interface ChoseCookerToHomeView ()

{
    UIButton *_selectButton;
}

@end

@implementation ChoseCookerToHomeView

//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    self = [super initWithFrame:frame];
//    
//    if (self) {
//        
//       
//        
//        [self getButton];
//    }
//    return self;
//}
//
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
//    [_cuiPickerView showInView:self];
//}
//
//-(void)didFinishPickView:(NSString *)date
//{
//    self.dataString = date;
//    _getTimeTF.text = date;
//}
//
//- (void) getButton {
//    
//    self.button1.tag = 300;
//    self.button2.tag = 301;
//    self.button3.tag = 302;
//    self.button4.tag = 303;
//    self.button5.tag = 304;
//}

- (IBAction)selectTime:(UIButton *)sender {
    
    [_selectButton setTitleColor:StringLightColor forState:UIControlStateNormal];
    _selectButton.layer.borderColor = [UIColor clearColor].CGColor;
    
    [sender setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    sender.layer.cornerRadius = 4;
    sender.layer.masksToBounds = YES;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = ThemeGreenColor.CGColor;
    _selectButton = sender;
    
    if (_selectButton.tag == 300) {
        
        self.timeString = @"1";
        
    }else if (_selectButton.tag == 301) {
        
        self.timeString = @"2";
        
    }else if (_selectButton.tag == 302) {
        
        self.timeString = @"3";
        
    }else if (_selectButton.tag == 303) {
        
        self.timeString = @"5";
        
    }else {
        
        self.timeString = @"24";
    }
    
}

@end
