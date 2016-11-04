//
//  GoodsDetailDescriptionCell.m
//  ZMC
//
//  Created by Naive on 16/5/27.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "GoodsDetailDescriptionCell.h"
#import "NutritionCollocationView.h"

@implementation GoodsDetailDescriptionCell {
    
    UIView *bgView;
    
    UIWebView *webView;
    
    NSString *html_str;
}

- (void)setGoodsDetailDescription:(GoodsDetailResult *)model {
    
    html_str = model.detail_url;
    
    [self.leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (model.nutrition_collocation_lists.count == 0 && model) {
        
        self.leftView.hidden = YES;
        self.rightView.hidden = YES;
        
        UIButton *goodsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 40)];
        [goodsBtn setTitle:@"商品介绍" forState:UIControlStateNormal];
        [goodsBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
        goodsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:goodsBtn];
        
        UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_W, 1)];
        bgView1.backgroundColor = ThemeGreenColor;
        [self addSubview:bgView1];
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_W, 180)];
        bgView.backgroundColor = WHITE_COLOR;
        [self addSubview:bgView];
        
        webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 180)];
        webView.backgroundColor = [UIColor whiteColor];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html_str]]];
        //    [webView loadHTMLString:html_str baseURL:nil];
        [bgView addSubview:webView];
        
    }else {
        
        self.leftView.hidden = NO;
        self.rightView.hidden = NO;
    }
    
    if (model.nutrition_collocation_lists.count > 0) {
        
        NutritionCollocationView *view = (NutritionCollocationView *)[[[NSBundle mainBundle] loadNibNamed:@"NutritionCollocationView" owner:nil options:nil]lastObject];
//        view.frame = CGRectMake(0, 40*(1+i/2), self.leftBtn.frame.size.width, 40);
        //            [[NutritionCollocationView alloc] initWithFrame:CGRectMake(0, 40*(1+i/2), SCREEN_W/2, 40)];
        view.nutrition_collocation_name.text = model.nutrition_collocation_lists[0].name;
        view.nutrition_collocation_quantity.text = model.nutrition_collocation_lists[0].quantity;
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftBtn.mas_bottom).offset(2);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_centerX);
            make.height.equalTo(@40);
        }];
        
        UIView *my_view = view;
        for (int i = 1; i < model.nutrition_collocation_lists.count; i++) {
            
            //        NSLog(@"%@",model.nutrition_collocation_lists[i].name);
            
            if (i%2 == 0) {
                NutritionCollocationView *view = (NutritionCollocationView *)[[[NSBundle mainBundle] loadNibNamed:@"NutritionCollocationView" owner:nil options:nil]lastObject];
//                view.frame = CGRectMake(0, 40*(1+i/2), self.leftBtn.frame.size.width, 40);
                //            [[NutritionCollocationView alloc] initWithFrame:CGRectMake(0, 40*(1+i/2), SCREEN_W/2, 40)];
//                NSLog(@"--------------%f,%f",view.frame.size.width,self.leftBtn.frame.size.width);
                view.nutrition_collocation_name.text = model.nutrition_collocation_lists[i].name;
                view.nutrition_collocation_quantity.text = model.nutrition_collocation_lists[i].quantity;
                [self addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(my_view.mas_bottom).offset(1);
                    make.left.equalTo(self);
                    make.right.equalTo(self.mas_centerX);
                    make.height.equalTo(@40);
                }];
                my_view = view;
                
            }else{
                NutritionCollocationView *view = (NutritionCollocationView *)[[[NSBundle mainBundle] loadNibNamed:@"NutritionCollocationView" owner:nil options:nil]lastObject];
//                view.frame = CGRectMake(SCREEN_W/2, 40*(1+i/2), self.rightBtn.frame.size.width, 40);
                //            NutritionCollocationView *view = [[NutritionCollocationView alloc] initWithFrame:CGRectMake(SCREEN_W/2, 40*(1+i/2), SCREEN_W/2, 40)];
                view.nutrition_collocation_name.text = model.nutrition_collocation_lists[i].name;
                view.nutrition_collocation_quantity.text = model.nutrition_collocation_lists[i].quantity;
                [self addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(my_view);
                    make.left.equalTo(my_view.mas_right);
                    make.right.equalTo(self);
                    make.height.equalTo(@40);
                }];
                my_view = view;
            }
            
            
        }

    }
    
}


- (void)leftBtnClick {
    
    self.leftBtn.userInteractionEnabled = NO;
    self.rightBtn.userInteractionEnabled = YES;
    
    self.leftBgView.alpha = 1;
    self.leftTitle_lab.textColor = ThemeGreenColor;
    self.rightBgView.alpha = 0;
    self.rightTitle_lab.textColor = [UIColor darkGrayColor];
    
    [bgView removeFromSuperview];
}

- (void)rightBtnClick {
    
    self.leftBtn.userInteractionEnabled = YES;
    self.rightBtn.userInteractionEnabled = NO;
    
    self.rightBgView.alpha = 1;
    self.rightTitle_lab.textColor = ThemeGreenColor;
    self.leftBgView.alpha = 0;
    self.leftTitle_lab.textColor = [UIColor darkGrayColor];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_W, 180)];
    bgView.backgroundColor = WHITE_COLOR;
    [self addSubview:bgView];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_W-20, 180)];
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html_str]]];
//    [webView loadHTMLString:html_str baseURL:nil];
    [bgView addSubview:webView];
}

@end
