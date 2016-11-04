//
//  ZMCInputView.h
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMCInputView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *autographField;


+ (instancetype)InputView;

@end
