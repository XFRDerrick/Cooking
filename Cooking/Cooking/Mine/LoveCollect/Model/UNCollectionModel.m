//
//  UNCollectionModel.m
//  Cooking
//
//  Created by universe on 2017/1/23.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNCollectionModel.h"

@implementation UNCollectionModel


- (BOOL)isCollectionNil{

    if (!_collectionNil) {
        
        _collectionNil = YES;
    }
    
    if (self.cookingStyleData.count == 0 && self.recommendData.count ==0 && self.dietData.count == 0 && self.healthyDietData.count == 0) {
        _collectionNil  = YES;
    }else{
        _collectionNil = NO;
    }
    
    return _collectionNil;
}

@end
