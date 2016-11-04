//
//  UITableView+Extend.m
//  SNS-New
//
//  Created by hexin on 14-9-10.
//  Copyright (c) 2014年 myhexin. All rights reserved.
//

#import "UITableView+Extend.h"
#import "HexColors.h"
#import <objc/runtime.h>

@implementation UITableView(Extend)

static char reloadDataBlockKey;

-(id)reloadDataBlock
{
    return objc_getAssociatedObject(self,&reloadDataBlockKey);
}

-(void)setReloadDataBlock:(id)block
{
    objc_setAssociatedObject(self, &reloadDataBlockKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setExtraCellLineHidden
{
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}

- (void)initTableView:(UIViewController*)parent
{
    [self setExtraCellLineHidden];
    parent.automaticallyAdjustsScrollViewInsets = NO;
}

/**
 *  @param isReachable  是否能连接网络
 *  @param block        点击加载按钮后处理
 */
-(void)setFooterViewNetWorkError:(BOOL)isReachable withBlock:(ReloadDataBlock)block
{
    [self setReloadDataBlock:block];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 300)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake( (CGRectGetWidth(view.bounds) - 130 )/2, CGRectGetWidth(view.bounds) * 145 / 568, 130, 97)];
    [imageView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x, imageView.frame.origin.y + 110, imageView.bounds.size.width + 20, 10)];
    [label setFont:[UIFont systemFontOfSize:15.f]];
    [label setTextColor:[UIColor colorWithHexString:@"ccc"]];
    [label setTextAlignment:NSTextAlignmentCenter];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.origin.x + 15, label.frame.origin.y + 30, imageView.bounds.size.width - 20, 30)];
    btn.layer.cornerRadius = 5.f;
    btn.layer.borderWidth = 1.f;
    btn.layer.masksToBounds = YES;
    [btn.layer setBorderColor:[UIColor colorWithHexString:@"e5e5e5"].CGColor];
//    [btn.layer setBorderColor:ThemeGreenColor.CGColor];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [btn setTitle:@"重新加载" forState:UIControlStateNormal];
//    [btn setBackgroundColor:ThemeGreenColor];
    [btn setTitleColor:[UIColor colorWithHexString:@"777"] forState:UIControlStateNormal];
//    [btn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(reloadBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    if (isReachable)
    {
        CGPoint origin = label.frame.origin;
        CGSize size = label.frame.size;
        [label setFrame:CGRectMake(60, origin.y, CGRectGetWidth(self.bounds) - 120, size.height)];
        [label setText:@"服务器正在努力加载，请重新加载"];
        [imageView setImage:[UIImage imageNamed:@"无数据占位图--服务器在偷懒.png"]];
    }
    else
    {
        [label setText:@"网络异常，请重新加载"];
        [imageView setImage:[UIImage imageNamed:@"无数据占位图--无网络.png"]];
    }
    
    [view addSubview:imageView];
    [view addSubview:label];
    [view addSubview:btn];
    
    self.tableFooterView = view;
    
    self.backgroundColor = [UIColor whiteColor];    
    [self reloadData];
}

#pragma mark 重新加载数据block
-(void)reloadBtnClicked
{
    ReloadDataBlock block = [self reloadDataBlock];
    block();
}
@end
