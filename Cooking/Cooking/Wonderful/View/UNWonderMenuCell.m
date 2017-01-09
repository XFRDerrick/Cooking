//
//  UNWonderMenuCell.m
//  Cooking
//
//  Created by universe on 2017/1/7.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNWonderMenuCell.h"

@interface UNWonderMenuCell ()

@property (weak, nonatomic) IBOutlet UIImageView *backGroundIamgeIV;
@property (weak, nonatomic) IBOutlet UILabel *descLable;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (weak, nonatomic) IBOutlet UILabel *updateLable;
@property (weak, nonatomic) IBOutlet UILabel *topTitleLable;

@end

@implementation UNWonderMenuCell

- (void)setModel:(MenuDataModel *)model{

    _model = model;
    [self.backGroundIamgeIV setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    
    self.topTitleLable.text = model.title;
    
    self.descLable.text = model.desc;
    
    [self.timeButton setTitle:model.maketime forState:UIControlStateNormal];
    self.timeButton.userInteractionEnabled = NO;
    self.updateLable.text = model.releaseDate;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
