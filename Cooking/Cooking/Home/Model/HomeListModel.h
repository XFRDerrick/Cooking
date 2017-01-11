//
//  HomeListModel.h
//  Cooking
//
//  Created by universe on 2017/1/10.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeListPagingModel,HomeListResultModel;
@interface HomeListModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) HomeListPagingModel *paging;
@property (nonatomic, strong) NSArray<HomeListResultModel *> *result;
@end


@interface HomeListPagingModel : NSObject
/*
 "start":0,
 "next":"/article/list_by_tag/宸濊彍.json?start=100&order=title&offset=100",
 "offset":100
 */
@property (nonatomic, copy) NSString *next;
@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger offset;
@end

@interface HomeListResultModel : NSObject
/*
 "publishAt":"2015-07-17T07:50:34",
 "cooking_time":"三十分钟",
 "likes":528,
 "title":"上汤娃娃菜",
 "taste":"咸鲜",
 "cooking_different":"简单",
 "id":"217878",
 "thumbnail":"http://7vzrq8.com2.z0.glb.qiniucdn.com/article/217878/thumbnail/s160x240.webp"
 },
 */

@property (nonatomic, copy) NSString *publishAt;
@property (nonatomic, copy) NSString *cooking_time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *taste;
@property (nonatomic, copy) NSString *cooking_different;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *resultId;

@end

