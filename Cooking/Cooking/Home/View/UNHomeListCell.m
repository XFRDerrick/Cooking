//
//  UNHomeListCell.m
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNHomeListCell.h"

@interface UNHomeListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *foodImageIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *useTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *differentLable;
@property (weak, nonatomic) IBOutlet UILabel *tasetLable;

@property (weak, nonatomic) IBOutlet UILabel *likeCount;


@end

@implementation UNHomeListCell

- (void)setModel:(HomeListResultModel *)model{

    _model = model;
    [self.foodImageIV setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    self.titleLable.text = model.title;
    self.differentLable.text = [NSString stringWithFormat:@"操作：%@",model.cooking_different?model.cooking_different:@"-"];
    self.tasetLable.text = [NSString stringWithFormat:@"口味：%@",model.taste];
    self.likeCount.text = @(model.likes).stringValue;
    self.useTimeLable.text = model.cooking_time;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.foodImageIV.layer.cornerRadius = 3;
    self.foodImageIV.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
