//
//  GuidePageView.m
//  WashApp
//
//  Created by Daniel on 15/1/14.
//  Copyright (c) 2015年 Daniel. All rights reserved.
//

#import "GuidePageView.h"
#define IMGCOUNT 3
@implementation GuidePageView{
    float angle;
}



-(id)initWithFrame:(CGRect)frame{
    
    
    if (self =[super initWithFrame:frame]) {
        
        
        UIScrollView *buttomSc =[[UIScrollView alloc] initWithFrame:frame];

        for (int i=0; i<IMGCOUNT; i++) {
            
            UIImageView *tempImg =[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width*i, 0, frame.size.width, frame.size.height)];
//            tempImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"bg-walk%i@2x.png",i+1]];
            
            if (RETINA_3) {
                tempImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"intro_%i.png",i+1]];
            }else if(RETINA_4){
                tempImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"intro_%i@2x.png",i+1]];
                //guide_image_1
//                tempImg.image =[UIImage imageNamed:[NSString stringWithForxmat:@"guide_image_%i.png",i+1]];
                
            }else if(RETINA_6Plus){
                tempImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"intro_%i@2x.png",i+1]];
            }else if(pad2Screen||padAirScreen){
                tempImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"intro_%i_pad.png",i+1]];
            }else{
                tempImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"intro_%i@2x.png",i+1]];
            }
            
            [buttomSc addSubview:tempImg];
            
        }
        
        buttomSc.scrollEnabled =YES;
        buttomSc.pagingEnabled =YES;
        buttomSc.bounces =NO;
        buttomSc.contentSize =CGSizeMake(SCREEN_SIZE.width*IMGCOUNT, SCREEN_SIZE.height);
        buttomSc.backgroundColor =[UIColor whiteColor];
        buttomSc.showsHorizontalScrollIndicator=NO;
        
        //移除按钮
        UIButton *btn =[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width*2, 0, SCREEN_W, SCREEN_H)];
//        if (RETINA_3||pad2Screen||padAirScreen||padAirScreen) {
//            btn.center =CGPointMake(SCREEN_SIZE.width*2+SCREEN_SIZE.width/2, SCREEN_SIZE.height-70);
//        }else{
//            btn.center =CGPointMake(SCREEN_SIZE.width*2+SCREEN_SIZE.width/2, SCREEN_SIZE.height-90);
//        }
//        if (RETINA_6Plus) {
//            
//            btn.frame =CGRectMake(SCREEN_SIZE.width*2, 0, 200   , 90);
//            btn.center =CGPointMake(SCREEN_SIZE.width*2+SCREEN_SIZE.width/2, SCREEN_SIZE.height-95);
//            [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        }else{
//            
//            
//
//        }
        btn.backgroundColor =[UIColor clearColor];
        
        [btn addTarget:self action:@selector(disMissWindow) forControlEvents:UIControlEventTouchUpInside];
        [buttomSc addSubview:btn];
        [self addSubview:buttomSc];
        self.backgroundColor =ThemeGreenColor;
        
    }
    
    return self;
}
-(void)disMissWindow{
    
    if (self.dismiss) {
        self.dismiss();
    }
    
    
    [UIView animateWithDuration:1 animations:^{

        self.center =CGPointMake(-100, 200);
        self.transform =CGAffineTransformMakeRotation(-M_PI_4);

        self.alpha =0;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        
    }];
    

    
    
}
- (void)startAnimation
{
//    angle =10;
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(-angle * (M_PI / 180.0f));
    
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.layer.anchorPoint = CGPointMake(0,1);//围绕点
        self.layer.position = CGPointMake(0, SCREEN_SIZE.height);//位置</span>
//        self.transform =CGAffineTransformMakeRotation(-M_PI_4);
        self.transform =endAngle;
//        self.alpha =0;
    } completion:^(BOOL finished) {
        angle += 10;
//        if (angle ==100) {
//            <#statements#>
//        }
        if (angle <=100) {
           [self startAnimation];
        }
        
        ZMCLog(@"%f",angle);
//         [self removeFromSuperview];
    }];
    
}

/**
 *  逻辑判断是否应该展示引导页
 *
 *  @return yes 表示应该展示给用户看
 */
+(BOOL)shouShowGuideView{
    
    BOOL showGuide =NO;
    
    //比较版本
    NSString *version = CLIENT_VERSION;
    NSString *oldVersion = [[NSUserDefaults standardUserDefaults]valueForKey:@"firstLanch"];
    if (![version isEqualToString:oldVersion]) {
        showGuide =YES;
        
        
    }else{
        showGuide =NO;
    }
    
    
    return showGuide;
    
}

-(void)dealloc{
    ZMCLog(@"delloc guidiview");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
