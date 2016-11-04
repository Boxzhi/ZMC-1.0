//
//  SureChooseCookerView.m
//  ZMC
//
//  Created by Ljun on 16/6/15.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "SureChooseCookerView.h"
#import "ChoseCookerToHomeView.h"
#import "CuiPickerView.h"

@interface SureChooseCookerView ()<UITextFieldDelegate, CuiPickViewDelegate>

@property (nonatomic, strong) CuiPickerView *cuiPickerView;

@end



@implementation SureChooseCookerView

@synthesize alphaiView;

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
        alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        alphaiView.backgroundColor = [UIColor blackColor];
        alphaiView.alpha = 0.2;
        
        [self addSubview:alphaiView];
        
        self.addChoseCookerView = [[[NSBundle mainBundle]loadNibNamed:@"ChoseCookerToHomeView" owner:self options:nil] lastObject];
        
        self.addChoseCookerView.frame = CGRectMake(0, kScreenHeight/2, self.frame.size.width, self.frame.size.height-kScreenHeight/2);
        
//        self.addChoseCookerView.getTimeTF.delegate = self;
        
                
        [self getButton];
        
        
        [self addSubview:self.addChoseCookerView];
    }
    return self;
}

- (void) getButton {
    
    self.addChoseCookerView.button1.tag = 300;
    self.addChoseCookerView.button2.tag = 301;
    self.addChoseCookerView.button3.tag = 302;
    self.addChoseCookerView.button4.tag = 303;
    self.addChoseCookerView.button5.tag = 304;
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    textField.inputView = [[UIView alloc]initWithFrame:CGRectZero];
//    [_cuiPickerView showInView:self];
//}
//
//-(void)didFinishPickView:(NSString *)date
//{
//    self.addChoseCookerView.dataString = date;
//    self.addChoseCookerView.getTimeTF.text = date;
//}

@end
