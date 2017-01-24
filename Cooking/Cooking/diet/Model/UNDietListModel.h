//
//  UNDietListModel.h
//  Cooking
//
//  Created by universe on 2017/1/8.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UNDietListDataModel,UNDietListDataRecipesModel;

@interface UNDietListModel : NSObject
/*
 "result":"ok",
 "data":Array[8]
 */
@property (nonatomic, copy) NSString *result;
@property (nonatomic, strong)UNDietListDataModel *data;
@end

@interface UNDietListDataModel : NSObject
//"recipes":Array[40] 详细列表
@property (nonatomic, strong) NSArray<UNDietListDataRecipesModel *> *recipes;

@end

@interface UNDietListDataRecipesModel : NSObject<NSCoding>
/*
 "id":45,
 "title":"牛油果沙拉",
 "description":"超级健康的一款沙拉，纯素食但是营养全面哦~",
 "img_url":"http://ocb1i37yp.bkt.clouddn.com/jianfeishipu/shala/1.jpg?imageView2/2/w/200/h/200/interlace/0/q/90",
 "page_url":"http://zaijiawan.com/matrix_common/CookBook.jsp?mainId=4&id=45"
 */
@property (nonatomic, assign) NSInteger recipesId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *page_url;
- (void)encodeWithCoder:(NSCoder *)aCoder;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
@end


