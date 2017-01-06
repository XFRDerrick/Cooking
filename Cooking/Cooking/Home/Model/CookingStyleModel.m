
//
//  CookingStyleModel.m
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "CookingStyleModel.h"

@implementation CookingStyleModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{

    return @{@"posts":@"CookingStylePostsModel"};
}


@end


@implementation CookingStylePostsModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{

    return @{@"postsID":@"id"};
}

@end

