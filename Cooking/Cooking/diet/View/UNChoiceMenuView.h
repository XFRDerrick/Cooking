//
//  UNChoiceMenuView.h
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBackBlock)(NSInteger);

@interface UNChoiceMenuView : UIView

//@property (nonatomic, strong) ButtonBackBlock buttonBackBlock;
@property (nonatomic, strong) ButtonBackBlock buttonBackBlock;

@end
