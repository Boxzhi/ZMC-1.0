//
//  WLNetworkErrorView.m
//  YiHaiFarm
//
//  Created by Naive on 16/1/21.
//  Copyright © 2016年 Daniel. All rights reserved.
//

#import "WLNetworkErrorView.h"


@implementation WLNetworkErrorView 
+(WLNetworkErrorView *)shared {
    static dispatch_once_t pred;
    static WLNetworkErrorView *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[WLNetworkErrorView  alloc] initWithText:@"亲，您的手机网络不太顺畅喔~" imageName:@"wu.png" buttonTitile:@"重新加载"];
    });
    return shared;
}

- (id)initWithText:(NSString *)text_ imageName:(NSString *)name_ buttonTitile:(NSString *)titile_{
    
    if (self = [super init]) {
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_W, SCREEN_H-64)];
        contentView.backgroundColor = [UIColor whiteColor];
        
        backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 113)];
        backgroundImg.image = [UIImage imageNamed:name_];
        backgroundImg.center = CGPointMake(contentView.center.x, contentView.center.y-100);
        [contentView addSubview:backgroundImg];
        
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
        titleLabel.center = CGPointMake(contentView.center.x, backgroundImg.center.y+backgroundImg.frame.size.height);
        titleLabel.text = text_;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = [UIColor grayColor];
        [contentView addSubview:titleLabel];
        
        self.button = [[BoardAndLineButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        self.button.center = CGPointMake(contentView.center.x, titleLabel.center.y+titleLabel.frame.size.height);
        [self.button setTitle:titile_ forState:UIControlStateNormal];
        [self.button setCustomColor:ThemeGreenColor];
        [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            if ([self.delegete respondsToSelector:@selector(getReload)]) {
                [self.delegete getReload];
            }
            //发送通知
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonClick" object:nil];
        }];
        
        [contentView addSubview:self.button];
        
        [self addSubview:contentView];
    }
    
    return self;

}

-(void)dismissNetworkErrorView{
//    [contentView removeFromSuperview];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    self.center = window.center;
    for (int i=window.subviews.count-1; i>=0; i--) {
        if ([[window.subviews objectAtIndex:i] isKindOfClass:[UIView class]]&&
            ((UIButton*)[window.subviews objectAtIndex:i]).tag==4444) {
            [((UIButton*)[window.subviews objectAtIndex:i]) removeFromSuperview];
        }
    }
}


- (void)show {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    contentView.center = window.center;
    for (int i=window.subviews.count-1; i>=0; i--) {
        if ([[window.subviews objectAtIndex:i] isKindOfClass:[UIView class]]&&
            ((UIButton*)[window.subviews objectAtIndex:i]).tag==4444) {
            [((UIButton*)[window.subviews objectAtIndex:i]) removeFromSuperview];
        }
    }
    
    [window addSubview:contentView];
    [contentView setTag:4444];
}

#pragma mark - 网络错误
- (void)networkErrorShow {
    
//    WLNetworkErrorView *view = [[WLNetworkErrorView  alloc] initWithText:@"亲，您的手机网络不太顺畅喔~" imageName:@"discount_empty.png" buttonTitile:@"重新加载"];
//    [view show];
    [self show];
 
}

- (void)networkErrorRemove {

//    WLNetworkErrorView *view = [[WLNetworkErrorView  alloc] initWithText:@"亲，您的手机网络不太顺畅喔~" imageName:@"discount_empty.png" buttonTitile:@"重新加载"];
//    [view dismissNetworkErrorView];
    [self dismissNetworkErrorView];
}

+ (void)dismiss {
    [[self shared] dismissNetworkErrorView];
}

+ (void)networkErrorShowWithBlock:(dispatch_block_t)reload{
    
    
    [[self shared] show];
    
    [[[self shared].button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        if (reload) {
            reload();
        }
        
    }];
    
    
    
}
@end
