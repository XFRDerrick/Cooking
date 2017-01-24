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

/*
 @property (nonatomic, assign) NSInteger resourceid;
 @property (nonatomic, copy) NSString *type;
 @property (nonatomic, assign) NSInteger listID;
 @property (nonatomic, copy) NSString *title;
 @property (nonatomic, copy) NSString *img;
 @property (nonatomic, copy) NSString *addtimedesc;
 @property (nonatomic, copy) NSString *score;
 @property (nonatomic, copy) NSString *intro;
 @property (nonatomic, assign) NSInteger clickcount;
 @property (nonatomic, assign) NSInteger comments;
 @property (nonatomic, assign) NSInteger rank;
 
 @property (nonatomic, copy) NSString *rankdesc;
 @property (nonatomic, copy) NSString *tagdesc;
 */

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeInteger:self.resourceid forKey:@"resourceid"];
    [aCoder encodeInteger:self.listID forKey:@"listID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeInteger:self.clickcount forKey:@"clickcount"];
    [aCoder encodeObject:self.rankdesc forKey:@"rankdesc"];
    [aCoder encodeInteger:self.comments forKey:@"comments"];

    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.resourceid = [aDecoder decodeIntegerForKey:@"resourceid"];
        self.listID = [aDecoder decodeIntegerForKey:@"listID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.rankdesc = [aDecoder decodeObjectForKey:@"rankdesc"];
        self.comments = [aDecoder decodeIntegerForKey:@"comments"];
        self.clickcount = [aDecoder decodeIntegerForKey:@"clickcount"];
    }
    return self;
}


@end
