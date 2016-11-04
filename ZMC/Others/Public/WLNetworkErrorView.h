//
//  WLNetworkErrorView.h
//  YiHaiFarm
//
//  Created by Naive on 16/1/21.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardAndLineButton.h"

@protocol WLNetworkErrorViewDelegate <NSObject>

- (void)getReload;

@end

@interface WLNetworkErrorView : UIView{
    UIView *contentView;
    UIImageView *backgroundImg;
    UILabel *titleLabel ;
}

@property (nonatomic,strong) BoardAndLineButton *button;


@property (nonatomic , weak) id <WLNetworkErrorViewDelegate > delegete;
+(WLNetworkErrorView *)shared;
- (id)initWithText:(NSString *)text_ imageName:(NSString *)name_ buttonTitile:(NSString *)titile_;

- (void)networkErrorShow;
- (void)networkErrorRemove;

+ (void)dismiss;
+ (void)networkErrorShowWithBlock:(dispatch_block_t)reload;

@end
