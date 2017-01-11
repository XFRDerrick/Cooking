//
//  HomeMenuModel.m
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "HomeMenuModel.h"

@implementation HomeMenuModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"links":[HomeMenuLinksModel class]};
}

@end

@implementation HomeMenuLinksModel



@end
