//
//  PlistWorkTools.h
//  Cooking
//
//  Created by universe on 2017/1/16.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UNCollectionModel.h"

@interface PlistWorkTools : NSObject

+ (UNCollectionModel *)readCollectionDatas;

+ (void)collectionFood:(id)foodModel;

@end
