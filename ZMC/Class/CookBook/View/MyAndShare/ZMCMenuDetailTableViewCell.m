//
//  ZMCMenuDetailTableViewCell.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMenuDetailTableViewCell.h"
#import "ZMCMyDetailItem.h"

@interface ZMCMenuDetailTableViewCell()

/**
 *  同事的头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *personHead;

/**
 *  同事的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *personName;

/**
 *  该同事选择的菜的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *selectedDishCount;

/**
 *  第一道菜的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *dishNameOne;

/**
 *  第二道菜的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *dishNameTwo;

/**
 *  第三道菜的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *dishNameThree;



@end


@implementation ZMCMenuDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setItem:(ZMCMyDetailItem *)item
{
    _item = item;
    
    [self.personHead sd_setImageWithURL:[NSURL URLWithString:item.avatar_url]];
    
    self.personName.text = item.nickname;
    
    self.selectedDishCount.text = [NSString stringWithFormat:@"共选择了%@道菜", item.count];
    
    NSInteger cookbookCount = item.bookcook_selected.count;
    
    // 图片数组
    NSArray *imageArr = @[
                          self.dishPictureOne,
                          self.dishPictureTwo,
                          self.dishPictureThree
                          ];
    // 菜名称数组
    NSArray *nameArr = @[
                         self.dishNameOne,
                         self.dishNameTwo,
                         self.dishNameThree
                         ];
    if (cookbookCount > 3) {
        cookbookCount = 3;
    }
    
    for (int i = 0; i < cookbookCount; i++) {
        [self setDishName:nameArr[i] nameStr:item.bookcook_selected[i][@"cookbook_name"]];
        [self setBookcook_selected:item.bookcook_selected[i][@"pic"] imageView:imageArr[i]];
    }
    
    if (item.bookcook_selected.count == 1) {
        self.dishNameTwo.text = @"";
        self.dishNameThree.text = @"";
        self.dishPictureTwo.hidden = YES;
        self.dishPictureThree.hidden = YES;
        self.dishNameTwo.backgroundColor = [UIColor clearColor];
        self.dishNameThree.backgroundColor = [UIColor clearColor];
    }else if (item.bookcook_selected.count == 2){
        self.dishNameThree.text = @"";
        self.dishPictureThree.hidden = YES;
        self.dishNameThree.backgroundColor = [UIColor clearColor];
    }
    

}

// 设置菜的图片
- (void)setBookcook_selected:(NSString *)dishPicture imageView:(UIImageView *)imagevIew{
    [imagevIew sd_setImageWithURL:[NSURL URLWithString:dishPicture] placeholderImage:[UIImage imageNamed:@"wodecaidan-1"]];
}
// 设置菜的名称
- (void)setDishName:(UILabel *)dishlabel nameStr:(NSString *)nameStr{
    dishlabel.text = nameStr;
}



@end
