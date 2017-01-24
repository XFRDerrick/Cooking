//
//  UNDietMenuModel.m
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietMenuModel.h"

@implementation UNDietMenuModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data":[UNDietMenuDataModel class]};
}
@end
@implementation UNDietMenuDataModel
@end


