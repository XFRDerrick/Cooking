//
//  CookingStyleModel.h
//  Cooking
//
//  Created by universe on 2017/1/6.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CookingStylePostsModel;
@interface CookingStyleModel : NSObject
/*
 "status":"ok",
 "count":100,
 "count_total":120,
 "page":0,
 "pages":2,
 "posts":Array[100],
 "exetime":0.084815979003906
 */

@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger count_total;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, strong) NSArray<CookingStylePostsModel *> *posts;
@end

@interface CookingStylePostsModel : NSObject

@property (nonatomic, assign) NSInteger postsID;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *slug;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title_plain;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *excerpt;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *modified;

@property (nonatomic, copy) NSString *thumbnail;

/*@property (nonatomic, copy) NSString *title;
 "id":1107,
 "type":"post",
 "slug":"",
 "url":"http://www.idwoo.net/api/chuancai/get_post/?post_id=1107",
 "status":"publish",
 "title":"干锅茶树菇--如何获得极致口感",
 "title_plain":"干锅茶树菇--如何获得极致口感",
 "content":"",
 "excerpt":"难度：配菜(中级) 时间：10~30分钟主料新鲜茶树菇约250g青红椒丝洋葱丝葱段姜片花椒干辣椒老干妈和豆瓣酱可以二选一蚝油味极鲜料酒五花肉丝大蒜小米辣葱花香菜段盐 干锅茶",
 "date":"2016-06-05 17:44:19",
 "modified":"2016-06-05 17:44:19",
 "categories":Array[1],
 "tags":Array[0],
 "author":Object{...},
 "comments":Array[0],
 "comment_count":"​0",
 "comment_status":"open",
 "custom_fields":Array[0],
 "thumbnail":"http://imgcnd.idwoo.cc/hz3/2016-06-06/gdybh4a03bd.jpg",
 "thumbnail_size":"post-thumbnail",
 "thumbnail_images":Object{...}
 */




@end
