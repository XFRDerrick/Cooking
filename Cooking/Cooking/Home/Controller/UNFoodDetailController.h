//
//  UNFoodDetailController.h
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNFoodDetailController : UIViewController

@property (nonatomic, copy) NSString *resultId;

@property (nonatomic, strong) HomeListResultModel *model;

@end
