//
//  ZMCMyCell.m
//  ZMC
//
//  Created by will on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMyCell.h"

@implementation ZMCMyCell

- (void)setFrame:(CGRect)frame{
//    frame.size.height -= 1;
    
    [super setFrame:frame];
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView style:(UITableViewCellStyle)style{
    static NSString *ID = @"cell";
    
    ZMCMyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ZMCMyCell alloc] initWithStyle:style reuseIdentifier:ID];
    }
    
    return cell;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    return [self cellWithTabelView:tableView style:UITableViewCellStyleValue1];
}

- (void)setItem:(ZMCMyItem *)item{
    _item = item;
    
    self.imageView.image = item.image;
    self.textLabel.text = item.title;
    self.textLabel.textColor = UIColorFromRGB(0x666666);
    self.detailTextLabel.text = item.subTitle;
    // 设置右侧视图
    [self setupRightView];
}
// 设置右侧视图
- (void)setupRightView{
    // 设置右侧视图
    if ([_item isKindOfClass:[ZMCMyArrowItem class]]) {
        // 箭头模型
//        UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right"]];
//        self.accessoryView = arrowImageView;
        // 使用系统的箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }else{
        self.accessoryView = nil;
    }
    
}


@end
