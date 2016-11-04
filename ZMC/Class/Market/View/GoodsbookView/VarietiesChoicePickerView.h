//
//  VarietiesChoicePickerView.h
//  ZMC
//
//  Created by Naive on 16/5/30.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsCategoryModel.h"

@class VarietiesChoicePickerView;
typedef void (^AddressChoicePickerViewBlock)(VarietiesChoicePickerView *view,UIButton *btn,GoodsCategoryChildsChilds *model);

@interface VarietiesChoicePickerView : UIView

@property (copy, nonatomic)AddressChoicePickerViewBlock block;

@property (nonatomic, strong)GoodsCategoryChilds *childs_model;

- (void)show;

@end
