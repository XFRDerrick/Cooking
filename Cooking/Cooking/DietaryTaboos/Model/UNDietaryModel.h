//
//  UNDietaryModel.h
//  Cooking
//
//  Created by universe on 2017/1/9.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CookingStyleModel.h"

@class UNDietaryPostsModel;

@interface UNDietaryModel : NSObject

@property (nonatomic, strong) NSArray<CookingStylePostsModel *> *posts;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSInteger cateid;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger count_total;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger exetime;

@end

@interface UNDietaryPostsModel : NSObject

@property (nonatomic, assign) NSInteger pistId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title_plain;
@property (nonatomic, copy) NSString *excerpt;

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *modified;
@property (nonatomic, strong) NSArray *thumbnail;

/*
 "id":842,
 "type":"post",
 "slug":"",
 "url":"http://www.idwoo.net/api/yinshiyiji/get_post/?post_id=842",
 
 "status":"publish",
 "title":"韭菜不宜与白酒同食",
 "title_plain":"韭菜不宜与白酒同食",
 "content":"",
 "excerpt":"有些人在喝白酒时喜欢用韭菜当下酒菜，这种做法是不可取的。《金匮要略》上曾有“饮白酒，食生韭令人增病”的说法，《饮膳正要》中也有“韭不可与酒同食”的",
 "date":"2016-05-27 18:21:52",
 "modified":"2016-05-27 18:21:52",
 "categories":Array[1],
 "tags":Array[0],
 "author":Object{...},
 "comments":Array[0],
 "comment_count":"​0",
 "comment_status":"open",
 "custom_fields":Array[0],
 "thumbnail":"http://sh251.idwoo.cc/pic/food/11.jpg",
 "thumbnail_size":"post-thumbnail",
 "thumbnail_images":Object{...}
 */



@end

