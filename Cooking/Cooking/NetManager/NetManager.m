//
//  NetManager.m
//  PublicNews
//
//  Created by universe on 2016/12/2.
//  Copyright © 2016年 universe. All rights reserved.
//

#import "NetManager.h"

@implementation NetManager

//home Menu
+ (id)getHomeMenuModelCompletionHandler:(void (^)(HomeMenuModel *, NSError *))completionHandler{
 
    NSString *path = kHomeBasePath;
    return [self GET:path paramaters:nil completionHandler:^(id respondObj, NSError *error) {
         !completionHandler ?: completionHandler([HomeMenuModel parse:respondObj],error);
    }];
}

+ (id)getHomeListModelWithLinkshref:(NSString *)href CompletionHandler:(void (^)(HomeListModel *, NSError *))completionHandler{
   
    NSString *path = [NSString stringWithFormat:@"%@%@",kHomeListBasePath,href];
    //包含中文
    NSString *str1 = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return [self GET:str1 paramaters:nil completionHandler:^(id respondObj, NSError *error) {
        !completionHandler ?: completionHandler([HomeListModel parse:respondObj],error);
    }];
    
}

+ (id)getCookingStyleModelWithStyle:(CookingStyle)style CompletionHandler:(void (^)(CookingStyleModel *, NSError *))completionHandler{
    
    NSString *middleStr = nil;
    switch (style) {
            case CookingStyleYueCai:
            middleStr = @"yuecai";
            break;
            case CookingStyleChuanCai:
            middleStr = @"chuancai";
            break;
            case CookingStyleSuCai:
            middleStr = @"sucai";
            break;
            case CookingStyleZheCai:
            middleStr = @"zhicai";
            break;
            case CookingStyleMinCai:
            middleStr = @"mincai";
            break;
            case CookingStyleHuiCai:
            middleStr = @"huicai";
            break;
            case CookingStyleLuCai:
            middleStr = @"lucai";
            break;
            case CookingStyleShangHaiCai:
            middleStr = @"shangcai";
            break;
            case CookingStyleDongBeiCai:
            middleStr = @"dongbeijiacaipu";
            break;
            case CookingStyleHongBei:
            middleStr = @"hongpei";
            break;
        default:
            break;
    }
    NSString *path = [NSString stringWithFormat:@"%@%@%@",kCookingStyleBasePathHeader,middleStr,kCookingStyleBasePathFoot];
    
    return [self GET:path paramaters:nil completionHandler:^(id respondObj, NSError *error) {
           !completionHandler ?: completionHandler([CookingStyleModel parse:respondObj],error);
    }];
}

/*
 
 */

+ (id)getCookingMenuModelWithpage:(NSInteger)page CompletionHandler:(void (^)(YXMenuModel *, NSError *))completionHandler{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@(page) forKey:@"currentPage"];
    [dic setValue:@(20) forKey:@"pageSize"];
    [dic setValue:@"" forKey:@"name"];
    [dic setValue:@"" forKey:@"categoryId"];
    [dic setValue:@"" forKey:@"parentId"];
    [dic setValue:@"" forKey:@"screeningId"];
    [dic setValue:@"" forKey:@"tagId"];
    [dic setValue:@"" forKey:@"username"];
    [dic setValue:@"" forKey:@"password"];
    
    return [self GET:kDayDayCookPath paramaters:dic completionHandler:^(id respondObj, NSError *error) {
         !completionHandler ?: completionHandler([YXMenuModel  parse:respondObj],error);
    }];
    
}

+ (id)getDietMenuModelCompletionHandler:(void (^)(UNDietMenuModel *, NSError *))completionHandler{

    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"tianjianfeishipu" forKey:@"appname"];
    return [self POST:KDietMenuPath paramaters:dic completionHandler:^(id respondObj, NSError *error) {
        !completionHandler ?: completionHandler([UNDietMenuModel  parse:respondObj],error);
    }];
   
}

+ (id)getDietListModelWithMainId:(NSString *)mainId Page:(NSInteger)page CompletionHandler:(void (^)(UNDietListModel *, NSError *))completionHandler{
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@"tianjianfeishipu" forKey:@"appname"];
    [dic setValue:mainId forKey:@"mainId"];
    [dic setValue:@(page) forKey:@"page"];
    
    return [self POST:KDietListBasePath paramaters:dic completionHandler:^(id respondObj, NSError *error) {
        !completionHandler ?: completionHandler([UNDietListModel  parse:respondObj],error);
    }];
    //?appname=tianjianfeishipu&mainId=%@&page=%ld
    
}

//饮食禁忌
+ (id)getDietaryModelWithPostId:(NSInteger)postId Page:(NSInteger)page CompletionHandler:(void (^)(UNDietaryModel *, NSError *))completionHandler{
    
    //?id=334&page=1&dev=1
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:@(postId) forKey:@"id"];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@"1" forKey:@"dev"];
    
    return [self GET:KDietaryPath paramaters:dic completionHandler:^(id respondObj, NSError *error) {
        !completionHandler ?: completionHandler([UNDietaryModel  parse:respondObj],error);
    }];
}


+ (id)getDietBaiKeModelWithPage:(NSInteger)page Classes:(NSString *)classes CompletionHandler:(void (^)(UNDietBaiKeModel *, NSError *))completionHandler{
    
    //http://carapi.hbook.us/app/infolist?appid=621&page=2&classes=病人饮食
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setValue:classes forKey:@"classes"];
    [dic setValue:@(page) forKey:@"page"];
    
    return [self GET:kDietBaikeBasePath paramaters:dic completionHandler:^(id respondObj, NSError *error) {
        !completionHandler ?: completionHandler([UNDietBaiKeModel  parse:respondObj],error);
    }];
}


@end
