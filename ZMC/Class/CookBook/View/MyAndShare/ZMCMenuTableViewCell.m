//
//  ZMCMenuTableViewCell.m
//  ZMC
//
//  Created by MindminiMac on 16/5/5.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMenuTableViewCell.h"
#import "ZMCMyListItem.h"

@interface ZMCMenuTableViewCell()
/**
 *  宴会的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *activityName;

/**
 *  宴会的时间
 */
@property (weak, nonatomic) IBOutlet UILabel *activityTime;

/**
 *  朋友点的菜的数量
 */
@property (weak, nonatomic) IBOutlet UILabel *friendsOrder;

/**
 *  点的菜的图片一
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureOne;

/**
 *  点的菜的图片二
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureTwo;

/**
 *  点的菜的图片三
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureThree;

/**
 *  点的菜的图片四
 */
@property (weak, nonatomic) IBOutlet UIImageView *dishPictureFour;

@end


@implementation ZMCMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(ZMCMyListItem *)item
{
    _item = item;
    
    self.activityName.text = item.title;
    
    self.activityTime.text = item.dinner_time;
    
    self.friendsOrder.text = [NSString stringWithFormat:@"您的朋友点了%@道菜", item.total_count];
    
    
    NSInteger count = item.bookcook_selected.count;
    
    switch (count) {
        case 0:
            self.dishPictureOne.hidden = YES;
            self.dishPictureTwo.hidden = YES;
            self.dishPictureThree.hidden = YES;
            self.dishPictureFour.hidden = YES;
        case 1:
            self.dishPictureTwo.hidden = YES;
            self.dishPictureThree.hidden = YES;
            self.dishPictureFour.hidden = YES;
        case 2:
            self.dishPictureThree.hidden = YES;
            self.dishPictureFour.hidden = YES;
        case 3:
            self.dishPictureFour.hidden = YES;
            break;
            
        default:
            break;
    }
    
    NSArray *disArr = @[self.dishPictureOne,
                        self.dishPictureTwo,
                        self.dishPictureThree,
                        self.dishPictureFour
                        ];
    if (count > 4) {
        count = 4;
    }
    for (int i = 0; i < count; i++) {
        [self setBookcook_selected:item.bookcook_selected[i] imageView:disArr[i]];
    }
    
}

- (void)setBookcook_selected:(NSDictionary *)dishPicture imageView:(UIImageView *)imagevIew{
        [imagevIew sd_setImageWithURL:[NSURL URLWithString:dishPicture[@"pic"]] placeholderImage:[UIImage imageNamed:@"caipufenxiang"]];

}

@end
