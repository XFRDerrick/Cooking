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
    NSLog(@"收藏的个数count:%ld",datas.count);
    NSMutableArray *modelsArr = [NSMutableArray array];
    for (int i =0; i < datas.count; i++) {
        NSData *data = datas[i];
        HomeListResultModel *dataModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [modelsArr addObject:dataModel];
    }
    model.cookingStyleData = modelsArr;
    
    
    model.recommendData = collections[@"Recommend"];
    model.dietData = collections[@"Diet"];
    model.healthyDietData = collections[@"HealthyDiet"];
    
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
        if (collections[@"Recommend"]) {
            [muArr addObject:(MenuDataModel*)foodModel];
            [collections setValue:muArr forKey:@"Recommend"];
        }else{
            [collections[@"Recommend"] addObject:(MenuDataModel*)foodModel];
        }
        
    }else if ([foodModel isKindOfClass:[UNDietListDataRecipesModel class]]){
        if (collections[@"Diet"]) {
            [muArr addObject:(UNDietListDataRecipesModel*)foodModel];
            [collections setValue:muArr forKey:@"Diet"];
        }else{
             [collections[@"Diet"] addObject:(UNDietListDataRecipesModel*)foodModel];
        }
       
        
    }else if ([foodModel isKindOfClass:[UNDietBaiKeListModel class]]){
        if (collections[@"HealthyDiet"]) {
            [muArr addObject:(UNDietBaiKeListModel*)foodModel];
            [collections setValue:muArr forKey:@"HealthyDiet"];
        }else{
            [collections[@"HealthyDiet"] addObject:(UNDietBaiKeListModel*)foodModel];
        }
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

@end
