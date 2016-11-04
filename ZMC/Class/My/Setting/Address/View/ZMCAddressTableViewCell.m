//
//  ZMCAddressTableViewCell.m
//  ZMC
//
//  Created by Will on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCAddressTableViewCell.h"
#import "ZMCPickerViewItem.h"

@interface ZMCAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ZMCAddressTableViewCell

//- (void)setFrame:(CGRect)frame{
//    frame.size.height -= 1;
//    [super setFrame:frame];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setItem:(ZMCPickerViewItem *)item
{
    _item = item;
    
    self.nameLabel.text = item.consignee;
    
    self.phoneLabel.text = item.mobile;
    
    NSString *is_default;
    if (item.is_default) {
        is_default = @"[默认]";
    }else{
        is_default = @"";
    }
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@", is_default, item.province_name, item.city_name, item.district_name, item.street_address];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
