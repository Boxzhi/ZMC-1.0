//
//  ZMCMarcetRightCollectionViewCell.m
//  ZMC
//
//  Created by 睿途网络 on 16/4/26.
//  Copyright © 2016年 MindminiMac. All rights reserved.
//

#import "ZMCMarcetRightCollectionViewCell.h"

@implementation ZMCMarcetRightCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        NSArray *arrayCell = [[NSBundle mainBundle]loadNibNamed:@"ZMCMarcetRightCollectionViewCell" owner:self options:nil];
        
        if (arrayCell.count < 1) {
            
            return nil;
        }
        if (![[arrayCell objectAtIndex:0]isKindOfClass:[UICollectionViewCell class]]) {
            
            return nil;
        }
        self = [arrayCell objectAtIndex:0];
    }
    
    return self;
}

@end
