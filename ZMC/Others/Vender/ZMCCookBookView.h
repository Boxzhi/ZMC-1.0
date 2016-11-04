//
//  ZMCCookBookView.h
//  ZMC
//
//  Created by 睿途网络 on 16/4/29.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CookBookViewSlideTypeCaver = 0,
    CookBookViewSlideTypeSlide = 1,
} CookBookViewSlideType;


@interface ZMCCookBookView : UIView

/** 字体大小 */
@property (nonatomic,strong)UIFont     *titleFont;

/** 没选择时标题颜色 */
@property (nonatomic,strong)UIColor    *unlSelectedColor;

/** 选择时标题颜色 */
@property (nonatomic,strong)UIColor    *selectedColor;

/** 滑块的颜色 */
@property (nonatomic,strong)UIColor    *SlideColor;

/** 是否提前加载下一个view */
@property (nonatomic,assign)BOOL       advanceLoadNextVc;

/** 滑块的样式 */
@property (nonatomic,assign)CookBookViewSlideType MenuVcSlideType;

/** 控制中button的tag赋值(防止与其他tag有冲突) */
@property (nonatomic,assign)NSInteger  MenuButtontag;

/** 导入数据 */
- (void)addSubVc:(NSArray *)vc subTitles:(NSArray *)titles;

@end
