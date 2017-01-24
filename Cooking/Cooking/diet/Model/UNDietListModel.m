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

/*
 @property (nonatomic, assign) NSInteger *recipesId;
 @property (nonatomic, copy) NSString *title;
 @property (nonatomic, copy) NSString *desc;
 @property (nonatomic, copy) NSString *img_url;
 @property (nonatomic, copy) NSString *page_url;
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.recipesId forKey:@"recipesId"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.img_url forKey:@"img_url"];
    [aCoder encodeObject:self.page_url forKey:@"page_url"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.recipesId = [aDecoder decodeIntegerForKey:@"recipesId"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.img_url = [aDecoder decodeObjectForKey:@"img_url"];
        self.page_url = [aDecoder decodeObjectForKey:@"page_url"];
    }
    return self;
}


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{

    return @{@"recipesId":@"id",@"desc":@"description"};
}

@end
