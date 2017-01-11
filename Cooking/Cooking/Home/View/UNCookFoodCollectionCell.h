//
//  UNCookFoodCollectionCell.h
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UNCookFoodCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *foodImageIV;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLable;

@property (weak, nonatomic) IBOutlet UILabel *foodDetailLable;

@end
