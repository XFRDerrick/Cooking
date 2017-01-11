//
//  HomeListModel.m
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"paging":@"HomeListPagingModel", @"result":@"HomeListResultModel"};
}

@end

@implementation HomeListPagingModel


@end

@implementation HomeListResultModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"resultId":@"id"};
}

@end
