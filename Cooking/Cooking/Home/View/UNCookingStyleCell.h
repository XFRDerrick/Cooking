//
//  UNCookingStyleCell.h
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UNCookingStyleCell;
@protocol UNCookingStyleCellDelegate <NSObject>

- (void)cookingStyleCell:(UNCookingStyleCell *)cell didClickShowAllButton:(UIButton *)sender;

@end

@interface UNCookingStyleCell : UITableViewCell

#pragma mark
@property (nonatomic, weak) id<UNCookingStyleCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
