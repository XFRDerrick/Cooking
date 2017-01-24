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

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.publishAt forKey:@"publishAt"];
    [aCoder encodeObject:self.cooking_time forKey:@"cooking_time"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.taste forKey:@"taste"];
    [aCoder encodeObject:self.cooking_different forKey:@"cooking_different"];
    [aCoder encodeObject:self.thumbnail forKey:@"thumbnail"];
    [aCoder encodeObject:self.resultId forKey:@"resultId"];
    [aCoder encodeInteger:self.likes  forKey:@"likes"];

}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
         if (self = [super init]) {
             self.publishAt = [aDecoder decodeObjectForKey:@"publishAt"];
             self.cooking_time = [aDecoder decodeObjectForKey:@"cooking_time"];
             self.title = [aDecoder decodeObjectForKey:@"title"];
             self.taste = [aDecoder decodeObjectForKey:@"taste"];
             self.cooking_different = [aDecoder decodeObjectForKey:@"cooking_different"];
             self.thumbnail = [aDecoder decodeObjectForKey:@"thumbnail"];
             self.resultId = [aDecoder decodeObjectForKey:@"resultId"];
             self.likes = [aDecoder decodeIntegerForKey:@"likes"];
         }
         return self;
     }

@end
