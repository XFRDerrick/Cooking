//
//  UNSelectTitleViewController.h
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnIndexBlock)(NSUInteger);

@interface UNSelectTitleViewController : UIViewController

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) ReturnIndexBlock returnIndexBlock;
@end
