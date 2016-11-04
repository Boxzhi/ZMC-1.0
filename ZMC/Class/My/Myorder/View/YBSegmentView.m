//
//  YBSegmentView.m
//  WashApp
//
//  Created by Daniel on 14/12/19.
//  Copyright (c) 2014年 Daniel. All rights reserved.
//

#import "YBSegmentView.h"

@implementation YBSegmentView{
    UIScrollView *bttom;
    
    NSMutableArray *numberLabAry;
    
    
}

@synthesize scroFlot,centerAry,currentIndex;
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        _lineView =nil;
        [obj removeFromSuperview];
        
        
    }];
    centerAry =[NSMutableArray array];
    numberLabAry =[NSMutableArray array];
    _numberAry =[NSMutableArray array];
    bttom =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, self.frame.size.height)];
    
    NSInteger aryyCount =self.titleSegBtnAry.count;
    for (int i =0; i<aryyCount; i++) {
        
        UIButton *tempBtn;
        if (aryyCount<4) {
            tempBtn =[[UIButton alloc] initWithFrame:CGRectMake(i* SCREEN_SIZE.width/aryyCount, 0, SCREEN_SIZE.width/aryyCount, self.frame.size.height)];
        }else{
            tempBtn =[[UIButton alloc] initWithFrame:CGRectMake(i* SCREEN_SIZE.width/4, 0, SCREEN_SIZE.width/4, self.frame.size.height)];
        }
        
        [tempBtn setTitle:[self.titleSegBtnAry objectAtIndex:i] forState:UIControlStateNormal];
        [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (i ==currentIndex) {
            [tempBtn setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
            tempBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
        }
        tempBtn.backgroundColor =[UIColor grayColor];
        [tempBtn addTarget:self action:@selector(didSelectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        tempBtn.titleLabel.font =[UIFont systemFontOfSize:15];
        tempBtn.backgroundColor =[UIColor clearColor];
        tempBtn.tag =10000+i;
        [bttom addSubview:tempBtn];

        

        //增加红色角标
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
        label.center =CGPointMake((SCREEN_SIZE.width/aryyCount)*0.9+SCREEN_SIZE.width/aryyCount*i, 10);
        label.textColor =[UIColor colorWithRed:1.000 green:0.341 blue:0.357 alpha:1.000];
        [bttom addSubview:label];
        [numberLabAry addObject:label];
        [self.numberAry addObject:@""];
        [centerAry addObject:@(tempBtn.center.x)];
        if (!_lineView) {
            
            _lineView =[[UIView alloc] initWithFrame:CGRectMake(0, 0 ,SCREEN_SIZE.width/4-5.0f, 2)];
            _lineView.center =CGPointMake(tempBtn.center.x, self.frame.size.height-1);
            _lineView.backgroundColor =ThemeGreenColor;
            [self addSubview:_lineView];
            
        }
        
    }
    [self addSubview:bttom];
    bttom.delegate =self;
    bttom.contentSize =CGSizeMake(SCREEN_SIZE.width/4*aryyCount, self.frame.size.height);
    //    bttom.pagingEnabled =YES;
    bttom.showsHorizontalScrollIndicator =NO;
    bttom.bounces =NO;
    //    UIView *hideView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, self.frame.size.height)];
    //    hideView.backgroundColor =[UIColor whiteColor];
    //    hideView.alpha =0.2;
    //添加两个边的阴影
    //    hideView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    hideView.layer.borderColor =[UIColor clearColor].CGColor;
    //    hideView.layer.borderWidth =1.0f;
    //    hideView.layer.shadowOffset = CGSizeMake(3,0);
    //    hideView.layer.shadowOpacity = 5;
    //    hideView.layer.shadowRadius=10.0;
    //    [self addSubview:hideView];
    [bttom scrollRectToVisible:CGRectMake(SCREEN_SIZE.width/4*(currentIndex-1), 0, SCREEN_SIZE.width, self.frame.size.height) animated:YES];
    if (centerAry.count >currentIndex) {
        _lineView.center =CGPointMake([[centerAry objectAtIndex:currentIndex] floatValue]-scroFlot, self.frame.size.height-1);
    }
       
    
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor whiteColor];
        
    }
    return self;
}


-(void)didSelectWithBtn:(id)sender{
    
    UIButton *btn=(UIButton *)sender;
    //    currentIndex =btn.tag -10000 -currentIndex;
    
    
    [[bttom subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj class] ==[UIButton class]) {
            if (((UIButton *)obj).tag ==btn.tag ) {
                
                [((UIButton *)obj) setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
                
                
                [UIView animateWithDuration:0.3 animations:^{
                    
                    ((UIButton *)obj).transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
                    
                }];
                
                //                scroFlot =40+SCREEN_SIZE.width/self.titleSegBtnAry.count*((btn.tag -10000)+1);
                //                if (currentIndex ==1) {
                //
                //                    scroFlot =scroFlot ;
                //
                //                }else if (currentIndex ==-1){
                //
                //                    scroFlot =scroFlot -SCREEN_SIZE.width/self.titleSegBtnAry.count*3;
                //
                //                }
                //                [bttom scrollRectToVisible:CGRectMake(scroFlot, 0, SCREEN_SIZE.width/4, 40) animated:YES];
                
                
            }else{
                [((UIButton *)obj) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    ((UIButton *)obj).transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
                    
                }];
                
                //                if (((UIButton *)obj).titleLabel.font.pointSize ==18) {
                //                    [UIView animateWithDuration:1 animations:^{
                //                        ((UIButton *)obj).titleLabel.font =[UIFont systemFontOfSize:15];
                //                    }];
                //                }
                
            }
            
        }
    }];
    
    currentIndex =btn.tag -10000;
    
    [bttom scrollRectToVisible:CGRectMake(SCREEN_SIZE.width/4*(currentIndex-1), 0, SCREEN_SIZE.width, self.frame.size.height) animated:YES];
    
    if ([self.YBsegDelegete respondsToSelector:@selector(YbSegDidSelect:)]) {
        [self.YBsegDelegete YbSegDidSelect:(NSInteger)currentIndex];
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.center =CGPointMake([[centerAry objectAtIndex:currentIndex] floatValue]-scroFlot, self.frame.size.height-1);
    } completion:^(BOOL finished) {
        
    }];
    
    
}



