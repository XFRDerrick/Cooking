//
//  UNAllFoodsListController.h
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CookingStyleModel.h"

@interface UNAllFoodsListController : UITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style withRow:(CookingStyle)cookStyle andDatas:(NSArray<CookingStylePostsModel *> *)allData;

@end
