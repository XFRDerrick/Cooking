//
//  UNMenuListCell.m
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNMenuListCell.h"

@interface UNMenuListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation UNMenuListCell

- (void)setModel:(HomeMenuLinksModel *)model{

    _model = model;
    NSString *path = [NSString stringWithFormat:@"%@%@",kHomeListBasePath,model.thumb];
    [self.imageIV setImageWithURL:[NSURL URLWithString:path] placeholder:[UIImage imageNamed:@"background_image.jpeg"]];
    self.titleLable.text = model.text;
   
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
