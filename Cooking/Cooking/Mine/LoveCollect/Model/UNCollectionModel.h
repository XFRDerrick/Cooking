//
//  UNCollectionModel.h
//  Cooking
//
//  Created by universe on 2017/1/23.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UNCollectionModel : NSObject

@property (nonatomic, strong) NSArray<HomeListResultModel *> *cookingStyleData;
@property (nonatomic, strong) NSArray<MenuDataModel *> *recommendData;
@property (nonatomic, strong) NSArray<UNDietListDataRecipesModel *> *dietData;

@property (nonatomic, strong) NSArray<UNDietBaiKeListModel *> *healthyDietData;

@property (nonatomic, assign,getter=isCollectionNil) BOOL collectionNil;

@end
