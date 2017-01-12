//
//  UNMineLoginHeaderCell.m
//  PublicNews
//
//  Created by universe on 2016/12/9.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "UNMineLoginHeaderCell.h"

@interface UNMineLoginHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageIV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;


@end

@implementation UNMineLoginHeaderCell


- (void)setInfo:(UNUserInfo *)info{
    _info = info;
    if (self.info) {
        self.userNameLable.text = self.info.screen_name;
        [self.headerImageIV setImageURL:[NSURL URLWithString:self.info.avatar_large]];
    }else{
//        setting_personal.png
        self.userNameLable.text = @"微博登陆";
        self.headerImageIV.image = [UIImage imageNamed:@"setting_personal.png"];
    }
    
}
//
//- (void)setHeaderImage:(UIImage *)headerImage{
//
//    _headerImage = headerImage;
//    [self.headerImageIV setImage:headerImage];
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
}

@end
