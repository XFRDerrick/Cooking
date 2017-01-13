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
        if (self.info.avatar_large.length > 0) {
            [self.headerImageIV setImageWithURL:[NSURL URLWithString:self.info.avatar_large] placeholder:[UIImage imageNamed:@"setting_personal.png"]];
        }
    }else{
        self.userNameLable.text = @"登陆";
        self.headerImageIV.image = [UIImage imageNamed:@"setting_personal.png"];
    }
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
}

@end
