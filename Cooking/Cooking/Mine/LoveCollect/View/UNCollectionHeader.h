//
//  UNCollectionHeader.h
//  Cooking
//
//  Created by universe on 2017/1/24.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNCollectionHeader : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *rowButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *collectionsCountLable;

@end
