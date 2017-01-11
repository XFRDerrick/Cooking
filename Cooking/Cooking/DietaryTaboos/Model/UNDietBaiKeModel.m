//
//  UNDietBaiKeModel.m
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "UNDietBaiKeModel.h"

@implementation UNDietBaiKeModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{

    return @{@"list":@"UNDietBaiKeListModel"};
}

@end

@implementation UNDietBaiKeListModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"listID":@"id"};
}

@end