-(void)customScrollview:(NSInteger)currentIndexNew withAnimation:(BOOL)anition{
    
    currentIndex =currentIndexNew;
    
    [[bttom subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj class] ==[UIButton class]) {
            if (((UIButton *)obj).tag ==currentIndexNew+10000 ) {
                
                [((UIButton *)obj) setTitleColor:ThemeGreenColor forState:UIControlStateNormal];
                
                
                //                if (anition) {
                [UIView animateWithDuration:0.3 animations:^{
                    
                    ((UIButton *)obj).transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
                    
                }];
                
                
                //                }else{
                //                    ((UIButton *)obj).transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
                //                }
                
                
            }else{
                [((UIButton *)obj) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [UIView animateWithDuration:0.3 animations:^{
                    
                    ((UIButton *)obj).transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
                    
                }];
                
                
            }
            
        }
    }];
    
    
    
    [bttom scrollRectToVisible:CGRectMake(SCREEN_SIZE.width/4*(currentIndexNew-1), 0, SCREEN_SIZE.width, self.frame.size.height) animated:YES];
    
    if ([self.YBsegDelegete respondsToSelector:@selector(YbSegDidSelect:)]) {
        [self.YBsegDelegete YbSegDidSelect:(NSInteger)currentIndexNew];
    }
    
    //    if (anition) {
    [UIView animateWithDuration:0.2 animations:^{
        _lineView.center =CGPointMake([[centerAry objectAtIndex:currentIndexNew] floatValue]-scroFlot, self.frame.size.height-1);
    } completion:^(BOOL finished) {
        
    }];
    
    //    }else{
    //        _lineView.center =CGPointMake([[centerAry objectAtIndex:currentIndexNew] floatValue]-scroFlot, self.frame.size.height-1);
    //    }
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    NSLog(@"%f",scrollView.contentOffset.x);
    scroFlot =scrollView.contentOffset.x;
    _lineView.center=CGPointMake([[centerAry objectAtIndex:currentIndex] floatValue]-scroFlot, _lineView.center.y);
    
}

-(void)showRedLab{
    [self.numberAry enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[numberLabAry objectAtIndex:idx] setText:obj];
    }];
}




@end
