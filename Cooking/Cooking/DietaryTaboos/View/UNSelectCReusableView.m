//
//  UNSelectCReusableView.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNSelectCReusableView.h"

@interface UNSelectCReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;



@end

@implementation UNSelectCReusableView

- (void)setTitle:(NSString *)title{

    _title = title;
    self.headerTitle.text = title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
