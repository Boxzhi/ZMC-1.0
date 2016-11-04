//
//  UIImageView+Header.m
//
//
//  Created by xmg on 16/1/31.
//  Copyright © 2016年 . All rights reserved.
//

#import "UIImageView+Header.h"


@implementation UIImageView (Header)

- (void)zmc_setHeader:(NSString *)url
{
    UIImage *placeholder = [UIImage imageNamed:@"my"];
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image == nil) return;
        
        self.image = image;
    }];
    
//    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)zmc_swtGoodCook:(NSString *)url {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"cook-xiangqing"]];
}

@end
