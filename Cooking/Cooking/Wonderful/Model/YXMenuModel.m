//
//  YXMenuModel.m
//  TRProject
//
//  Created by 李晨 on 16/6/16.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "YXMenuModel.h"

@implementation YXMenuModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"data": [MenuDataModel class]};
}
@end
@implementation MenuDataModel
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id",
             @"desc": @"description"};
}


- (void)encodeWithCoder:(NSCoder *)aCoder{
  
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.maketime forKey:@"maketime"];
    [aCoder encodeObject:self.releaseDate forKey:@"releaseDate"];
    
    [aCoder encodeObject:self.detailsUrl forKey:@"detailsUrl"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.imageUrl = [aDecoder decodeObjectForKey:@"imageUrl"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.maketime = [aDecoder decodeObjectForKey:@"maketime"];
        self.releaseDate = [aDecoder decodeObjectForKey:@"releaseDate"];
        self.detailsUrl = [aDecoder decodeObjectForKey:@"detailsUrl"];
    }
    return self;
}


@end


