//
//  UNMineCell.m
//  PublicNews
//
//  Created by universe on 2016/12/9.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNMineCell.h"

@interface UNMineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageIV;

@property (weak, nonatomic) IBOutlet UILabel *titleNameLable;

@end

@implementation UNMineCell

- (void)setImage:(UIImage *)image{

    _image = image;
    self.imageIV.image = image;
}
- (void)setTitle:(NSString *)title{

    _title = title;
    self.titleNameLable.text = title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
