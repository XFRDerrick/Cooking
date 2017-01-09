//
//  UNCookFoodCollectionCell.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNCookFoodCollectionCell.h"

@implementation UNCookFoodCollectionCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 5;
    self.contentView.layer.cornerRadius = 5.0f;
    
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
}

@end
