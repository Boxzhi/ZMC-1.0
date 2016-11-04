//
//  HZZPopView.h
//  HZZPopView
//
//  Created by rt on 16/6/17.
//  Copyright © 2016年 All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HZZDirectionType)
{
    HZZypeOfUpLeft,     // 上左
    HZZypeOfUpCenter,   // 上中
    HZZypeOfUpRight,    // 上右
    
    HZZypeOfDownLeft,   // 下左
    HZZypeOfDownCenter, // 下中
    HZZypeOfDownRight,  // 下右
    
    HZZypeOfLeftUp,     // 左上
    HZZypeOfLeftCenter, // 左中
    HZZypeOfLeftDown,   // 左下
    
    HZZypeOfRightUp,    // 右上
    HZZypeOfRightCenter,// 右中
    HZZypeOfRightDown,  // 右下
    
};
@protocol hzzSelectIndexPathDelegate <NSObject>

- (void)selectIndexPathRow:(NSInteger )index;

@end

@interface HZZPopView : UIView

// backGoundView
@property (nonatomic, strong) UIView  * _Nonnull backGoundView;
// titles
@property (nonatomic, strong) NSArray * _Nonnull dataArray;
// images
@property (nonatomic, strong) NSArray * _Nonnull images;
// height
@property (nonatomic, assign) CGFloat row_height;
// font
@property (nonatomic, assign) CGFloat fontSize;
// teHZZColor
@property (nonatomic, assign) UIColor * _Nonnull titleTextColor;
// delegate
@property (nonatomic, assign) id <hzzSelectIndexPathDelegate> _Nonnull delegate;
// 初始化方法
- (instancetype _Nonnull)initWithOrigin:(CGPoint) origin
                         Width:(CGFloat) width
                        Height:(CGFloat) height
                          Type:(HZZDirectionType)type
                         Color:( UIColor * _Nonnull ) color;

- (void)popView;

- (void)dismiss;
@end
