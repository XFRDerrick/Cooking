//
//  NetManager.h
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "BaseNetManager.h"

#import "HomeMenuModel.h"
#import "HomeListModel.h"
#import "CookingStyleModel.h"

#import "YXMenuModel.h"

#import "UNDietListModel.h"
#import "UNDietMenuModel.h"

#import "UNDietaryModel.h"
#import "UNDietBaiKeModel.h"

//菜系种类
typedef enum{
    CookingStyleYueCai = 0,
    CookingStyleChuanCai,
    CookingStyleSuCai,
    CookingStyleZheCai,
    CookingStyleMinCai,
    CookingStyleHuiCai,
    CookingStyleLuCai,
    CookingStyleShangHaiCai,
    CookingStyleDongBeiCai,
    CookingStyleHongBei,
    
}CookingStyle;

@interface NetManager : BaseNetManager

+ (id)getHomeMenuModelCompletionHandler:(void (^)(HomeMenuModel *model, NSError *error))completionHandler;
+ (id)getHomeListModelWithLinkshref:(NSString *)href CompletionHandler:(void (^)(HomeListModel *model, NSError *error))completionHandler;

+ (id)getCookingStyleModelWithStyle:(CookingStyle)style CompletionHandler:(void (^)(CookingStyleModel *model, NSError *error))completionHandler;

+ (id)getCookingMenuModelWithpage:(NSInteger)page CompletionHandler:(void (^)(YXMenuModel *model, NSError *error))completionHandler;

//
+ (id)getDietMenuModelCompletionHandler:(void(^)(UNDietMenuModel *model,NSError *error))completionHandler;

+ (id)getDietListModelWithMainId:(NSString *)mainId Page:(NSInteger)page CompletionHandler:(void(^)(UNDietListModel *model,NSError *error))completionHandler;

+ (id)getDietaryModelWithPostId:(NSInteger)postId Page:(NSInteger)page CompletionHandler:(void(^)(UNDietaryModel *model,NSError *error))completionHandler;

//+ (id)getDietaryDetailModelWithPostId:(NSInteger)postId Page:(NSInteger)page CompletionHandler:(void(^)(UNDietaryModel *model,NSError *error))completionHandler;
//http://60.205.59.95/v1/dish/info?code=77222477

//新的获取第四数据

+ (id)getDietBaiKeModelWithPage:(NSInteger)page Classes:(NSString *)classes CompletionHandler:(void(^)(UNDietBaiKeModel *model,NSError *error))completionHandler;



@end
