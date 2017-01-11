//
//  UNHomeCollectionViewCell.m
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNHomeCollectionViewCell.h"

@interface UNHomeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *foodImageIV;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;


@end

@implementation UNHomeCollectionViewCell

- (void)setModel:(HomeMenuLinksModel *)model{

    _model = model;

    NSString *path = [NSString stringWithFormat:@"%@%@",kHomeListBasePath,model.thumb];
    [self.foodImageIV setImageWithURL:[NSURL URLWithString:path] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    self.titleLable.text = model.text;
    
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
