//
//  UNDietCollectionViewCell.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietCollectionViewCell.h"

@interface UNDietCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *foodImageIV;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLable;
@property (weak, nonatomic) IBOutlet UILabel *foodDescLable;



@end


@implementation UNDietCollectionViewCell

- (void)setRecipesModel:(UNDietListDataRecipesModel *)recipesModel{
    
    _recipesModel = recipesModel;
    [self.foodImageIV setImageWithURL:[NSURL URLWithString:recipesModel.img_url] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    self.foodNameLable.text = recipesModel.title;
    self.foodDescLable.text = recipesModel.desc;
}


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
