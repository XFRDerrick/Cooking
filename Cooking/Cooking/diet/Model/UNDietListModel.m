//
//  UNDietListModel.m
//  Cooking
//
//  Created by universe on 2017/1/8.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietListModel.h"

@implementation UNDietListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data":[UNDietListDataModel class]};
}

@end

@implementation UNDietListDataModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    
    return @{@"recipes":[UNDietListDataRecipesModel class]};
}

@end


@implementation UNDietListDataRecipesModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{

    return @{@"recipesId":@"id",@"desc":@"description"};
}

@end
