//
//  ChoseCookerToHomeView.h
//  ZMC
//
//  Created by Ljun on 16/6/15.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoseCookerToHomeView : UIView

@property (strong, nonatomic) IBOutlet UIButton *sureChoseCookerButton;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UITextField *getTimeTF;
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, strong) NSString *dataString;

@end
