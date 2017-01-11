//
//  UNDietBaiKeModel.h
//  Cooking
//
//  Created by universe on 2017/1/11.
//  Copyright © 2017年 universe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UNDietBaiKeListModel;

@interface UNDietBaiKeModel : NSObject

//"errorcode":0,
//"list":Array[20],
//"totalcount":120
@property (nonatomic, assign) NSInteger errorcode;
@property (nonatomic, assign) NSInteger totalcount;
@property (nonatomic, strong) NSArray<UNDietBaiKeListModel *> *list;
@end

@interface UNDietBaiKeListModel : NSObject


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

/*
 "id":90845,
 "title":"血小板减少病人饮食面面观",
 "img":"http://i1.go2yd.com/image.php?url=0EXeZMfUkn",
 "addtimedesc":"2016-09-28",
 "clickcount":1,
 */

@end
