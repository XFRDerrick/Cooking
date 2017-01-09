//
//  UNDietMenuModel.h
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UNDietMenuDataModel;

@interface UNDietMenuModel : NSObject
@property (nonatomic, copy) NSString *result;
@property (nonatomic, strong) NSArray<UNDietListDataModel *> *data;
@end


@interface UNDietMenuDataModel : NSObject
@property (nonatomic, copy) NSString *mainId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *img_url;

//"recipes":Array[40] 详细列表
@end
