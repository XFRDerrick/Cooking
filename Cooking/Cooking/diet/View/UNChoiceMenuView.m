//
//  UNChoiceMenuView.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNChoiceMenuView.h"

@implementation UNChoiceMenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (IBAction)didSelectMenuChoice:(UIButton *)sender {

    self.buttonBackBlock(sender.tag);
}


@end
