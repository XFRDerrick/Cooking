//
//  UNDietBaikeCell.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietBaikeCell.h"

@interface UNDietBaikeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *countLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;



@end

@implementation UNDietBaikeCell

- (void)setModel:(UNDietBaiKeListModel *)model{

    _model = model;
    [self.imageIV setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:@"fav_sx_icon_36"]];
    self.titleLable.text = model.title;
    self.countLable.text = @(model.clickcount).stringValue;
    self.timeLable.text = model.addtimedesc;
}

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
