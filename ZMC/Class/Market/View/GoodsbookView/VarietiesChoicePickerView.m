//
//  VarietiesChoicePickerView.m
//  ZMC
//
//  Created by Naive on 16/5/30.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "VarietiesChoicePickerView.h"

@interface VarietiesChoicePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;

@property (strong, nonatomic) GoodsCategoryChildsChilds *model;

@end

@implementation VarietiesChoicePickerView

#pragma mark - action

- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"VarietiesChoicePickerView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
        
        _model = [[GoodsCategoryChildsChilds alloc] init];
        self.model.child_id = -1;
        self.model.name = @"品种";
        
        [self customView];
    }
    return self;
}


- (void)customView{
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - setter && getter

//- (GoodsCategoryChildsChilds *)_model{
//    if (!_model) {
////        _name = [[AreaObject alloc]init];
//        _model = [[GoodsCategoryChildsChilds alloc] init];
//    }
//    return _model;
//}

//选择完成
- (IBAction)finishBtnPress:(UIButton *)sender {
    if (self.block) {
        self.block(self,sender,self.model);
    }
    [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    
    [self hide];
}

#pragma  mark - function

- (void)show{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    UIView *topView = [win.subviews firstObject];
    [topView addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.childs_model.childs.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        return @"品种";
    }
    return self.childs_model.childs[row-1].name;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
//    [self.pickView reloadComponent:1];
//    [self.pickView selectRow:0 inComponent:1 animated:YES];
    
    if (row == 0) {
        self.model.child_id = -1;
        self.model.name = @"品种";
    }else {
        
        self.model.child_id = self.childs_model.childs[row-1].child_id;
        self.model.name = self.childs_model.childs[row-1].name;
    }
}
@end
