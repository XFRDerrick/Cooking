//
//  UNDietCollectionViewCell.h
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>
//dietk界面复用Cell 数据传递
#import "UNDietListModel.h"
@interface UNDietCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UNDietListDataRecipesModel *recipesModel;

@end
