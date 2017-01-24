//
//  PlistWorkTools.m
//  Cooking
//
//  Created by universe on 2017/1/16.
//  Copyright © 2017年 universe. All rights reserved.
//

#import "PlistWorkTools.h"

@implementation PlistWorkTools

+ (UNCollectionModel *)readCollectionDatas{

    NSString *pathN = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [pathN stringByAppendingString:@"/collection.plist"];

    UNCollectionModel *model = [[UNCollectionModel alloc] init];
    NSDictionary *collections = [NSDictionary dictionaryWithContentsOfFile:path];
    
    //第一界面的收藏
    NSArray *datas = collections[@"CookingStyle"];
    NSMutableArray *modelsArr = [NSMutableArray array];
    for (int i =0; i < datas.count; i++) {
        NSData *data = datas[i];
        HomeListResultModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [modelsArr addObject:dataModel];
    }
    model.cookingStyleData = modelsArr;
    
     //第二界面的收藏
    NSArray *datas1 = collections[@"Recommend"];
    NSMutableArray *modelsArr1 = [NSMutableArray array];
    for (int i =0; i < datas1.count; i++) {
        NSData *data = datas1[i];
        MenuDataModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [modelsArr1 addObject:dataModel];
    }
    model.recommendData = modelsArr1;
    
    //第三界面的收藏
    NSArray *datas2 = collections[@"Diet"];
    NSMutableArray *modelsArr2 = [NSMutableArray array];
    for (int i =0; i < datas2.count; i++) {
        NSData *data = datas2[i];
        MenuDataModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [modelsArr2 addObject:dataModel];
    }
    model.dietData = modelsArr2;
    
    //第四界面的收藏
    NSArray *datas3 = collections[@"HealthyDiet"];
    NSMutableArray *modelsArr3 = [NSMutableArray array];
    for (int i =0; i < datas3.count; i++) {
        NSData *data = datas3[i];
        MenuDataModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [modelsArr3 addObject:dataModel];
    }
    model.healthyDietData = modelsArr3;
    
    return model;
}

+ (void)collectionFood:(id)foodModel{
    
    //根据路径读取文件
    NSString *pathN = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [pathN stringByAppendingString:@"/collection.plist"];

    NSDictionary *collections = [NSDictionary dictionaryWithContentsOfFile:path];
    NSMutableArray *muArr = [NSMutableArray array];
    
    
    if ([foodModel isKindOfClass:[HomeListResultModel class]]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(HomeListResultModel*)foodModel];
        [muArr addObjectsFromArray:collections[@"CookingStyle"]];
        [muArr addObject:data];
        [collections setValue:muArr forKey:@"CookingStyle"];
        
    }else if ([foodModel isKindOfClass:[MenuDataModel class]]){
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(MenuDataModel*)foodModel];
        [muArr addObjectsFromArray:collections[@"Recommend"]];
        [muArr addObject:data];
        [collections setValue:muArr forKey:@"Recommend"];
        
        
    }else if ([foodModel isKindOfClass:[UNDietListDataRecipesModel class]]){
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(UNDietListDataRecipesModel*)foodModel];
        [muArr addObjectsFromArray:collections[@"Diet"]];
        [muArr addObject:data];
        [collections setValue:muArr forKey:@"Diet"];
        
        
    }else if ([foodModel isKindOfClass:[UNDietBaiKeListModel class]]){
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(UNDietBaiKeListModel*)foodModel];
        [muArr addObjectsFromArray:collections[@"HealthyDiet"]];
        [muArr addObject:data];
        [collections setValue:muArr forKey:@"HealthyDiet"];
    }else{
    }
    NSLog(@"添加收藏");
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSLog(@"文件存在_开始保存");
        NSLog(@"path:%@",path);
        [collections writeToFile:path atomically:YES];
        
    }else{
        NSLog(@"文件不存在");
    }
    
    NSDictionary *collectionFood = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSLog(@"collectionFood:%@ \n-%@", collectionFood,collectionFood[@"CookingStyle"]);
}

+ (void)deleteCollection:(id)foodModel{

    
    //根据路径读取文件
    NSString *pathN = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *path = [pathN stringByAppendingString:@"/collection.plist"];
    //获取
    NSDictionary *collections = [NSDictionary dictionaryWithContentsOfFile:path];

    NSMutableArray *modelsArr = [NSMutableArray array];
    if ([foodModel isKindOfClass:[HomeListResultModel class]]) {
        
        //第一界面的收藏
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(HomeListResultModel*)foodModel];
        NSArray *datas = collections[@"CookingStyle"];
        [modelsArr addObjectsFromArray:datas];
        [modelsArr removeObject:data];
        [collections setValue:modelsArr forKey:@"CookingStyle"];
        
        
    }else if ([foodModel isKindOfClass:[MenuDataModel class]]){
        //第一界面的收藏
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(MenuDataModel*)foodModel];
        NSArray *datas = collections[@"Recommend"];
   
        [modelsArr addObjectsFromArray:datas];
        [modelsArr removeObject:data];
        [collections setValue:modelsArr forKey:@"Recommend"];
        
        
    }else if ([foodModel isKindOfClass:[UNDietListDataRecipesModel class]]){
        
        //第一界面的收藏
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(UNDietListDataRecipesModel*)foodModel];
        NSArray *datas = collections[@"Diet"];

        [modelsArr addObjectsFromArray:datas];
        [modelsArr removeObject:data];
        [collections setValue:modelsArr forKey:@"Diet"];

    }else if ([foodModel isKindOfClass:[UNDietBaiKeListModel class]]){
        
        //第一界面的收藏
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:(UNDietBaiKeListModel*)foodModel];
        NSArray *datas = collections[@"HealthyDiet"];
        [modelsArr addObjectsFromArray:datas];
        [modelsArr removeObject:data];
        [collections setValue:modelsArr forKey:@"HealthyDiet"];

    }else{
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [collections writeToFile:path atomically:YES];
    }else{
        NSLog(@"文件不存在");
    }
    
}

@end
