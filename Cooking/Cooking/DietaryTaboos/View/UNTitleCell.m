//
//  UNTitleCell.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNTitleCell.h"

@interface UNTitleCell ()

@end

@implementation UNTitleCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 3;
    self.contentView.layer.cornerRadius = 5.0f;
    
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
}

@end
