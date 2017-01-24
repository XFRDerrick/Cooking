//
//  UNNormalFoodCell.m
//  Cooking
//
//  Created by universe on 2017/1/23.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNNormalFoodCell.h"

@implementation UNNormalFoodCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imageIV.layer.cornerRadius = 3;
    self.imageIV.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
