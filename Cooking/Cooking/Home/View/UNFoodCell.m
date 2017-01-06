//
//  UNFoodCell.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNFoodCell.h"

@interface UNFoodCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *describeLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;


@end

@implementation UNFoodCell

- (void)setPost:(CookingStylePostsModel *)post{

    _post = post;
    [self.iconImageIV setImageWithURL:[NSURL URLWithString:post.thumbnail] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    self.titleLable.text = post.title;
    self.describeLable.text = post.excerpt;
    self.timeLable.text = post.date;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImageIV.layer.cornerRadius = 3;
    self.iconImageIV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
