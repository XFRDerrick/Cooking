//
//  UNDietaryModel.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietaryModel.h"

@implementation UNDietaryModel


+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{

    return @{@"posts":[CookingStylePostsModel class]};
}


@end

@implementation UNDietaryPostsModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"pistId":@"id"};
}

@end
